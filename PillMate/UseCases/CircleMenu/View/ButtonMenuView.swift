//
//  ButtonMenuView.swift
//  PillMate
//
//  Created by Andres Aleu on 6/2/25.
//

import SwiftUI

struct ButtonMenuView: View {
    
    var action: () -> Void
    var text: String
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .font(.title2)
        }
        .tint(.white)
        .padding(30)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.black)
                .padding(.horizontal, 10)
        )
    }
}

#Preview {
    ButtonMenuView(action: {print("añadir recordatorio")}, text: "Añadir recordatorio de tu medicina")
}
