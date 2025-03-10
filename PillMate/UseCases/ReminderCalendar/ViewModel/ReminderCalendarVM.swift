//
//  ReminderCalendarVM.swift
//  PillMate
//
//  Created by Andres Aleu on 10/3/25.
//

import Foundation

class ReminderCalendarVM: ObservableObject {
    
    //MARK: - Variables
    let calendar = Calendar.current
    let daysOfWeek = ["L", "M", "X", "J", "V", "S", "D"]
    
    //MARK: - Published
    @Published var currentDate: Date
    @Published var month: String
    @Published var numberMonth: Int
    @Published var days: Int
    @Published var numberWeekDay: Int
    
    
    init(currentDate: Date = Date(), month: String = "" , numberMonth: Int = 0, days: Int = 0, numberWeekDay: Int = 0) {
        self.currentDate = currentDate
        self.month = month
        self.numberMonth = numberMonth
        self.days = days
        self.numberWeekDay = numberWeekDay
    }
    
    var monthoff: Date {
        return monthOffset()
    }
    
    func loadViewCalendar() {
        monthYearString()
        firstDayOffset()
        daysInMonth()
        
    }
    
    func monthOffset() -> Date {
        return calendar.date(byAdding: .month, value: numberMonth, to: startOfMonth()) ?? Date()
    }
    
    func startOfMonth() -> Date {
       let components = calendar.dateComponents([.year, .month], from: currentDate)
       return calendar.date(from: components)!
   }
    
    // Devuelve los dias del mes
    func daysInMonth() {
        let range = calendar.range(of: .day, in: .month, for: monthoff)
        days = range?.count ?? 0
        
    }
    
   // Calcula en que cae el primer dia de la semana del mes
    func firstDayOffset()  {
        let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: monthoff))!
        let weekday = calendar.component(.weekday, from: firstDay) // 1 = Domingo, 7 = Sábado
        numberWeekDay = (weekday + 5) % 7 // Calculo para que Lunes sea 0
    }
    
  
    func monthYearString()  {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
      
        month = formatter.string(from:  monthoff).capitalized
    }
}

extension ReminderCalendarVM {
   static let preview = ReminderCalendarVM(currentDate: Date(), month: "March", numberMonth: 0, days: 23, numberWeekDay: 5)
}
