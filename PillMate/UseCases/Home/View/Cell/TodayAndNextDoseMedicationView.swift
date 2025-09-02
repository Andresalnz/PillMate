//
//  TodayAndNextDoseMedicationView.swift
//  PillMate
//
//  Created by Andres Aleu on 6/8/25.
//

import SwiftUI

struct TodayAndNextDoseMedicationView: View {
    
    let nameMedication: String?
    let timeMedication: Date?
    let doseMedication: String?
    let unitMedication: String?
    var statusDose: Bool = false
    
    var body: some View {
        if let name = nameMedication, let time = timeMedication {
            HStack {
                Image(systemName: "pill")
                    .padding()
                    .background(
                        RoundedRectangle( cornerRadius: 10, style: .continuous)
                            .fill(statusDose ? .green : .gray)
                            .opacity(statusDose ? 1 : 0.2)
                    )
                VStack(alignment: .leading) {
                    Text(name)
                        .strikethrough(statusDose, color: .green)
                        .foregroundStyle(statusDose ? .green : .black)
                    Text("\(doseMedication ?? "NA") \(unitMedication ?? "NA")")
                        .bold()
                    Text("\(time, style: .time)")
                   
                    if statusDose {
                        Text("Esta medicación ha sido tomada a las \(Date(), style: .time)")
                            .foregroundStyle(.green)
                    }
                }
            }
        } 
    }
}

#Preview {
    TodayAndNextDoseMedicationView(nameMedication: "Ibuprofeno", timeMedication: .now, doseMedication: "1", unitMedication: "pastillas")
}
