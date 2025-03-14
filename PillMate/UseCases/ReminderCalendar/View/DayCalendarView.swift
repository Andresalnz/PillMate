//
//  DayCalendarView.swift
//  PillMate
//
//  Created by Andres Aleu on 10/3/25.
//

import SwiftUI

struct DayCalendarView: View {
    
    let day: Int
    
    @EnvironmentObject var viewModel: ReminderCalendarVM
    
    var body: some View {
        ZStack {
            if viewModel.selectedDay == day {
                Circle()
                    .fill(Color(red: 100/255, green: 160/255, blue: 200/255))
                    .frame(height: 35)
            }
            Text("\(day)")
        }
    }
}

#Preview {
    DayCalendarView(day: 13).environmentObject(ReminderCalendarVM(currentDate: Date(), month: "", numberMonth: 0, days: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31], numberWeekDay: 5, selectedDay: 13))
}
