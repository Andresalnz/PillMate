//
//  CircleMenuView.swift
//  PillMate
//
//  Created by Andres Aleu on 6/2/25.
//

import SwiftUI

struct CircleMenuView: View {
    
    @Binding  var showSettings: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: showSettings ? 16: 40)
            .fill(Color(red: 58/255, green: 124/255, blue: 165/255))
            .frame(width: showSettings ? .infinity: 80, height: showSettings ? 300: 80)
            .onTapGesture {
                withAnimation(.bouncy) {
                    showSettings.toggle()
                }
            }
    }
}

#Preview {
    CircleMenuView(showSettings: .constant(false))
}
