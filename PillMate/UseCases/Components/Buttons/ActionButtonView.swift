//
//  ActionButtonView.swift
//  PillMate
//
//  Created by Andres Aleu on 20/3/25.
//

import SwiftUI

struct ActionButtonView: View {
    
    var action: () -> Void
    var text: String
    
    var body: some View {
        Button(action: { action() }, label: {
            Text(text)
                .font(.title2)
        })
    }
}

#Preview {
    ActionButtonView(action: { print("He pulsado el botón action") }, text: "Agregar medicación")
}
