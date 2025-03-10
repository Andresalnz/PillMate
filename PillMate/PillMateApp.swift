//
//  PillMateApp.swift
//  PillMate
//
//  Created by Andres Aleu on 4/2/25.
//

import SwiftUI

@main
struct PillMateApp: App {
    var body: some Scene {
        WindowGroup {
            ReminderCalendarView(viewModel: ReminderCalendarVM())
                .background(Color(red: 217/255, green: 220/255, blue: 214/255))
        }
    }
}
