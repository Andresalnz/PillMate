//
//  SaveReminderFormView.swift
//  PillMate
//
//  Created by Andres Aleu on 20/3/25.
//

import SwiftUI

enum PresentationMedicine: String, CaseIterable, Identifiable {
    case tablet = "pastilla"
    case syrup = "jarabe"
    case injection = "inyección"
    case drops = "gotas"
    
    var id: String { self.rawValue }
}

struct SaveReminderFormView: View {
    
    @State var fechaNacimiento: Date = Date()
    @State var nameMedicine: String = ""

    var presentationsMedicine: [PresentationMedicine] = PresentationMedicine.allCases
    @State var presentation = "pastilla"
 
    var body: some View {
        Form {
            Section("Nombre del medicamento") {
                TextField("Nombre del medicamento", text: $nameMedicine, prompt: Text("Ej: Ibuprofeno"))
            }
            
            Section("Presentacion del medicamento") {
                Picker("selection", selection: $presentation) {
                    ForEach(presentationsMedicine, id: \.id) { optionPresentation in
                        Text(optionPresentation.rawValue.capitalized).tag(optionPresentation)
                    }
                }
                .pickerStyle(.segmented)
            }
            
           
            Section {
                ActionButtonView(action: {print ("pulsado en form")}, text: "Guardar")
                    .listRowBackground(Color.clear)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .buttonStyle(.borderedProminent) // 💡 Necesario para ver el efecto
                    .tint(.blue)
            }
        }
    }
}

#Preview {
    SaveReminderFormView()
}
