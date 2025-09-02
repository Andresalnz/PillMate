//
//  HomeVM.swift
//  PillMate
//
//  Created by Andres Aleu on 20/3/25.
//

import Foundation


class HomeVM: ObservableObject {
   
    @Published var medicationModel: MedicationModel = MedicationModel(name: "", presentation: .pills, dose: "", frequency: .daily, timePerDay: 1, everyXDays: 2, days: [], firstDoseTime: Date(), momentDose: .afterMeal, customInstructions: "", treatmentStartDate: Date(), treatmentEndDate: Date(), treatmentDuration: .untilSpecificDate, treatmentEndforNumberOfDays: Date(), notes: "")
    @Published var scheduledDose: [ScheduledDose] = []
    @Published var scheduledDoseCount: [ScheduledDose] = []
    private let database: DatabaseProtocol? = nil
    var medication: InformationMedication? = nil
    
    func filterNextDose(_ dosesToday: [ScheduledDose]) {
        scheduledDose = dosesToday.filter({$0.scheduledTime >= Date() && $0.status != true }).sorted(by: {$0.scheduledTime < $1.scheduledTime})
    }
    
    func updateDoseCount(_ dosesToday: [ScheduledDose]) {
        scheduledDoseCount = dosesToday.filter({$0.status == true })
    }
    
    @MainActor
    func indicationDoses(_ dosesToday: ScheduledDose)  {
        do {
            
            try  database?.update(scheduleDose: dosesToday, medication: dosesToday.medication)
            
            
        } catch let error {
            print("Error saving medication: \(error)")
        }
        filterNextDose(scheduledDose)
    }
}
