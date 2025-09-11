//
//  SaveReminderFormView.swift
//  PillMate
//
//  Created by Andres Aleu on 20/3/25.
//

import SwiftUI
import SwiftData

struct SaveReminderFormView: View {
    
    @Binding var model: MedicationModel 
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: FormMedicationVM
    @Query private var doses: [ScheduledDose]
    @State var showAlertError: Bool = false
    
    var disabledButtonSave: Bool {
        if model.name != "" && model.dose != ""  {
            return false
        }
        return true
    }
    
    init(model: Binding<MedicationModel>, context: ModelContext) {
        self._model = model
        let service = MedicationDatabase(context: context)
        let notification = LocalNotificationManager()
        self._viewModel = StateObject(wrappedValue: FormMedicationVM(database: service, notification: notification))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Información del medicamento") {
                    TextField("Nombre del medicamento", text: $model.name)
                    
                    Picker("Presentación", selection: $model.presentation) {
                        ForEach(MedicationPresentation.allCases) { presentation in
                            Text(presentation.rawValue).tag(presentation)
                        }
                    }
                    
                    HStack {
                        TextField(model.presentation.placeholder, text: $model.dose)
                            .keyboardType(.numberPad)
                        if !model.presentation.unit.isEmpty {
                            Text(model.presentation.unit)
                                .font(.callout)
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Section("Frecuencia y horarios") {
                    Picker("Frecuencia", selection: $model.frequency) {
                        ForEach(FrequencyType.allCases) { frequecy in
                            Text(frequecy.rawValue).tag(frequecy)
                        }
                    }
                    
                    Stepper("Tomas al día: \(model.timePerDay)", value: $model.timePerDay, in: 1...3)
                    
                    
                    DatePicker("Hora de la primera dosis", selection: $model.firstDoseTime, displayedComponents: .hourAndMinute)
                }
                
                Section("Instrucciones de Toma") {
                    Picker("Momento de toma", selection: $model.momentDose) {
                        ForEach(MomentDose.allCases) { moment in
                            Text(moment.rawValue).tag(moment)
                        }
                    }
                    
                    TextField("Instrucciones adicionales (ej: con un vaso de agua)", text: $model.customInstructions, axis: .vertical)
                        .lineLimit(2...)
                }
                
                Section("Duración del tratamiento") {
                    DatePicker("Fecha de inicio del tratamiento", selection: $model.treatmentStartDate, displayedComponents: .date)
                    
                    Picker("Duración", selection: $model.treatmentDuration) {
                        ForEach(TreatmentDuration.allCases) { duration in
                            Text(duration.rawValue).tag(duration)
                        }
                    }
                    
                    DatePicker("Fecha de finalización del tratamiento", selection: $model.treatmentEndDate, in: model.treatmentStartDate..., displayedComponents: .date)
                    
                }
            }
            .navigationTitle("Nuevo medicamento")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        print("Save")
                        if doses.contains(where: { $0.medication.medicationName == model.name }) {
                            showAlertError = true
                        } else {
                            Task {
                                await viewModel.save(medication: model)
                            }
                            
                            dismiss()
                        }
                        
                        
                    }
                    .disabled(disabledButtonSave)
                    .bold()
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                   
                    }
                }
            }
        }
        .alert("Ese medicamento ya ha sido guardado", isPresented: $showAlertError) {
            Button(StringsAlert.buttonAccept) {
                model.name = ""
                model.dose = ""
                dismiss()
            }
        }
    }
}

#Preview {
    @Previewable @Environment(\.modelContext)  var context
    @Previewable @State var md: MedicationModel = MedicationModel(id: UUID() , name: "", presentation: .pills, dose: "", frequency: .daily, timePerDay: 1, everyXDays: 1, days: [], firstDoseTime: .now, momentDose: .afterMeal, customInstructions: "", treatmentStartDate: .now, treatmentEndDate: .now, treatmentDuration: .untilSpecificDate, numbersOfDays: 7, treatmentEndforNumberOfDays: Date(), notes: "")
    
    let preview = Preview()
    
    
    preview.addExamples(ScheduledDose.sampleItems)
   return SaveReminderFormView(model: $md, context: context)
        .modelContainer(preview.containerPreview)
}
