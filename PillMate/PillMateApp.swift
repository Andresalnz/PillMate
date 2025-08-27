//
//  PillMateApp.swift
//  PillMate
//
//  Created by Andres Aleu on 4/2/25.
//

import SwiftUI
import SwiftData

@main
struct PillMateApp: App {
    
    @StateObject var lnManager: LocalNotificationManager = LocalNotificationManager()
    
    let container: ModelContainer = {
        let schema = Schema([InformationMedication.self, ScheduledDose.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
            
        } catch let err {
            print("Error container | \(err.localizedDescription)")
            fatalError()
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
        .modelContainer(container)
    }
}
