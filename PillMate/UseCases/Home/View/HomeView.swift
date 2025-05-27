//
//  HomeView.swift
//  PillMate
//
//  Created by Andres Aleu on 18/3/25.
//

import SwiftUI

struct HomeView: View {
    
    @State var md: MedicationModel = MedicationModel(id: UUID() , name: "", presentation: .pills, dose: "", frequency: .daily, timePerDay: 1, everyXDays: 1, days: [], firstDoseTime: .now, momentDose: .afterMeal, customInstructions: "", treatmentStartDate: .now, treatmentEndDate: .now, treatmentDuration: .untilSpecificDate, numbersOfDays: 7, treatmentEndforNumberOfDays: Date(), notes: "")
    @State var openSheet: Bool = false
  
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ReminderCalendarView(viewModel: ReminderCalendarVM(month: "Enero", numberMonth: 0, days: [1,2,3,4,5,6,7], numberWeekDay: 2))
            
            FloatingActionButtonView(imageName: "plus", action: { openSheet.toggle()})
                .padding()
        }
        .sheet(isPresented: $openSheet) {
                SaveReminderFormView(model: $md)
        }
    }
}

#Preview {
    HomeView()
}
