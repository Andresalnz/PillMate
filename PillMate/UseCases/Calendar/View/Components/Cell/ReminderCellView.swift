//
//  ReminderCellView.swift
//  PillMate
//
//  Created by Andres Aleu on 3/6/25.
//

import SwiftUI

struct ReminderCellView: View {
    
    let hourMedication: Date
    let nameMedication: String
    let doseMedication: String
    let presentationMedication: String
    let momentDoseMedication: String
    let customInstructionsMedication: String
    var statusDose: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(nameMedication)
                .font(.title)
            Text("\(doseMedication) \(presentationMedication) \(momentDoseMedication)")
                .foregroundStyle(.gray)
            if customInstructionsMedication != "" {
                Text("Indicaciones:  \(customInstructionsMedication)")
                    .foregroundStyle(.gray).opacity(0.9)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color(statusDose ? Color.green : Color.gray)
                .opacity(0.12)
                .cornerRadius(10)
        )
    }
}

#Preview {
    ReminderCellView(hourMedication: .now, nameMedication: "Omeprazol", doseMedication: "1", presentationMedication: "Pastillas", momentDoseMedication: "despues de comer", customInstructionsMedication: "Después de comer y con agua", statusDose: false)
}


