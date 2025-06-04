//
//  HomeView.swift
//  PillMate
//
//  Created by Andres Aleu on 18/3/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @State var md: MedicationModel
    @State var openSheet: Bool
    
    @StateObject var vm: HomeVM
    
    @Environment(\.modelContext) var context
    
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack() {
                ReminderCalendarView(viewModel: ReminderCalendarVM(month: "Enero", numberMonth: 0, days: [1,2,3,4,5,6,7], numberWeekDay: 2))
                List {
                    ReminderCellView()
                }
                .listStyle(.plain)
            }
            FloatingActionButtonView(imageName: "plus", action: { openSheet.toggle()})
                .padding()
        }
        .sheet(isPresented: $openSheet) {
            SaveReminderFormView(model: $md, onSave: {
                Task {
                    await vm.save(medication: md)
                }
            })
        }
    }
}

#Preview {
    @Previewable @State var md: MedicationModel = MedicationModel(id: UUID() , name: "", presentation: .pills, dose: "", frequency: .daily, timePerDay: 1, everyXDays: 1, days: [], firstDoseTime: .now, momentDose: .afterMeal, customInstructions: "", treatmentStartDate: .now, treatmentEndDate: .now, treatmentDuration: .untilSpecificDate, numbersOfDays: 7, treatmentEndforNumberOfDays: Date(), notes: "")
    @Previewable @Environment(\.modelContext)  var context
    
    HomeView(md: md, openSheet: false, vm: HomeVM(database: MedicationDatabase(context: context)))
}
