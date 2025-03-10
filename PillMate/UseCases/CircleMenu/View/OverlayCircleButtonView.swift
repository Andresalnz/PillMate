//
//  OverlayCircleButtonView.swift
//  PillMate
//
//  Created by Andres Aleu on 6/2/25.
//

import SwiftUI

struct OverlayCircleButtonView: View {
    
    @Binding  var showSettings: Bool
    
    var body: some View {
        if !showSettings {
            Image(systemName: "plus")
                .foregroundStyle(.white)
                .padding(6)
        } else {
            VStack(spacing: 22) {
                ButtonMenuView(action: {print("ddado")}, text: "Añadir recordatorio de tu medicina")
                ButtonMenuView(action: {print ("dado2")}, text: "Añadir medicina al almacen")
            }
        }
    }
}

#Preview {
    OverlayCircleButtonView(showSettings: .constant(false))
}
