//
//  PatientView.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import SwiftUI

struct PatientView: View {
    @Binding var patient: Patient
    
    @State var eyeTrackingTestData: EyeTrackingTest.Data = EyeTrackingTest.Data()
    @State private var isNewTestToggled: Bool = false
    @State private var shouldStartTest: Bool = false
    
    var body: some View {
        VStack {
            NavigationLink(
                destination: TestOverview(checkpoint: .startTest).navigationBarHidden(true),
                isActive: $shouldStartTest,
                label: {
                    EmptyView()
                })
            HStack {
                newTestButton()
            }
            List {
                Section(header: Text("Eye Tracking Tests")) {
                    ForEach(patient.eyeTrackingTests) { eyeTrackingTest in
                        NavigationLink(
                            destination: EyeTrackingTestView(eyeTrackingTest: binding(for: eyeTrackingTest)),
                            label: {
                                Text(eyeTrackingTest.name)
                            })
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationBarTitle(patient.name)
    }
    
    private func didNewTestSheetDismiss() {
        patient.addTest(testData: eyeTrackingTestData)
        //            MARK: - TODO: Comment below when debugging this page
        self.shouldStartTest = true
    }
    
    private func binding(for ett: EyeTrackingTest) -> Binding<EyeTrackingTest> {
        guard let ettIndex = patient.eyeTrackingTests.firstIndex(where: { $0.id == ett.id }) else {
            fatalError("Can't find eye tracking test in array")
        }
        
        return $patient.eyeTrackingTests[ettIndex]
    }
    
    @ViewBuilder
    private func newTestButton() -> some View {
        Button(action: { isNewTestToggled = true }) {
            Image(systemName: "plus").imageScale(.large)
            Text("New Test")
        }
        .sheet(isPresented: $isNewTestToggled, onDismiss: didNewTestSheetDismiss) {
            NavigationView {
                EyeTrackingTestEditor(editableETTData: $eyeTrackingTestData)
                    .toolbar { Button("Create") {
                            self.isNewTestToggled = false
                        }
                    }
                    .navigationTitle("New Test")
            }
        }
    }
}

struct EyeTrackingTestEditor: View {
    
    @Binding var editableETTData: EyeTrackingTest.Data
    
    var body: some View {
        VStack(spacing: 0) {
            Form {
                Section {
                    TextField("Test Name", text: $editableETTData.name)
                }
            }
        }
    }
}

struct PatientView_Previews: PreviewProvider {
    static var previews: some View {
//        PatientView(patient: .constant(Patient("Jennifer Orangetrunk")))
        MainView()
    }
}
