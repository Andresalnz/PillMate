//
//  ReminderCellView.swift
//  PillMate
//
//  Created by Andres Aleu on 3/6/25.
//

import SwiftUI
import SwiftData

struct ReminderCellView: View {
    
    @Query private var dose: [ScheduledDose]
    let day: Date
    
    init(day: Date) {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: day)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)
        let predicate = #Predicate<ScheduledDose> { item in
            item.scheduledTime >= startOfDay && item.scheduledTime < endOfDay!
        }
        _dose = Query(filter: predicate, sort: \ScheduledDose.scheduledTime)
        self.day = day
    }
    
    var body: some View {
        if dose.count == 0 {
            VStack {
                Text("No hay recordatorios para el día de hoy.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        List {
            ForEach(dose, id: \.id) { item in
                Section("\(item.scheduledTime, style: .time)") {
                    VStack(alignment: .leading, spacing: 30) {
                        VStack(alignment: .leading, spacing:10 ) {
                            Text(item.medication.medicationName)
                                .font(.title)
                            HStack {
                                Text(item.medication.medicationDose)
                                Text(item.medication.medicationPresentation)
                            }
                        }
                        
                        VStack (alignment: .leading, spacing: 10) {
                            Text("Momento de toma: \(item.medication.medicationMomentDose)")
                                .bold()
                            if item.medication.medicationCustomInstructions != "" {
                                Text("Instrucciones de toma: \(item.medication.medicationCustomInstructions)")
                            }
                            
                        }
                    }
                    .listRowSeparator(.hidden)
                    
                    .padding(.horizontal, 20)
                    .padding(.vertical)
                    .background(
                        Color(red: 0.56, green: 0.79, blue: 0.98)
                            .cornerRadius(10)
                            .padding(.horizontal, 5)
                    )
                }
                
            }
        }
        .listStyle(.plain)
        
        
    }
    
}

#Preview {
    ReminderCellView(day: .now)
    
    
}
