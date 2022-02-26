//
//  TaskType.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 30/6/21.
//

import Foundation

enum TaskType: String, Codable {
    case start = "Start Task"
    case task1 = "Task 1"
    case task2 = "Task 2"
    case task3 = "Task 3"
}

//extension TaskType: Codable {
//
//    enum Key: CodingKey {
//        case rawValue
//        case associatedValue
//    }
//
//    enum CodingError: Error {
//        case unknownValue
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: Key.self)
//        let rawValue = try container.decode(Int.self, forKey: .rawValue)
//        switch rawValue {
//        case 0:
//            let start = try container.decode(String.self, forKey: .associatedValue)
//            self = .start(start)
//        case 1:
//            let task1 = try container.decode(String.self, forKey: .associatedValue)
//            self = .task1(task1)
//        case 2:
//            let task2 = try container.decode(String.self, forKey: .associatedValue)
//            self = .task2(task2)
//        case 3:
//            let task3 = try container.decode(String.self, forKey: .associatedValue)
//            self = .task3(task3)
//        default:
//            throw CodingError.unknownValue
//        }
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: Key.self)
//        switch self {
//        case .start(let start):
//            try container.encode(0, forKey: .rawValue)
//            try container.encode(start, forKey: .associatedValue)
//        case .task1(let task1):
//            try container.encode(1, forKey: .rawValue)
//            try container.encode(task1, forKey: .associatedValue)
//        case .task2(let task2):
//            try container.encode(1, forKey: .rawValue)
//            try container.encode(task2, forKey: .associatedValue)
//        case .task3(let task3):
//            try container.encode(1, forKey: .rawValue)
//            try container.encode(task3, forKey: .associatedValue)
//        }
//    }
//}
