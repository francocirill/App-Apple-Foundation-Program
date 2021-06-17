//
//  MetricsView.swift
//  MyWatchApp Extension
//
//  Created by Stefano D’Amato on 16/06/21.
//

import SwiftUI
import HealthKit

struct MetricsView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    
    var body: some View {
        VStack(alignment: .leading){
            ElapsedTimeView(
                elapsedTime: workoutManager.builder?.elapsedTime ?? 0, showSubsecond: true
            ).foregroundColor(.yellow)
            Text(
                String(workoutManager.heartRate) + " bpm"
            )
            
        }
        .font(.system(.title, design: .rounded)
                .monospacedDigit()
                .lowercaseSmallCaps()
        )
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        .ignoresSafeArea(edges: .bottom)
    }
    
}

struct MetricsView_Previews: PreviewProvider {
    static var previews: some View {
        MetricsView()
    }
}

//private struct MetricsTimelineSchedule: TimelineSchedule {
//    var startDate: Date
//
//    init(from startDate: Date) {
//        self.startDate = startDate
//    }
//
//    func entries(from startDate: Date, mode: TimelineScheduleMode) -> PeriodicTimelineSchedule.Entries {
//        PeriodicTimelineSchedule(from: self.startDate, by: (mode == .lowFrequency ? 1.0 : 1.0 / 30.0))
//            .entries(from: startDate, mode: mode)
//    }
//}
