//
//  ScheduledDose.swift
//  PillMate
//
//  Created by Andres Aleu on 27/5/25.
//

import Foundation
import SwiftData

@Model
final class ScheduledDose: Identifiable, Hashable, @unchecked Sendable {
    @Attribute(.unique) var id: UUID
    var scheduledTime: Date
    var status: String
    var nitificacionIdentifier: String
    var medication: InformationMedication
    
    init(id: UUID, scheduledTime: Date, status: String, nitificacionIdentifier: String, medication: InformationMedication) {
        self.id = id
        self.scheduledTime = scheduledTime
        self.status = status
        self.nitificacionIdentifier = nitificacionIdentifier
        self.medication = medication
    }
}
