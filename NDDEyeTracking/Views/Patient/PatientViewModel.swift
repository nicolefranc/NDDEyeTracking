//
//  PatientViewModel.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 30/5/21.
//

import Foundation

class PatientViewModel: ObservableObject {
    @Published var patient: Patient = Patient("")
    
//    func addTest(testData: EyeTrackingTest.Data) {
//        patient.addTest(testData: testData)
//    }
}
