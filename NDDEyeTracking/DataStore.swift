//
//  DataStore.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import Foundation

struct DataStore {
    // Sample data
    
    static var patients: [Patient] = [
        Patient("John Appleseed"),
        Patient("Isaiah Pearflower"),
        Patient("Arthur Watermelon")
    ]
    
    static var eyeTrackingTests: [EyeTrackingTest] = [
//        EyeTrackingTest("Test #000"),
//        EyeTrackingTest("Test #001"),
//        EyeTrackingTest("Test #002"),
//        EyeTrackingTest("Test #003"),
//        EyeTrackingTest("Test #004"),
//        EyeTrackingTest("Test #005"),
//        EyeTrackingTest("Test #006"),
//        EyeTrackingTest("Test #007")
    ]
    
    static func addPatient(name: String) {
        DataStore.patients.append(Patient(name))
        print(DataStore.patients)
    }
}
