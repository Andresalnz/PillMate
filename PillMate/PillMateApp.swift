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
            ReminderCalendarView(viewModel: ReminderCalendarVM(currentDate: Date(), month: "", numberMonth: 0, days: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31], numberWeekDay: 5))
                .background(Color(red: 217/255, green: 220/255, blue: 214/255))
        }
    }
}
