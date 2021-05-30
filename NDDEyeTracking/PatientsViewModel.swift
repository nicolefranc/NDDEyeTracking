//
//  PatientsViewModel.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 30/5/21.
//

import Foundation

final class PatientsViewModel: ObservableObject {
    @Published var patients: [Patient] = Patient.data
    
    func addPatient(patientData: Patient.Data) {
        self.patients.append(Patient(patientData.name))
        print("Add \(patientData.name ) as patient")
    }
}
