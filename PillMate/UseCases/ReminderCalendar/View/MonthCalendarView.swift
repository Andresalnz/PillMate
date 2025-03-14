//
//  MonthCalendarView.swift
//  PillMate
//
//  Created by Andres Aleu on 10/3/25.
//

import SwiftUI

struct MonthCalendarView: View {
    
    let nameMonth: String
    let daysOfWeeks: [String]
    let emptyDaysBeginMonth: Int
    let daysInMonth: [Int]
    
    let calendarGrid: [GridItem] = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        VStack {
            Text(nameMonth)
                .font(.headline)
                .padding()
            
            LazyVGrid(columns: calendarGrid, spacing: 30) {
                ForEach(daysOfWeeks, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                ForEach(0..<emptyDaysBeginMonth, id: \.self) { emptyDay in
                    Text("")
                        .id("empty \(emptyDay)")
                }
                ForEach(daysInMonth, id: \.self) { day in
                    DayCalendarView(day: day)
                        .id("day \(day)")
                       
                }
            }
        }
    }
}

#Preview {
    MonthCalendarView(nameMonth: "March", daysOfWeeks: ["L", "M", "X", "J", "V", "S", "D"], emptyDaysBeginMonth: 5, daysInMonth: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31]).environmentObject(ReminderCalendarVM(currentDate: Date(), month: "", numberMonth: 0, days: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31], numberWeekDay: 5))
}
