//
//  HomeVM.swift
//  PillMate
//
//  Created by Andres Aleu on 20/3/25.
//

import Foundation


class HomeVM: ObservableObject {
    
    private let database: DatabaseProtocol
    
    init(database: DatabaseProtocol) {
        self.database = database
    }
    
    @MainActor
    func save(medication: MedicationModel) async {
        do {
            let md: InformationMedication = InformationMedication(id: medication.id, medicationName: medication.name, medicationPresentation: medication.presentation.rawValue, medicationDose: medication.dose, medicationFrequency: medication.frequency.rawValue, medicationtTimePerDay: medication.timePerDay, medicationEveryXDays: medication.everyXDays, medicationDays: medication.days.map { $0.rawValue }, medicationFirstDoseTime: medication.firstDoseTime, medicationLastDoseTime: .now, medicationMomentDose: medication.momentDose.rawValue, medicationCustomInstructions: medication.customInstructions, medicationTreatmentStartDate: medication.treatmentStartDate, medicationTreatmentEndDate: medication.treatmentEndDate, treatmentDuration: medication.treatmentDuration.rawValue, numbersOfDays: medication.numbersOfDays, treatmentEndforNumberOfDays: medication.treatmentEndforNumberOfDays, notes: medication.notes)
            
            var dosesToSave: [ScheduledDose] = []
            
            let dayTreamentStart = Calendar.current.dateComponents([.day, .month], from: medication.treatmentStartDate)
            let dayTreamentEnd = Calendar.current.dateComponents([.day], from: medication.treatmentEndDate)
            let daysinTome: Int = (dayTreamentEnd.day! - dayTreamentStart.day! + 1) * medication.timePerDay
            
            let dateComponents = DateComponents(year: 2025, month: dayTreamentStart.month!, day: dayTreamentStart.day!)
            var date: Date = Calendar.current.date(from: dateComponents)!
            
            
            var sch = ScheduledDose(id: UUID(), scheduledTime: date, status: "active", nitificacionIdentifier: "", medication: md)
            dosesToSave.append(sch)
            
            for _ in 0..<daysinTome {
                let newTome = Calendar.current.date(byAdding: .hour, value: 8, to: date)!
                date = newTome
                
                let newsch = ScheduledDose(id: UUID(), scheduledTime: newTome, status: "active", nitificacionIdentifier: "", medication: md)
                dosesToSave.append(newsch)
            }
            try await database.saveMediaction(md, scheduleDose: dosesToSave)
            
        } catch let err {
            print(err)
        }
    }
}
