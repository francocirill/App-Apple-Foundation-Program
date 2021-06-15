/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The workout controls.
*/

import SwiftUI

struct ControlsView: View {
    //@EnvironmentObject var workoutManager: WorkoutManager
    @StateObject private var workoutManager = WorkoutManager()

    var body: some View {
        HStack {
            VStack {
                Button {
                    workoutManager.endWorkout()
                } label: {
                    Image(systemName: "xmark")
                }.listItemTint(.red)
                Text("End")
            }
            VStack {
                Button {
                    workoutManager.togglePause()
                } label: {
                    Image(systemName: workoutManager.running ? "pause" : "play")
                }.listItemTint(.yellow)
                Text(workoutManager.running ? "Pause" : "Resume")
            }
        }
    }
}

struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView().environmentObject(WorkoutManager())
    }
}

