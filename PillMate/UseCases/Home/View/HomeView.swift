//
//  HomeView.swift
//  PillMate
//
//  Created by Andres Aleu on 18/3/25.
//

import SwiftUI
import SwiftData
import Charts

struct HomeView: View {
    
    @ObservedObject var vm: HomeVM
    @State var openSheet: Bool
    @Environment(\.modelContext) var context
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var lnManager: LocalNotificationManager
    @Query private var doses: [ScheduledDose]
    
    init(vm: HomeVM, openSheet: Bool = false, lnManager: LocalNotificationManager) {
        self.vm = vm
        self.openSheet = openSheet
        self.lnManager = lnManager
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)
        let predicate = #Predicate <ScheduledDose> { item in
            item.scheduledTime >= startOfDay && item.scheduledTime < endOfDay!
        }
        _doses = Query(filter: predicate, sort: \ScheduledDose.scheduledTime)
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List {
                Section {
                    if doses.count == 0 {
                        VStack {
                            Text(Strings.notMedication)
                                
                                .foregroundStyle(Color(hex: Colors.primary))
                                .bold()
                        }
                    } else {
                    ForEach(doses, id: \.id) { dose in
                        TodayAndNextDoseMedicationView(nameMedication: dose.medication.medicationName, timeMedication: dose.scheduledTime, doseMedication: dose.medication.medicationDose, presentationMedication: dose.medication.medicationPresentation, statusDose: dose.status)
                        
                            .listRowSeparator(.hidden)
                            .onTapGesture {
                                dose.status = true
                                vm.updateDoseCount(doses)
                                vm.indicationDoses(dose)
                            }
                    }
                }
                } header: {
                    Text(Strings.medicationToday)
                        .font(.title)
                        .foregroundStyle(Color(hex: Colors.primary))
                        .bold()
                    
                    
                }
                
                Section {
                    if vm.scheduledDose.count == 0 {
                        VStack {
                            Text(Strings.notNextDoses)
                                
                                .foregroundStyle(Color(hex: Colors.primary))
                                .bold()
                            
                        }
                    } else {
                        ForEach(vm.scheduledDose, id: \.id) { dosis in
                            
                            TodayAndNextDoseMedicationView(nameMedication: dosis.medication.medicationName, timeMedication: dosis.scheduledTime, doseMedication: dosis.medication.medicationDose, presentationMedication: dosis.medication.medicationPresentation)
                        }
                        .listRowSeparator(.hidden)

                    }
                    
                    
                } header: {
                    Text(Strings.nextDoses)
                        .font(.title)
                        .foregroundStyle(Color(hex: Colors.primary))
                        .bold()
                }
                
                Section {
                    if doses.count == 0 {
                        VStack {
                            Text(Strings.notMedication)
                             
                                .foregroundStyle(Color(hex: Colors.primary))
                                .bold()
                        
                        }
                    } else {
                    VStack(spacing: 20) {
                        Text("\(vm.scheduledDoseCount.count)/\(doses.count)")
                            .font(.title2)
                            .bold()
                            .listRowSeparator(.hidden)
                        Chart {
                            SectorMark(
                                angle: .value("", Double(doses.filter { $0.status }.count)),
                                innerRadius: .ratio(0.4), // Anillo interno
                                outerRadius: .ratio(1)  // Anillo externo
                            )
                            .foregroundStyle(.green)
                            SectorMark(
                                angle: .value("", Double(doses.filter { !$0.status }.count)),
                                innerRadius: .ratio(0.4), // Anillo interno
                                outerRadius: .ratio(1)  // Anillo externo
                            )
                            .foregroundStyle(.red)
                        }
                    }
                }
                    
                    
                    
                    
                } header: {
                    Text(Strings.indicatorDoses)
                        .font(.title)
                        .foregroundStyle(Color(hex: Colors.primary))
                        .bold()
                }
            }
            .listStyle(.insetGrouped)
            .onAppear {
                vm.filterNextDose(doses)
            }
            FloatingActionButtonView(imageName: "plus", action: { openSheet.toggle()})
                .padding()
        }
        .sheet(isPresented: $openSheet, onDismiss: {
            vm.filterNextDose(doses)
        }) {
            SaveReminderFormView(model: $vm.medicationModel, context: context)
        }
       
        .task {
         try? await lnManager.requestAuthorization()
        }
        .alert(StringsAlert.notPermissionNotification, isPresented: $lnManager.isAuthorized) {
            Button(StringsAlert.buttonAccept) { }
            Button(StringsAlert.openSettings) {
                Task {
                  await  lnManager.openSettings()
                }
            }
        }
        .onChange(of: scenePhase) { _, newValue in
            if newValue == .active {
                Task {
                    try? await lnManager.requestAuthorization()
                   
                }
            }
        }
    }
}

#Preview {
    let preview = Preview()
    preview.addExamples(ScheduledDose.sampleItems)
    
   return  HomeView(vm: HomeVM(), openSheet: false, lnManager: LocalNotificationManager())
        .modelContainer(preview.container)
      
}
