//
//  MedicationModel.swift
//  PillMate
//
//  Created by Andres Aleu on 19/5/25.
//

import Foundation

enum MedicationPresentation: String, CaseIterable, Identifiable, Codable {
    case pills = "Pastillas"
    case injection = "Inyección"
    case syrup = "Jarabe"
    case drops = "Gotas"
    case inhaler = "Inhalador"
   // case cream = "Crema/Pomada"

    var id: String { self.rawValue }
    
    // Propiedad computada para el placeholder de dosis
       var placeholder: String {
           switch self {
           case .pills:
               return "Ej: 1 comprimido"
           case .injection:
               return "Ej: 1ml, 10 UI"
           case .syrup:
               return "Ej: 5ml"
           case .drops:
               return "Ej: 3 gotas"
           case .inhaler:
               return "Ej: 2 pulsaciones"
//           case .cream:
//               return "Ej: Aplicación fina"
           
           }
       }
    
    //Propiedad computada para indicar la unidad
       var unit: String {
           switch self {
           case .pills: return "comprimidos"
           case .injection: return "ml o UI"
           case .syrup: return "ml"
           case .drops: return "gotas"
           case .inhaler: return "pulsaciones o mcg"
          // case .cream: return ""
          
           }
       }
}

enum FrequencyType: String, CaseIterable, Identifiable, Codable {
    case daily = "Cada día"
    case alternateDays = "Días alternos"
    case specificWeekdays = "Días específicos de la semana"
    case everyXDays = "Cada X días"

    var id: String { self.rawValue }
    

}

enum WeekdayDays: String, CaseIterable, Identifiable, Codable {
    case monday = "Lunes"
    case tuesday = "Martes"
    case wednesday = "Miércoles"
    case thursday = "Jueves"
    case friday = "Viernes"
    case saturday = "Sábado"
    case sunday = "Domingo"
    
    var id: String { self.rawValue }
}

enum MomentDose: String, CaseIterable, Identifiable, Codable {
    case beforeMeal = "Antes de comer"
    case withMeal = "Con la comida"
    case afterMeal = "Despues de comer"
    
    var id: String { self.rawValue }
}

enum TreatmentDuration: String, CaseIterable, Identifiable, Codable {
    case forNumberOfDays = "Por un número de días"
    case untilSpecificDate = "Hasta una fecha específica"
    
    var id: String { self.rawValue }
}

struct MedicationModel: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var presentation: MedicationPresentation
    var dose: String
    var frequency: FrequencyType
    var timePerDay: Int //Indica cuantas tomas tomar
    var everyXDays: Int //Indica cada cuantos dias tomar la medicación en cada X días
    var days: Set<WeekdayDays> //Alamacena los dias de la semana que indique
    var firstDoseTime: Date //Hora de la primera dosis
    var momentDose: MomentDose //Momento de toma
    var customInstructions: String
    var treatmentStartDate: Date //fecha del inicio del tratamiento
    var treatmentEndDate: Date //Fecha de la finalización del tratamiento
    var treatmentDuration: TreatmentDuration //Duracnión del tratamiento
    var numbersOfDays: Int = 7 //Número de dias se la duración es "Por número de días"
    var treatmentEndforNumberOfDays: Date // Indica cuando finaliza el tratamiento
    var notes: String
}
