//
//  ETTViewModel.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 2/6/21.
//

import Foundation

class ETTViewModel: ObservableObject {
    @Published var ett: EyeTrackingTest = EyeTrackingTest()
    
    func addTaskReport(taskReport: TaskReport) {
        print("===============ADDING REPORT===============")
        taskReport.printReport()
        ett.taskReport = taskReport
    }
    
    func addTaskResult(key: String, result: [TaskData]) {
        ett.tasks[key] = result
    }
    
    // MARK: - Debugging
    
    func printETT() {
        var val = "================ ETT ==================\n"
            val += "ID: \(ett.id)\nETT Name: \(ett.name)\nTasks: \(ett.tasks.count) task(s)"
        print(val)
    }
}
