//
//  TaskData.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 2/6/21.
//

import Foundation

class TaskData : Codable {
    var taskType: TaskType
    
    init(taskType: TaskType) {
        self.taskType = taskType
    }
    
    private enum CodingKeys: String, CodingKey {
        case taskType
    }
}
