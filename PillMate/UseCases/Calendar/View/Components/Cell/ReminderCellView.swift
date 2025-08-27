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
    
    @State private var showEditView: Bool = false
    
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
                    VStack(alignment: .leading, spacing: 10) {
                        Text(item.medication.medicationName)
                            .font(.title)
                        Text("\(item.medication.medicationDose) \(item.medication.medicationPresentation) \(item.medication.medicationMomentDose)")
                            .foregroundStyle(.gray)
                        if item.medication.medicationCustomInstructions != "" {
                            Text("Indicaciones:  \(item.medication.medicationCustomInstructions)")
                                .foregroundStyle(.gray).opacity(0.9)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical)
                    .padding(.horizontal)
                    .background(
                    
                        
                        
                        showEditView ? Color.green : Color.white
                        
                    )
                }
                .onTapGesture {
                  showEditView = true
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    let preview = Preview()
    preview.addExamples(ScheduledDose.sampleItems)
    
    return ReminderCellView(day: .now)
        .modelContainer(preview.container)
    
    
}


