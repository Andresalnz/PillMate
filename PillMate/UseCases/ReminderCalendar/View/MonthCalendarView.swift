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
    let daysInMonth: Int
    
    let calendarGrid: [GridItem] = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        VStack {
            Text(nameMonth)
                .font(.headline)
                .padding()
            
            LazyVGrid(columns: calendarGrid) {
                ForEach(daysOfWeeks, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                ForEach(0..<emptyDaysBeginMonth, id: \.self) { emptyDay in
                    Text("")
                        .id("empty \(emptyDay)")
                }
                ForEach(1...daysInMonth, id: \.self) { day in
                    Text("\(day)")
                        .padding(10)
                }
            }
        }
    }
}

#Preview {
    MonthCalendarView(nameMonth: "Febrero", daysOfWeeks: ["L", "M", "X", "J", "V", "S", "D"], emptyDaysBeginMonth: 4, daysInMonth: 28)
}
