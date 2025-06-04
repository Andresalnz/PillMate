//
//  MedicationDatabase.swift
//  PillMate
//
//  Created by Andres Aleu on 27/5/25.
//

import Foundation
import SwiftData

protocol DatabaseProtocol {
   @MainActor func saveMediaction(_ medication: InformationMedication, scheduleDose: [ScheduledDose]) async throws
    var context: ModelContext? { get }
}

struct MedicationDatabase: DatabaseProtocol {
    var context: ModelContext?
    
    @MainActor
    func saveMediaction(_ medication: InformationMedication, scheduleDose: [ScheduledDose]) async throws {
        context?.insert(medication)
        for i in scheduleDose {
            context?.insert(i)
        }
       try context?.save()
    }
}
