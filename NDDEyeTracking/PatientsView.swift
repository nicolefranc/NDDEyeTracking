//
//  PatientsView.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import SwiftUI

struct PatientsView: View {
    @ObservedObject var viewModel: PatientsViewModel = PatientsViewModel()
    @State private var isAddPatientToggled: Bool = false
    @State private var newPatientData: Patient.Data = Patient.Data()
    
    var body: some View {
        List {
            ForEach(viewModel.patients) { patient in
                NavigationLink(
                    destination: PatientView(patient: binding(for: patient)),
                    label: {
                        Text(patient.name)
                    })
            }
        }
        .navigationBarTitle("Patients")
        .toolbar {
            Button(action: { isAddPatientToggled.toggle() }) {
                Image(systemName: "plus").imageScale(.large)
            }.sheet(isPresented: $isAddPatientToggled, onDismiss: didAddSheetDismiss) {
                NavigationView {
                    PatientEditor(editablePatientData: $newPatientData)
                        .environmentObject(self.viewModel)
                        .toolbar { Button("Add") { self.isAddPatientToggled = false } }
                        .navigationTitle("Add Patient")
                }
            }
        }
    }
    
    private func binding(for patient: Patient) -> Binding<Patient> {
        guard let patientIndex = viewModel.patients.firstIndex(where: { $0.id == patient.id }) else {
            fatalError("Can't find patient in array")
        }
        
        return $viewModel.patients[patientIndex]
    }
    
    private func didAddSheetDismiss() {
        viewModel.addPatient(patientData: newPatientData)
    }
}

struct PatientEditor: View {
    @EnvironmentObject var viewModel: PatientsViewModel
    @Binding var editablePatientData: Patient.Data
    
    var body: some View {
        VStack(spacing: 0) {
            Form {
                Section {
                    TextField("Patient's Name", text: $editablePatientData.name)
                }
            }
        }
    }
}

struct PatientView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
