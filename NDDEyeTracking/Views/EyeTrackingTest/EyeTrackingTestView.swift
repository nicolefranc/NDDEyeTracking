//
//  EyeTrackingTestView.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import SwiftUI

struct EyeTrackingTestView: View {
    @Binding var eyeTrackingTest: EyeTrackingTest
    
    var body: some View {
        List {
            Section(header: Text("Task Reports")) {
                ForEach(eyeTrackingTest.taskReports) { taskReport in
                    NavigationLink(
                        destination: TaskReportView(taskReport: binding(for: taskReport)),
                        label: {
                            Text(taskReport.taskName)
                        }
                    )
                }
            }
        }
    }
    
    private func binding(for taskReport: TaskReport) -> Binding<TaskReport> {
        guard let taskReportIndex = eyeTrackingTest.taskReports.firstIndex(where: { $0.taskReportText == taskReport.taskReportText }) else {
            fatalError("Can't find task report in array")
        }
        
        return $eyeTrackingTest.taskReports[taskReportIndex]
    }
}

struct TaskReportView: View {
    @Binding var taskReport: TaskReport
    
    var body: some View {
        ScrollView {
            Text(taskReport.taskReportText)
        }
    }
}


struct EyeTrackingTestView_Previews: PreviewProvider {
    static var previews: some View {
//        EyeTrackingTestView(eyeTrackingTest: .constant(EyeTrackingTest("Test Preview #constant")))
        MainView()
    }
}
