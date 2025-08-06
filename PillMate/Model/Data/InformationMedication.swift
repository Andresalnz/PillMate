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
    @Attribute(.unique) var id: UUID = UUID()
    var medicationName: String
    var medicationPresentation: String
    var medicationDose: String
    var medicationFrequency: String
    var medicationtTimePerDay: Int
    var medicationEveryXDays: Int?
    var medicationDays: [WeekdayDays]?
    var medicationFirstDoseTime: Date
    //var medicationLastDoseTime: Date
    var medicationMomentDose: String
    var medicationCustomInstructions: String
    var medicationTreatmentStartDate: Date
    var medicationTreatmentEndDate: Date?
    var treatmentDuration: String
    var numbersOfDays: Int?
    var treatmentEndforNumberOfDays: Date?
    var notes: String?
    
    @Relationship(deleteRule: .cascade, inverse: \ScheduledDose.medication)
    var scheduledDoses: [ScheduledDose]?
    
    init(id: UUID = UUID(), medicationName: String, medicationPresentation: String, medicationDose: String, medicationFrequency: String, medicationtTimePerDay: Int, medicationEveryXDays: Int? = nil, medicationDays: [WeekdayDays]? = nil, medicationFirstDoseTime: Date,  medicationMomentDose: String, medicationCustomInstructions: String, medicationTreatmentStartDate: Date, medicationTreatmentEndDate: Date? = nil, treatmentDuration: String, numbersOfDays: Int? = nil, treatmentEndforNumberOfDays: Date? = nil, notes: String? = nil, scheduledDoses: [ScheduledDose]? = nil) {
        self.id = UUID()
        self.medicationName = medicationName
        self.medicationPresentation = medicationPresentation
        self.medicationDose = medicationDose
        self.medicationFrequency = medicationFrequency
        self.medicationtTimePerDay = medicationtTimePerDay
        self.medicationEveryXDays = medicationEveryXDays
        self.medicationDays = medicationDays
        self.medicationFirstDoseTime = medicationFirstDoseTime
       // self.medicationLastDoseTime = medicationLastDoseTime
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

