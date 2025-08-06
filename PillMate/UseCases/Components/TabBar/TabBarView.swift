//
//  TabBarView.swift
//  PillMate
//
//  Created by Andres Aleu on 5/8/25.
//

import SwiftUI
enum elementTab: Int {
    case home = 0
    case calendar = 1
}

struct TabBarView: View {
    @State private var selectedTab: elementTab = .home
    
    init() {
        configureTabBarAppearance()
    }
    //MARK: - configureTabBarAppearance
    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        
        //selected
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color(hex: Colors.primary))
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(Color(hex: Colors.primary))]
        
        //normal
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color(hex: Colors.secondary))
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(Color(hex: Colors.secondary))]
        
        //background
        appearance.backgroundColor = UIColor(Color(hex: Colors.background))
        
        //apariencia
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
    }
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "house.fill", value: .home) {
                HomeView(vm: HomeVM(), lnManager: LocalNotificationManager())
            }
            Tab("Calendar", systemImage: "calendar", value: .home) {
                ReminderCalendarView()
                    .background(Color(hex: Colors.background))
            }
            
        }
    }
}

#Preview {
    TabBarView()
        
}
