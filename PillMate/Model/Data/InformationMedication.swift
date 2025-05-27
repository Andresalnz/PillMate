//
//  InformationMedication.swift
//  PillMate
//
//  Created by Andres Aleu on 27/5/25.
//

import Foundation
import SwiftData


@Model
final class InformationMedication: Identifiable, Hashable, @unchecked Sendable {
    @Attribute(.unique) var id: UUID
    var medicationName: String
    var medicationPresentation: String
    var medicationDose: String //Guarda, por ejemplo. (1 comprimido)
    var medicationFrequency: String
    var medicationtTimePerDay: Int
    var medicationEveryXDays: Int
    var medicationDays: [String]
    var medicationFirstDoseTime: Date
    var medicationLastDoseTime: Date
    var medicationMomentDose: String
    var medicationCustomInstructions: String
    var medicationTreatmentStartDate: Date
    var medicationTreatmentEndDate: Date
    var treatmentDuration: String
    var numbersOfDays: Int
    var treatmentEndforNumberOfDays: Date
    var notes: String
    
    @Relationship(deleteRule: .cascade, inverse: \ScheduledDose.medication)
    var scheduledDoses: [ScheduledDose]
    
    init(id: UUID, medicationName: String, medicationPresentation: String, medicationDose: String, medicationFrequency: String, medicationtTimePerDay: Int, medicationEveryXDays: Int, medicationDays: [String], medicationFirstDoseTime: Date, medicationLastDoseTime: Date, medicationMomentDose: String, medicationCustomInstructions: String, medicationTreatmentStartDate: Date, medicationTreatmentEndDate: Date, treatmentDuration: String, numbersOfDays: Int, treatmentEndforNumberOfDays: Date, notes: String, scheduledDoses: [ScheduledDose]) {
        self.id = id
        self.medicationName = medicationName
        self.medicationPresentation = medicationPresentation
        self.medicationDose = medicationDose
        self.medicationFrequency = medicationFrequency
        self.medicationtTimePerDay = medicationtTimePerDay
        self.medicationEveryXDays = medicationEveryXDays
        self.medicationDays = medicationDays
        self.medicationFirstDoseTime = medicationFirstDoseTime
        self.medicationLastDoseTime = medicationLastDoseTime
        self.medicationMomentDose = medicationMomentDose
        self.medicationCustomInstructions = medicationCustomInstructions
        self.medicationTreatmentStartDate = medicationTreatmentStartDate
        self.medicationTreatmentEndDate = medicationTreatmentEndDate
        self.treatmentDuration = treatmentDuration
        self.numbersOfDays = numbersOfDays
        self.treatmentEndforNumberOfDays = treatmentEndforNumberOfDays
        self.notes = notes
        self.scheduledDoses = scheduledDoses
    }
}

