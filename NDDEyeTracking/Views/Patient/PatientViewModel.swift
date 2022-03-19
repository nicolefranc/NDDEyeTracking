//
//  PatientViewModel.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 30/5/21.
//

import Foundation

// this isn't being used? 
class PatientViewModel: ObservableObject {
    @Published var patient: Patient = Patient("")
    
    // wrong addTest - take out
//    func addTest(testData: EyeTrackingTest.Data) {
//        patient.addTest(testData: testData)
//    }
}
