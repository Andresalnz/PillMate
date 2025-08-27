//
//  PreviewSwifData.swift
//  PillMate
//
//  Created by Andres Aleu on 6/8/25.
//

import Foundation
import SwiftData

struct Preview {

        let container: ModelContainer
        
    init() {
        let schema = Schema([InformationMedication.self, ScheduledDose.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            container = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("No se pudo crear el contenedor de la vista previa: \(error)")
        }
    }
       
 
    @MainActor func addExamples(_ examples: [ScheduledDose]) {
            
           
        for example in examples {
                container.mainContext.insert(example)
            }
            
            
        }
}
