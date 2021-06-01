//
//  PatientsViewModel.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 30/5/21.
//

import Foundation

final class PatientsViewModel: ObservableObject {
    @Published var patients: [Patient] = Patient.list
    @Published var moveToPatients: Bool = false
    
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
    
    // MARK: - Persisting Data
    
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        } catch {
            fatalError("Can't find documents directory")
        }
    }
    
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("patients.data")
    }
    
//    func load() {
//        DispatchQueue.global(qos: .background).async { [weak self] in
//            guard let data = try? Data(contentsOf: Self.fileURL) else {
//                #if DEBUG
//                DispatchQueue.main.async {
//                    self?.patients = Patient.list
//                }
//                #endif
//                return
//            }
//            
//            guard let patients = try? JSONDecoder().decode([Patient].self, from: data) else {
//                fatalError("Can't decode saved patient data.")
//            }
//            
//            DispatchQueue.main.async {
//                self?.patients = patients
//            }
//        }
//    }
//    
//    func save() {
//        DispatchQueue.global(qos: .background).async { [weak self] in
//            guard let patients = self?.patients else { fatalError("Self out of scope") }
//            guard let data = try? JSONEncoder().encode(patients) else { fatalError("Error encoding data")}
//            
//            do {
//                let outfile = Self.fileURL
//                try data.write(to: outfile)
//            } catch {
//                fatalError("Can't write to file")
//            }
//        }
//    }
}
