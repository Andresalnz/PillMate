//
//  FormMedicationVM.swift
//  PillMate
//
//  Created by Andres Aleu on 6/6/25.
//

import Foundation


final class FormMedicationVM: ObservableObject {
    
    private let database: DatabaseProtocol
    private let notification: LocalNotificationProtocol
    var componentToAdd: Calendar.Component
    var valueToAdd: Int
    var md: InformationMedication?
    
    init(database: DatabaseProtocol, notification: LocalNotificationProtocol, componentToAdd: Calendar.Component = .day, valueToAdd: Int = 0, md: InformationMedication? = nil) {
        self.database = database
        self.notification = notification
        self.componentToAdd = componentToAdd
        self.valueToAdd = valueToAdd
        self.md = md
    }
    
    func daysBetween(startDate: Date, endDate: Date) -> Int {
        let calendar = Calendar.current
        
        let startOfDay = calendar.startOfDay(for: startDate)
        let endOfDay = calendar.startOfDay(for: endDate)
        let components = calendar.dateComponents([.day, .month], from: startOfDay, to: endOfDay)

        return components.day!
    }
    
    @MainActor
    func save(medication: MedicationModel) async {
        do {
            md = InformationMedication(medicationName: medication.name, medicationPresentation: medication.presentation.rawValue, medicationDose: medication.dose, medicationFrequency: medication.frequency.rawValue, medicationtTimePerDay: medication.timePerDay, medicationEveryXDays: medication.everyXDays, medicationDays: [], medicationFirstDoseTime: medication.firstDoseTime, medicationMomentDose: medication.momentDose.rawValue.lowercased(), medicationCustomInstructions: medication.customInstructions, medicationTreatmentStartDate: medication.treatmentStartDate, medicationTreatmentEndDate: medication.treatmentEndDate, treatmentDuration: medication.treatmentDuration.rawValue, numbersOfDays: medication.numbersOfDays, treatmentEndforNumberOfDays: medication.treatmentEndforNumberOfDays, notes: medication.notes)
  
            var dosesToSave: [ScheduledDose] = []
            
            let dayTreamentStart = Calendar.current.dateComponents([.day, .month], from: medication.treatmentStartDate)
            let hourTreamentStart = Calendar.current.dateComponents([.hour, .minute, .second], from: medication.firstDoseTime)
    
            let dateComponents = DateComponents(year: 2025, month: dayTreamentStart.month!, day: dayTreamentStart.day!, hour: hourTreamentStart.hour, minute: hourTreamentStart.minute, second: hourTreamentStart.second)
            var date: Date = Calendar.current.date(from: dateComponents)!
            
            let sch = ScheduledDose(id: UUID(), scheduledTime: date, status: false, nitificacionIdentifier:  UUID().uuidString, medication: md!)
            
            dosesToSave.append(sch)
            switch medication.timePerDay {
                case 1:
                    componentToAdd = .day
                    valueToAdd = 1
                case 2:
                    componentToAdd = .hour
                    valueToAdd = 12
                case 3:
                    componentToAdd = .hour
                    valueToAdd = 8
                default:
                    break
            }
            let daysinTome: Int = daysBetween(startDate: medication.treatmentStartDate, endDate: medication.treatmentEndDate) * medication.timePerDay
            if let newTome = Calendar.current.date(byAdding: componentToAdd, value: valueToAdd, to: date) {
                date = newTome
                let newsch = ScheduledDose(id: UUID(), scheduledTime: newTome, status: false, nitificacionIdentifier:  UUID().uuidString, medication: md!)
                dosesToSave.append(newsch)
            }
            for _ in 0...daysinTome {
                if let newTome = Calendar.current.date(byAdding: componentToAdd, value: valueToAdd, to: date) {
                    date = newTome
                    let newsch = ScheduledDose(id: UUID(), scheduledTime: newTome, status: false, nitificacionIdentifier:  UUID().uuidString, medication: md!)
                    dosesToSave.append(newsch)
                }
            }
            try await database.saveMediaction(md!, scheduleDose: dosesToSave)
            await notification.scheduleNotification(modelSchedule: dosesToSave, medication: md!)
            dosesToSave = []
            
        } catch let err {
            print(err)
        }
    }
}
