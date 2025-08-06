//
//  LocalNotificationManager.swift
//  PillMate
//
//  Created by Andres Aleu on 19/6/25.
//

import Foundation
@preconcurrency import UserNotifications
import UIKit

protocol LocalNotificationProtocol {
    func requestAuthorization() async throws
    @MainActor func scheduleNotification(modelSchedule: [ScheduledDose], medication: InformationMedication) async
}

class LocalNotificationManager: ObservableObject, LocalNotificationProtocol {
    let notificationCenter = UNUserNotificationCenter.current()
    @Published var isAuthorized: Bool = false
    
    //Pedir permiso al usuario
    @MainActor
    func requestAuthorization() async throws {
        do {
            try await notificationCenter.requestAuthorization(options: [.alert, .sound, .badge])
            let currentSettings = await notificationCenter.notificationSettings()
            updateAuthorizationState(settings: currentSettings)
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    //Ver el estado de la autorización
    func updateAuthorizationState(settings: UNNotificationSettings) {
        print(isAuthorized)
        if settings.authorizationStatus == .denied {
            //isAuthorized.toggle()
            isAuthorized = true
        }
    }
    
    //Abrir ajustes del sistema para editar configuración
    @MainActor
    func openSettings() async {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                await UIApplication.shared.open(url)
            }
        }
    }
    
    @MainActor
    func scheduleNotification(modelSchedule: [ScheduledDose], medication: InformationMedication) async {
        let calendar = Calendar.current
        let content = UNMutableNotificationContent()
        content.title = medication.medicationName
        content.subtitle = "\(medication.medicationDose) \(medication.medicationPresentation) \(medication.medicationMomentDose)"
        content.body = "Indicaciones:  \(medication.medicationCustomInstructions)"
        content.sound = .default
        for i in modelSchedule {
            let dateComponents2 = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: i.scheduledTime)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents2, repeats: false)
            let request = UNNotificationRequest(identifier: i.nitificacionIdentifier, content: content, trigger: trigger)
            try? await notificationCenter.add(request)
        }
        print(await notificationCenter.pendingNotificationRequests())
    }
    
    
}
