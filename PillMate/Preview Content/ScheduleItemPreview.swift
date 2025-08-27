//
//  ScheduleItemPreview.swift
//  PillMate
//
//  Created by Andres Aleu on 6/8/25.
//

import Foundation

extension ScheduledDose {
 
    static var sampleItems: [ScheduledDose] {
        [
            ScheduledDose(id: UUID(), scheduledTime:Calendar.current.date(from: DateComponents(year: 2025, month: 8, day: 26,hour: 22, minute: 00))!, status: false, nitificacionIdentifier: "uno", medication: InformationMedication(medicationName: "Nou te vayas", medicationPresentation: "pastillas", medicationDose: "1", medicationFrequency: "cada día", medicationtTimePerDay: 3, medicationFirstDoseTime: Date(), medicationMomentDose: "Despues de comer", medicationCustomInstructions: "Con agua", medicationTreatmentStartDate: Date(), treatmentDuration: "")),
            ScheduledDose(id: UUID(), scheduledTime: Date(), status: false, nitificacionIdentifier: "dos", medication: InformationMedication(medicationName: "Amoxicilina", medicationPresentation: "pastillas", medicationDose: "1", medicationFrequency: "cada día", medicationtTimePerDay: 3, medicationFirstDoseTime: Date(), medicationMomentDose: "Despues de comer", medicationCustomInstructions: "Con agua", medicationTreatmentStartDate: Date(), treatmentDuration: "")),
            ScheduledDose(id: UUID(), scheduledTime: Calendar.current.date(from: DateComponents(year: 2025, month: 8, day: 26,hour: 23, minute: 00))!, status: false, nitificacionIdentifier: "tres", medication: InformationMedication(medicationName: "andy", medicationPresentation: "pastillas", medicationDose: "1", medicationFrequency: "cada día", medicationtTimePerDay: 3, medicationFirstDoseTime: Date(), medicationMomentDose: "Despues de comer", medicationCustomInstructions: "Con agua", medicationTreatmentStartDate: Date(), treatmentDuration: "")),
            ScheduledDose(id: UUID(), scheduledTime: Date(), status: false, nitificacionIdentifier: "cuatro", medication: InformationMedication(medicationName: "Omeprazol", medicationPresentation: "pastillas", medicationDose: "1", medicationFrequency: "cada día", medicationtTimePerDay: 3, medicationFirstDoseTime: Date(), medicationMomentDose: "Despues de comer", medicationCustomInstructions: "Con agua", medicationTreatmentStartDate: Date(), treatmentDuration: "")),
            ScheduledDose(id: UUID(), scheduledTime: Date(), status: false, nitificacionIdentifier: "cinco", medication: InformationMedication(medicationName: "Amoxicilina", medicationPresentation: "pastillas", medicationDose: "1", medicationFrequency: "cada día", medicationtTimePerDay: 3, medicationFirstDoseTime: Date(), medicationMomentDose: "Despues de comer", medicationCustomInstructions: "Con agua", medicationTreatmentStartDate: Date(), treatmentDuration: ""))
        ]
    }
}
