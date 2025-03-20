//
//  HomeView.swift
//  PillMate
//
//  Created by Andres Aleu on 18/3/25.
//

import SwiftUI

enum NavigationForm: Hashable {
    case formAddReminderMedicine
    case formaAddMedicineChest
}

struct HomeView: View {
    
    @State var openSheet: Bool = false
    @State private var path = [NavigationForm]()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ReminderCalendarView(viewModel: ReminderCalendarVM(month: "Enero", numberMonth: 0, days: [1,2,3,4,5,6,7], numberWeekDay: 2))
                .padding(.vertical)
            FloatingActionButtonView(imageName: "plus", action: { openSheet.toggle()})
                .padding()
        }
        .sheet(isPresented: $openSheet) {
            NavigationStack(path: $path) {
                VStack {
                    Text("¿Que deseas hacer?")
                        .padding(.bottom)
                    
                    ActionButtonView(action: {
                        path.append(.formAddReminderMedicine)
                    }, text: "Agregar recordatorio")
                    .padding(.bottom)
                    .buttonStyle(.bordered)
                    
                    ActionButtonView(action: {
                        path.append(.formaAddMedicineChest)
                    }, text: "Agregar al armario")
                    
                    .buttonStyle(.bordered)
                }
                .navigationDestination(for: NavigationForm.self) { form in
                    switch form {
                        case .formAddReminderMedicine:
                            ReminderCalendarView(viewModel: ReminderCalendarVM(month: "Enero", numberMonth: 0, days: [1,2,3,4,5,6,7], numberWeekDay: 2))
                        case .formaAddMedicineChest:
                            Text("View B")
                    }
                }
            }
            .presentationDetents([.fraction(0.30), .medium])
        }
    }
}

#Preview {
    HomeView()
}
