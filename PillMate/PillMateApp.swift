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
       // let isRunningForPreviews = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
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
        let md: MedicationModel = MedicationModel(id: UUID() , name: "", presentation: .pills, dose: "", frequency: .daily, timePerDay: 1, everyXDays: 1, days: [], firstDoseTime: .now, momentDose: .afterMeal, customInstructions: "", treatmentStartDate: .now, treatmentEndDate: .now, treatmentDuration: .untilSpecificDate, numbersOfDays: 7, treatmentEndforNumberOfDays: Date(), notes: "")
       
        WindowGroup {
           // ReminderCalendarView(viewModel: ReminderCalendarVM(month: "", numberMonth: 1, days: [1], numberWeekDay: 0) ).modelContainer(container)
            HomeView(md: md, openSheet: false, lnManager: lnManager).modelContainer(container)
        }
    }
}
