//
//  DayCalendarView.swift
//  PillMate
//
//  Created by Andres Aleu on 10/3/25.
//

import SwiftUI

struct DayCalendarView: View {
    
    let day: Int
    var selectToday: Int
    let isSelected: Bool
    let onTap: () -> Void
   
    
    var body: some View {
        ZStack {
            if selectToday == day {
                Circle()
                    .fill(Color(red: 100/255, green: 160/255, blue: 200/255))
                    .frame(height: 35)                
            }
            Text("\(day)")
                .foregroundStyle(isSelected ? .red : .black)
                .onTapGesture {
                    onTap()
                }
        }
    }
}

#Preview {
    DayCalendarView(day: 3, selectToday: 5, isSelected: false, onTap: { print("TAP") })
}
