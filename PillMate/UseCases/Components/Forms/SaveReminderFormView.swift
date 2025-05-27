//
//  SaveReminderFormView.swift
//  PillMate
//
//  Created by Andres Aleu on 20/3/25.
//

import SwiftUI

struct SaveReminderFormView: View {
    
    @Binding var model: MedicationModel
    @Environment(\.dismiss) var dismiss
    
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
                    
                    switch model.frequency {
                        case .daily, .alternateDays:
                            Stepper("Tomas al día: \(model.timePerDay)", value: $model.timePerDay, in: 1...10)
                            
                        case .specificWeekdays:
                            Stepper("Tomas esos días: \(model.timePerDay)", value: $model.timePerDay, in: 1...10)
                            Text("Seleccionar días:").font(.caption).foregroundColor(.gray)
                            ForEach(WeekdayDays.allCases) { day in
                                Toggle(day.rawValue, isOn: Binding(get: {
                                    model.days.contains(day)
                                }, set: { isOn in
                                    if isOn {
                                        model.days.insert(day)
                                    } else {
                                        model.days.remove(day)
                                    }
                                }))
                            }
                            
                            if model.days.isEmpty {
                                Text("Por favor, selecciona al menos un día.")
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                            
                        case .everyXDays:
                            Stepper("Cada \(model.everyXDays) días", value: $model.everyXDays, in: 1...30)
                            Stepper("Tomas al día: \(model.timePerDay)", value: $model.timePerDay, in: 1...10)
                    }
                    
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
                    
                    if model.treatmentDuration == .forNumberOfDays {
                        Stepper("Durante \(model.numbersOfDays) días", value: $model.numbersOfDays, in: 1...365)
                            .onChange(of: model.numbersOfDays) { _, newValue in
                                model.treatmentEndforNumberOfDays = Calendar.current.date(byAdding: .day, value: newValue, to: model.treatmentStartDate) ?? Date()
                            }
                        
                        Text("Finalizará el: \(model.treatmentEndforNumberOfDays, style: .date)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                    } else if model.treatmentDuration == .untilSpecificDate {
                        DatePicker("Fecha de finalización del tratamiento", selection: $model.treatmentEndDate, in: model.treatmentStartDate..., displayedComponents: .date)
                    }
                }
                
                Section("Notas Adicionales") {
                    TextField("Notas (ej: efectos secundarios, médico que lo recetó)", text: $model.notes, axis: .vertical)
                        .lineLimit(3...)
                }
            }
            .navigationTitle("Nuevo medicamento")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        print("Save")
                        dismiss()
                    }
                    .bold()
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                   
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var md: MedicationModel = MedicationModel(id: UUID() , name: "", presentation: .pills, dose: "", frequency: .daily, timePerDay: 1, everyXDays: 1, days: [], firstDoseTime: .now, momentDose: .afterMeal, customInstructions: "", treatmentStartDate: .now, treatmentEndDate: .now, treatmentDuration: .untilSpecificDate, numbersOfDays: 7, treatmentEndforNumberOfDays: Date(), notes: "")
    SaveReminderFormView(model: $md)
}
