//
//  ETTViewModel.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 2/6/21.
//

import Foundation

class ETTViewModel: ObservableObject {
    @Published var ett: EyeTrackingTest = EyeTrackingTest()
    
    func addTaskReport(taskName: String, taskReport: TaskReport) {
        print("===============ADDING REPORT===============")
        var tmp = taskReport
        tmp.setTaskName(taskName: taskName)
        tmp.printReport()
        ett.taskReports.append(tmp)
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
