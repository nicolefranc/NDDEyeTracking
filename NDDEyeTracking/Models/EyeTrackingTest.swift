//
//  EyeTrackingTest.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import Foundation

struct EyeTrackingTest: Identifiable {
    var id: UUID
    var name: String
    // Add Tasks here
    
    init(_ name: String) {
        self.id = UUID()
        self.name = name
    }
}

extension EyeTrackingTest {
    struct Data {
        var name: String = ""
    }
    
    mutating func update(from data: Data) {
        self.name = data.name
    }
}
