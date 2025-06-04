//
//  ReminderCellView.swift
//  PillMate
//
//  Created by Andres Aleu on 3/6/25.
//

import SwiftUI
import SwiftData

struct ReminderCellView: View {
    
    @Query(sort:[SortDescriptor(\ScheduledDose.scheduledTime)]) var dose: [ScheduledDose]
    
    var sch: [ScheduledDose] = [ScheduledDose(id: UUID(), scheduledTime: .now, status: "active", nitificacionIdentifier: "identifier", medication: InformationMedication(id: UUID(), medicationName: "Amoxicilina", medicationPresentation: "pills", medicationDose: "", medicationFrequency: "Cada día", medicationtTimePerDay: 3, medicationEveryXDays: 2, medicationDays: [], medicationFirstDoseTime: .now, medicationLastDoseTime: .now, medicationMomentDose: "Después de comer", medicationCustomInstructions: "Nada", medicationTreatmentStartDate: .now, medicationTreatmentEndDate: .now, treatmentDuration: "Hasta una fecha específica", numbersOfDays: 7, treatmentEndforNumberOfDays: .now, notes: ""))]
    
    var body: some View {
        ForEach(sch, id: \.id) { item in
            VStack(alignment: .center) {
                Text("Hora: \(item.scheduledTime.formatted())")
                Text("Nombre")
                Text(item.medication.medicationName)
            }
        }
        
    }
}

#Preview {
    List {
        ReminderCellView()
            .padding(.horizontal, 20)
            .padding(.vertical)
            .background(
                Color(red: 0.56, green: 0.79, blue: 0.98)
                    .cornerRadius(10)
                    .padding(.horizontal, 5)
            )
    }
    .listStyle(.plain)
    
}
