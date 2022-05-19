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
    @State private var isExportToggled: Bool = false
    @State private var isSelectMode: Bool = false
    @State private var newPatientData: Patient.Data = Patient.Data()
    @State private var selection = Set<UUID>()
        
    var body: some View {
        List(selection: $selection) {
            ForEach(viewModel.patients) { patient in
                NavigationLink(
                    destination: PatientView(patient: binding(for: patient)).environmentObject(self.viewModel),
                    label: {
                        Text(patient.name)
                    })
            }
            .onDelete(perform: deleteSingle) // enable delete
            .onMove(perform: move) // enable move
        }
        .navigationTitle("Patients \(selection.count) selected")
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                EditButton()
            }
            
            ToolbarItem(placement: ToolbarItemPlacement.bottomBar) {
                Button(action: {
                    isExportToggled.toggle()
                }) {
                    Image(systemName: "square.and.arrow.up").imageScale(.large)
                }
            }
            
            ToolbarItem(placement: ToolbarItemPlacement.bottomBar) {
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
        .fileMover(isPresented: $isExportToggled, files: getExportURLs(patientIDSelection: selection)){ result in
            switch result {
            case .success(let url):
                print("Saved to \(url)")
                clearSelection()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        .onAppear {
            //viewModel.printPatients()
        }
    }
    
    
    private func binding(for patient: Patient) -> Binding<Patient> {
        guard let patientIndex = viewModel.patients.firstIndex(where: { $0.id == patient.id }) else {
            fatalError("Can't find patient in array")
        }
        
        return $viewModel.patients[patientIndex]
    }
    
    private func didAddSheetDismiss() {
        let isValid = viewModel.validate(patient: newPatientData)
        
        if (isValid) {
            viewModel.addPatient(patientData: newPatientData)
            newPatientData = viewModel.resetFields(patient: newPatientData)
        }
    }
    
    // MARK: Delete a single patient from List
    private func deleteSingle(at offsets: IndexSet) {
        if let first = offsets.first {
            viewModel.patients.remove(at: first)
        }
        viewModel.persist()
    }
    
    private func clearSelection() {
        for patient in viewModel.patients {
            if selection.contains(patient.id) {
                viewModel.patients.remove(at: viewModel.patients.firstIndex(of: patient)!);
            }
        }
        viewModel.persist()
    }

    // MARK: Delete patients in batch (delete selected patients)
//    private func deleteInBatch() {
//        for patient in $selection.keys {
//            var patientIdx = 0
//            for idx in 0...viewModel.patients.count {
//                if viewModel.patients[idx] == patient {
//                    patientIdx = idx
//                }
//            }
//            viewModel.patients.remove(at: patientIdx)
//        }
////        for (_, patientIdx) in selection {
////            viewModel.patients.remove(at: patientIdx)
////        }
//    }
    
    // MARK: Move a patient around (change order)
    private func move(from source: IndexSet, to destination: Int) {
        var dest = destination
        //let reversedSource = source.sorted()
        for index in source.reversed() {
            dest = min(dest, viewModel.patients.count - 1)
            viewModel.patients.insert(viewModel.patients.remove(at: index), at: dest)
        }
        viewModel.persist()
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

struct PatientsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()        }
    }
}
