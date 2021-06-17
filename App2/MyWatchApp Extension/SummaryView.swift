//
//  SummaryView.swift
//  MyWatchApp Extension
//
//  Created by Stefano D’Amato on 16/06/21.
//

import SwiftUI
import HealthKit

struct SummaryView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @Environment(\.presentationMode) var dismiss
    @State private var durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    var body: some View {
        if workoutManager.workout == nil {
            ProgressView("Saving Workout")
                .navigationBarHidden(true)
        } else {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    SummaryMetricView(title: "Total Time",
                                      value: durationFormatter.string(from: workoutManager.workout?.duration ?? 0.0) ?? "")
                        .foregroundColor(.yellow)
                    
                    SummaryMetricView(title: "Avg. Heart Rate",
                                      value: String(format: "%.2f", workoutManager.averageHeartRate) + " bpm")
                        .foregroundColor(.red)
                    
                    Button("Done") {
                        dismiss.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle("Summary")
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}

struct SummaryMetricView: View {
    var title: String
    var value: String

    var body: some View {
        Text(title)
//            .foregroundColor(.foreground)
        Text(value)
        Divider()
    }
}
