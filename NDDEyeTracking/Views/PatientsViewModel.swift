//
//  PatientsViewModel.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 30/5/21.
//

import Foundation

final class PatientsViewModel: ObservableObject {
    @Published var patients: [Patient] = []
    
    init() {
        self.patients = retrieve()
    }
    
    func addPatient(patientData: Patient.Data) {
        self.patients.append(Patient(patientData.name))
        self.persist()
        
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

// extension for retrieving from persisted data and persisting to userDefaults
extension PatientsViewModel {
    // retrieve persisted patient list
    func retrieve() -> [Patient] {
        do {
            self.patients = try userDefaults.getObject(forKey: storedPatientsArrKey, castTo: [Patient].self)
            print("data has been retrieved")
        } catch {
            print("retrieve failed")
            return []
        }

//        for patient in self.patients {
//            print("name: \(patient)")
//            for test in patient.eyeTrackingTests {
//                print("name: \(patient), test: \(test)")
//            }
//        }

        return self.patients
    }

    // persist patient list in app storage
    func persist() {
//        print("IN PERSIST()!!")
//        for patient in self.patients {
//            print("persist name: \(patient)")
//            for test in patient.eyeTrackingTests {
//                print("persist name: \(patient), test: \(test)")
//            }
//        }

        do {
            try userDefaults.setObject(self.patients, forKey: storedPatientsArrKey)
            print("data has been persisted")
        } catch {
            print("persist failed")
        }
    }
}
