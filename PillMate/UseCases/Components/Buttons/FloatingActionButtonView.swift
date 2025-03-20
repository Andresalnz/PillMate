//
//  FloatingActionButton.swift
//  PillMate
//
//  Created by Andres Aleu on 20/3/25.
//

import SwiftUI

struct FloatingActionButtonView: View {
    
    
    var imageName: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: imageName)
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(.blue)
                .clipShape(Circle())
                .shadow(radius: 5)
            
        })
    }
}

#Preview {
    FloatingActionButtonView(imageName: "plus", action: { print("He pulsado el botón") })
}
