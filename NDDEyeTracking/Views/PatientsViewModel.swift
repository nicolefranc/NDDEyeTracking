//
//  PatientsViewModel.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 30/5/21.
//

import Foundation

final class PatientsViewModel: ObservableObject {
    @Published var patients: [Patient] = Patient.list
    
    func addPatient(patientData: Patient.Data) {
        self.patients.append(Patient(patientData.name))
        print("Add \(patientData.name ) as patient")
    }
    
    func validate(patient: Patient.Data) -> Bool {
        if (patient.name.isEmpty) {
            return false
        }
        
        return true
    }
    
    func resetFields(patient: Patient.Data) -> Patient.Data {
        return Patient.Data()
    }
    
    // MARK: - Debugging
    
    func printPatients() {
        for patient in patients {
            for ett in patient.eyeTrackingTests {
                var val = "============== PATIENT ================\n"
                    val += "Patient: \(patient.name)\nTest: \(ett.name)\n"

                for task in ett.tasks {
                    val += "Task: \(task)\n"
                }
                print(val)
                
                let p: [Patient] = patients
                print(p)
            }
        }
    }
}
