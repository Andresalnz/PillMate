//
//  ReminderCalendarView.swift
//  PillMate
//
//  Created by Andres Aleu on 5/2/25.
//

import SwiftUI

struct ReminderCalendarView: View {
    
    
    @StateObject  var viewModel: ReminderCalendarVM
    
    var body: some View {
        TabView(selection: $viewModel.numberMonth) {
            ForEach(-12...12, id: \.self) { offset in
                MonthCalendarView(nameMonth: viewModel.month, daysOfWeeks: viewModel.daysOfWeek , emptyDaysBeginMonth: viewModel.numberWeekDay, daysInMonth: viewModel.days)
                    .padding(.horizontal)
                    .tag(offset)
                    .environmentObject(viewModel)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .onAppear {
            viewModel.loadViewCalendar()
        }
        .onChange(of: viewModel.numberMonth) { _, newValue in
            viewModel.numberMonth = newValue
            viewModel.loadViewCalendar()
        }
    }
}

#Preview {
    ReminderCalendarView(viewModel: .preview)
        .environmentObject(ReminderCalendarVM(currentDate: Date(), month: "", numberMonth: 0, days: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31], numberWeekDay: 5))
}
