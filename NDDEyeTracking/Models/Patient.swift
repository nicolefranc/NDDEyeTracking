//
//  Patient.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers
    
struct Patient: Identifiable, Codable, Hashable {
    private(set) var id: UUID
    private(set) var name: String
    var eyeTrackingTests: [EyeTrackingTest]
    var testReport: [TaskReport]
    
    init(_ name: String, eyeTrackingTests: [EyeTrackingTest] = [], testReport: [TaskReport] = []) {
        self.id = UUID()
        self.name = name
        self.eyeTrackingTests = eyeTrackingTests
        self.testReport = testReport
    }
}

// hardcoded patient list for testing purposes
//extension Patient {
//    static var list: [Patient] {
//        [
//            Patient("John Appleseed"),
//            Patient("Isaiah Pearflower"),
//            Patient("Arthur Watermelon")
//        ]
//    }
//}

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
    
    mutating func addReport(report: TaskReport) {
        self.testReport.append(report)
    }
}
