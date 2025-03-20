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
    
    //MARK: - Published
    @Published var currentDate: Date
    @Published var month: String
    @Published var numberMonth: Int
    @Published var days: [Int]
    @Published var numberWeekDay: Int
    @Published var selectedDay: Int?
    
    init(currentDate: Date = Date(), month: String, numberMonth: Int, days: [Int], numberWeekDay: Int, selectedDay: Int? = nil) {
        self.currentDate = currentDate
        self.month = month
        self.numberMonth = numberMonth
        self.days = days
        self.numberWeekDay = numberWeekDay
        self.selectedDay = selectedDay
    }
    
    var monthoff: Date {
        return monthOffset()
    }
    
    func loadViewCalendar() {
        monthYearString()
        firstDayOffset()
        daysInMonth()
        markToday()
    }
    
    func monthOffset() -> Date {
        return calendar.date(byAdding: .month, value: numberMonth, to: startOfMonth()) ?? Date()
    }
    
    func startOfMonth() -> Date {
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: currentDate)
       return calendar.date(from: components) ?? Date()
   }
    
    // Devuelve los dias del mes
    func daysInMonth() {
        let range = calendar.range(of: .day, in: .month, for: monthoff)
        if let range = range {
            days = Array(range)
        }
    }
    
   // Calcula en que cae el primer dia de la semana del mes
    func firstDayOffset()  {
        let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: monthoff)) ?? Date()
        let weekday = calendar.component(.weekday, from: firstDay) // 1 = Domingo, 7 = Sábado
        numberWeekDay = (weekday + 5) % 7 // Calculo para que Lunes sea 0
    }
    
  
    func monthYearString()  {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
      
        month = formatter.string(from:  monthoff).capitalized
    }
    
    func markToday() {
    
        if let timeZone = TimeZone(identifier: "Europe/Madrid") {
            calendar.timeZone = timeZone
        }
        
    
        let actualComponents = calendar.dateComponents([.day, .month, .year], from: monthoff)
        let currentComponents = calendar.dateComponents([.day, .month, .year], from: currentDate)
        
        if actualComponents == currentComponents {
            for i in days {
                if currentComponents.day == i  {
                    selectedDay = i
                }
            }
        } else {
            selectedDay = nil
        }
    }
}

extension ReminderCalendarVM {
    static let preview = ReminderCalendarVM(currentDate: Date(), month: "March", numberMonth: 0, days: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31], numberWeekDay: 5)
}
