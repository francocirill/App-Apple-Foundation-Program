//
//  MyWatchAppApp.swift
//  MyWatchApp Extension
//
//  Created by Stefano D’Amato on 16/06/21.
//

import SwiftUI

@main
struct MyWatchAppApp: App{
    @StateObject var workoutManager = WorkoutManager()
    
    @SceneBuilder var body: some Scene{
        WindowGroup{
            NavigationView{
                StartView()
            }.sheet(isPresented: $workoutManager.showingSummaryView) {
                SummaryView()
            }
            .environmentObject(workoutManager)
        }
    }
    
    
}
