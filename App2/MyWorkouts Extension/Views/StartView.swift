/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The start view.
*/

import SwiftUI
import HealthKit

struct StartView: View {
    //@EnvironmentObject var workoutManager: WorkoutManager
    @StateObject private var workoutManager = WorkoutManager()
    var body: some View {
        
        NavigationLink("Inizia", destination: MetricsView())
            
        
        .navigationBarTitle("Logos")
        .onAppear {
            workoutManager.requestAuthorization()
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView().environmentObject(WorkoutManager())
    }
}

extension HKWorkoutActivityType: Identifiable {
    public var id: UInt {
        rawValue
    }

}

