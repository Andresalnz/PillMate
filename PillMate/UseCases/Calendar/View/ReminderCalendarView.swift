//
//  ReminderCalendarView.swift
//  PillMate
//
//  Created by Andres Aleu on 5/2/25.
//

import SwiftUI

struct ReminderCalendarView: View {
    
    
    @StateObject var viewModel: ReminderCalendarVM
    
    init() {
        self._viewModel = StateObject(wrappedValue: ReminderCalendarVM(month: "", numberMonth: 0, days: [], numberWeekDay: 2))
    }
    
    var body: some View {
        TabView(selection: $viewModel.numberMonth) {
            ForEach(-12...12, id: \.self) { offset in
                MonthCalendarView(nameMonth: viewModel.month, daysOfWeeks: viewModel.daysOfWeek , emptyDaysBeginMonth: viewModel.numberWeekDay, daysInMonth: viewModel.days, viewModel: viewModel)
                    .padding(.horizontal)
                    .tag(offset)
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
    ReminderCalendarView()
}
