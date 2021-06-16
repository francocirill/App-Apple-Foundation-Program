/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The workout metrics view.
*/

import SwiftUI
import HealthKit

struct MetricsView: View {
    //@EnvironmentObject var workoutManager: WorkoutManager
    @StateObject private var workoutManager = WorkoutManager()
    
    
    var body: some View {
            VStack(alignment: .leading) {
                Text(String(format: "%.00f", workoutManager.heartRate) + " bpm")
            }
            
            .frame(maxWidth: .infinity, alignment: .leading)
            .ignoresSafeArea(edges: .bottom)
    }
}

struct MetricsView_Previews: PreviewProvider {
    static var previews: some View {
        MetricsView().environmentObject(WorkoutManager())
    }
}

