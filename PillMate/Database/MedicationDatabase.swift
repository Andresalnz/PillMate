//
//  MedicationDatabase.swift
//  PillMate
//
//  Created by Andres Aleu on 27/5/25.
//

import Foundation
import SwiftData

protocol DatabaseProtocol {
   @MainActor func saveMediaction(_ medication: InformationMedication, scheduleDose: [ScheduledDose])  throws
   @MainActor func update(scheduleDose: ScheduledDose, medication: InformationMedication)  throws 
    var context: ModelContext? { get }
}

struct MedicationDatabase: DatabaseProtocol {
    var context: ModelContext?
    
    @MainActor
    func saveMediaction(_ medication: InformationMedication, scheduleDose: [ScheduledDose])  throws {
        context?.insert(medication)
        for i in scheduleDose {
            context?.insert(i)
        }
        try context?.save()
    }
    
    @MainActor
    func update(scheduleDose: ScheduledDose, medication: InformationMedication)  throws {
        
        context?.insert(medication)
        context?.insert(scheduleDose)
        
        try context?.save()
    }
    
}
