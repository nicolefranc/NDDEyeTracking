//
//  EyeTrackingTest.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import Foundation

enum TaskType: String {
    case task1 = "Task 1"
    case task2 = "Task 2"
    case task3 = "Task 3"
}

struct EyeTrackingTest: Identifiable {
    var id: UUID
    var name: String
    // Add Tasks here
    var tasks: [TaskType: Any]
    
    init() {
        self.id = UUID()
        self.name = ""
        self.tasks = [:]
    }
    
    mutating func saveTaskResult(type: TaskType, task: Any) {
        self.tasks[type] = task
    }
}

//extension EyeTrackingTest {
//    struct Data {
//        var name: String = ""
//    }
//    
//    mutating func update(from data: Data) {
//        self.name = data.name
//    }
//}
