//
//  ReminderCalendarVM.swift
//  PillMate
//
//  Created by Andres Aleu on 10/3/25.
//

import Foundation


class ReminderCalendarVM: ObservableObject {
    
    //MARK: - Variables
    var calendar = Calendar.current
    let daysOfWeek = ["L", "M", "X", "J", "V", "S", "D"]
    var currentDate: Date
    
    //MARK: - Published
    @Published var month: String
    @Published var numberMonth: Int
    @Published var days: [Int]
    @Published var numberWeekDay: Int
    @Published var isToday: Int?
    
    @Published var selectedDay: Date?
    
    init(currentDate: Date = Date(), month: String, numberMonth: Int, days: [Int], numberWeekDay: Int, isToday: Int? = nil, selectedDay: Date? = nil) {
        self.currentDate = currentDate
        self.month = month
        self.numberMonth = numberMonth
        self.days = days
        self.numberWeekDay = numberWeekDay
        self.isToday = isToday
        self.selectedDay = selectedDay
    }
    
    func loadViewCalendar() {
        monthYearString()
        daysInMonth()
        firstDayOffset()
        markToday()
    }
    
    func monthOffset() -> Date {
        return calendar.date(byAdding: .month, value: numberMonth, to: currentDate) ?? Date()
    }
    
    // Devuelve los dias del mes
    func daysInMonth() {
        let range = calendar.range(of: .day, in: .month, for: monthOffset())
        if let range = range {
            days = Array(range)
        }
    }
    
    // Calcula en que cae el primer dia de la semana del mes
    func firstDayOffset() {
        if let interval = calendar.dateInterval(of: .month, for: monthOffset()) {
            let weekday = calendar.component(.weekday, from: interval.start)
            numberWeekDay = (weekday + 5) % 7  // Calculo para que Lunes sea 0
        }
    }
    
    func monthYearString() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        
        month = formatter.string(from: monthOffset()).capitalized
    }
    
    func markToday() {
        let currentComponents = calendar.dateComponents(
            [.day],
            from: currentDate
        )
        
        if currentDate == monthOffset() {
            if let today = days.first(where: { $0 == currentComponents.day }) {
               isToday = today
            }
        } else {
            isToday = 0
        }
    }
    
    func isSelectedDay(_ day: Int) -> Bool {
           guard let selected = selectedDay else { return false }
           var components = DateComponents()
           components.day = day
           
           guard let date = calendar.date(from: components) else { return false }
           
           return calendar.isDate(selected, inSameDayAs: date)
           
       }
       
       func markDay(_ day: Int) {
           var components = DateComponents()
           components.day = day
           
           guard let date = calendar.date(from: components) else { return }
           selectedDay = date
       }
}

extension ReminderCalendarVM {
    @MainActor static let preview = ReminderCalendarVM(
        currentDate: Date(),
        month: "March",
        numberMonth: 0,
        days: [
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
            20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
        ],
        numberWeekDay: 1
    )
}
