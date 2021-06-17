//
//  SessionPagingView.swift
//  MyWatchApp Extension
//
//  Created by Stefano D’Amato on 16/06/21.
//

import SwiftUI
import WatchKit

struct SessionPagingView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    
    @State private var selection: Tab = .metrics
    
    enum Tab{
        case controls, metrics
    }
    var body: some View {
        TabView(selection: $selection) {
            ControlsView().tag(Tab.controls)
            MetricsView().tag(Tab.metrics)
        }
        .navigationTitle("Battito Cardiaco")
        .navigationBarBackButtonHidden(true)
        .onChange(of: workoutManager.running) { _ in
            displayMetricsView()
        }
    }
    
    private func displayMetricsView() {
        withAnimation {
            selection = .metrics
        }
    }
}

struct SessionPagingView_Previews: PreviewProvider {
    static var previews: some View {
        SessionPagingView()
    }
}

