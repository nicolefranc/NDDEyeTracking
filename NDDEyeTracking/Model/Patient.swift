//
//  Patient.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import Foundation

struct Patient: Identifiable {
    private(set) var id: UUID
    private(set) var name: String
    private(set) var eyeTrackingTests: Array<EyeTrackingTest>
    
    init(_ name: String, eyeTrackingTests: [EyeTrackingTest] = []) {
        self.id = UUID()
        self.name = name
        self.eyeTrackingTests = DataStore.eyeTrackingTests
    }
}
