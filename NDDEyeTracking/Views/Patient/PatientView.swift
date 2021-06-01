//
//  PatientView.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import SwiftUI

struct PatientView: View {
    @Binding var patient: Patient
    
    @State var eyeTrackingTestData: EyeTrackingTest = EyeTrackingTest()
    @State private var isNewTestToggled: Bool = false
    @State private var shouldStartTest: Bool = false
//    @State private var newTest: EyeTrackingTest
    
    var body: some View {
        VStack {
            HStack {
                newTestButton()
            }
            List {
                Section(header: Text("Eye Tracking Tests")) {
                    self.displayEyeTrackingTests()
//                    ForEach(patient.eyeTrackingTests) { eyeTrackingTest in
//                        NavigationLink(
//                            destination: EyeTrackingTestView(eyeTrackingTest: binding(for: eyeTrackingTest)),
//                            label: {
//                                Text(eyeTrackingTest.name)
//                            })
//                    }
                }
                Section(header: Text("Debugging")) {
                    Text(patient.stringValue())
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationBarTitle(patient.name)
    }
    
    private func didNewTestSheetDismiss() {
        patient.addTest(ett: eyeTrackingTestData)
        //            MARK: - TODO: Comment out below when debugging this page
        self.shouldStartTest = true
    }
    
    private func binding(for ett: EyeTrackingTest) -> Binding<EyeTrackingTest> {
        guard let ettIndex = patient.eyeTrackingTests.firstIndex(where: { $0.id == ett.id }) else {
            fatalError("Can't find eye tracking test in array")
        }

        return $patient.eyeTrackingTests[ettIndex]
    }
    
    @ViewBuilder
    private func displayEyeTrackingTests() -> some View {
        if (patient.eyeTrackingTests.count > 0) {
            ForEach(patient.eyeTrackingTests) { eyeTrackingTest in
                NavigationLink(
                    destination: EyeTrackingTestView(eyeTrackingTest: binding(for: eyeTrackingTest)),
                    label: {
                        Text(eyeTrackingTest.name)
                    })
            }
        } else {
            Text("This patient has no tests.")
        }
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
        
        if (patient.eyeTrackingTests.count > 0) {
            NavigationLink(
                destination: TestOverview(patient: $patient, eyeTrackingTest: binding(for: eyeTrackingTestData), checkpoint: .startTest).navigationBarHidden(true),
                isActive: $shouldStartTest) { EmptyView() }
                .isDetailLink(false)
        }
    }
}

struct EyeTrackingTestEditor: View {
    
    @Binding var editableETTData: EyeTrackingTest
    
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
