//
//  App2App.swift
//  MyWorkouts Extension
//
//  Created by Giuseppe Pio D'Ambrosio on 15/06/21.
//

import SwiftUI

@main
struct App2App: App {
    @StateObject private var workoutManager = WorkoutManager()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            
            NavigationView {
                
                StartView()
            }
            .environmentObject(workoutManager)
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
