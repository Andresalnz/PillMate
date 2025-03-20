//
//  HomeView.swift
//  PillMate
//
//  Created by Andres Aleu on 18/3/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            ReminderCalendarView(viewModel: ReminderCalendarVM(month: "Enero", numberMonth: 0, days: [1,2,3,4,5,6,7], numberWeekDay: 2))
                .padding(.vertical)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        print("Botón flotante presionado")
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(.blue)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                           
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
