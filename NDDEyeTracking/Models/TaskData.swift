//
//  TaskData.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 2/6/21.
//

import Foundation

class TaskData: Codable, Hashable {
    var taskType: TaskType
    
    init(taskType: TaskType) {
        self.taskType = taskType
    }
    
    static func == (lhs: TaskData, rhs: TaskData) -> Bool {
        return lhs.taskType == rhs.taskType
    }
    
    private enum CodingKeys: String, CodingKey {
        case taskType
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.taskType)
    }
}
