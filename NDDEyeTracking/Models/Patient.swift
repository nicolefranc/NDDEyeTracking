//
//  Patient.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import Foundation
    
struct Patient: Identifiable, Codable {
    private(set) var id: UUID
    private(set) var name: String
    var eyeTrackingTests: [EyeTrackingTest]
    
    init(_ name: String, eyeTrackingTests: [EyeTrackingTest] = []) {
        self.id = UUID()
        self.name = name
        self.eyeTrackingTests = eyeTrackingTests
    }
}

extension Patient {
    static var list: [Patient] {
        [
            Patient("John Appleseed"),
            Patient("Isaiah Pearflower"),
            Patient("Arthur Watermelon")
        ]
    }
}

extension Patient {
    /// Editable fields of Patient
    struct Data {
        var name: String = ""
        var eyeTrackingTests: [EyeTrackingTest] = []
    }

    var data: Data {
        Data(name: self.name)
    }
    
    mutating func update(from data: Data) {
        self.name = data.name
    }
    
    mutating func addTest(ett: EyeTrackingTest) {
        self.eyeTrackingTests.append(ett)
    }
}
