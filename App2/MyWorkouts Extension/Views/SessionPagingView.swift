/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The paging view to switch between controls, metrics, and now playing views.
*/

import SwiftUI
import WatchKit

struct SessionPagingView: View {
    //@EnvironmentObject var workoutManager: WorkoutManager
    @StateObject private var workoutManager = WorkoutManager()
    @State private var selection: Tab = .metrics

    enum Tab {
        case controls, metrics, nowPlaying
    }

    var body: some View {
        TabView(selection: $selection) {
            ControlsView().tag(Tab.controls)
            NowPlayingView().tag(Tab.nowPlaying)
        }
        .navigationTitle("Logos")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(selection == .nowPlaying)
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

struct PagingView_Previews: PreviewProvider {
    static var previews: some View {
        SessionPagingView().environmentObject(WorkoutManager())
    }
}

