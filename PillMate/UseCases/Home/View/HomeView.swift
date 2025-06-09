//
//  HomeView.swift
//  PillMate
//
//  Created by Andres Aleu on 18/3/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @State var md: MedicationModel
    @State var openSheet: Bool
    @Environment(\.modelContext) var context
    
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack() {
                ReminderCalendarView()
            }
            FloatingActionButtonView(imageName: "plus", action: { openSheet.toggle()})
                .padding()
        }
        .sheet(isPresented: $openSheet) {
            SaveReminderFormView(model: $md, context: context)
        }
    }
}

#Preview {
    @Previewable @State var md: MedicationModel = MedicationModel(id: UUID() , name: "", presentation: .pills, dose: "", frequency: .daily, timePerDay: 1, everyXDays: 1, days: [], firstDoseTime: .now, momentDose: .afterMeal, customInstructions: "", treatmentStartDate: .now, treatmentEndDate: .now, treatmentDuration: .untilSpecificDate, numbersOfDays: 7, treatmentEndforNumberOfDays: Date(), notes: "")
    @Previewable @Environment(\.modelContext)  var context
    
    HomeView(md: md, openSheet: false)
}
