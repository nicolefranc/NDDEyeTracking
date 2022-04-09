//
//  EyeTrackingTest.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import Foundation

struct EyeTrackingTest: Identifiable, Codable, Hashable {
    var id: UUID
    var name: String
    var tasks: [String:[TaskData]]
    
    init() {
        self.id = UUID()
        self.name = ""
        self.tasks = [:]
    }
}
