//
//  MonthCalendarView.swift
//  PillMate
//
//  Created by Andres Aleu on 10/3/25.
//

import SwiftUI
import SwiftData

struct MonthCalendarView: View {
    
    let nameMonth: String
    let daysOfWeeks: [String]
    let emptyDaysBeginMonth: Int
    let daysInMonth: [Int]
    
    let calendarGrid: [GridItem] = Array(repeating: GridItem(.flexible()), count: 7)
    
    @ObservedObject var viewModel: ReminderCalendarVM
    @Query private var dose: [ScheduledDose]
    
    init(nameMonth: String, daysOfWeeks: [String], emptyDaysBeginMonth: Int, daysInMonth: [Int], viewModel: ReminderCalendarVM) {
        self.nameMonth = nameMonth
        self.daysOfWeeks = daysOfWeeks
        self.emptyDaysBeginMonth = emptyDaysBeginMonth
        self.daysInMonth = daysInMonth
        self.viewModel = viewModel
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: viewModel.selectedDay)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)
        let predicate = #Predicate<ScheduledDose> { item in
            item.scheduledTime >= startOfDay && item.scheduledTime < endOfDay!
        }
        _dose = Query(filter: predicate, sort: \ScheduledDose.scheduledTime)    }
    
    var body: some View {
        VStack {
            Text(nameMonth)
                .font(.headline).fontDesign(.rounded)
                .padding()
            
            LazyVGrid(columns: calendarGrid, spacing: 30) {
                ForEach(daysOfWeeks, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                ForEach(0..<emptyDaysBeginMonth, id: \.self) { emptyDay in
                    Text("")
                        .id("empty \(emptyDay)")
                }
                ForEach(daysInMonth, id: \.self) { day in
                    DayCalendarView(day: day, selectToday: viewModel.isToday ?? 0, isSelected: viewModel.isSelectedDay(day), onTap: {
                        viewModel.markDay(day)
                    })
                    .id("day \(day)")
                    
                }
            }
            if dose.count == 0 {
                VStack {
                    Text("No hay recordatorios para el día de hoy.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            List {
                ForEach(dose, id:\.id) { dose in
                    Section("\(dose.scheduledTime, style: .time)") {
                        ReminderCellView(hourMedication: dose.scheduledTime, nameMedication: dose.medication.medicationName, doseMedication: dose.medication.medicationDose, presentationMedication: dose.medication.medicationPresentation, momentDoseMedication: dose.medication.medicationMomentDose, customInstructionsMedication: dose.medication.medicationCustomInstructions, statusDose: dose.status)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                    
                }
            }
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
        }
    }
}

#Preview {
    let preview = Preview()
    preview.addExamples(ScheduledDose.sampleItems)
    
    return MonthCalendarView(nameMonth: "March", daysOfWeeks: ["L", "M", "X", "J", "V", "S", "D"], emptyDaysBeginMonth: 5, daysInMonth: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31], viewModel: ReminderCalendarVM(month: "", numberMonth: 1, days: [], numberWeekDay: 1))
        .modelContainer(preview.containerPreview)
}
