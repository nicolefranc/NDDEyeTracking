//
//  PatientView.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import SwiftUI

struct PatientView: View {
    @Binding var patient: Patient // Always come back to update this bound patient variable
    @ObservedObject var ettViewModel: ETTViewModel = ETTViewModel()
    
    
    @State private var isNewTestToggled: Bool = false
    @State private var shouldStartTest: Bool = false
    
    var body: some View {
        VStack {
            NavigationLink(
//                destination: TestOverview(checkpoint: .startTest).navigationBarHidden(true),
                destination: TasksView(patient: $patient).environmentObject(ettViewModel),
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
        .onAppear {
            ettViewModel.printETT()
        }
    }
    
    private func didNewTestSheetDismiss() {
        // patient.addTest(ett: ettViewModel.ett)
        //            MARK: - TODO: Comment below when debugging this page
        self.shouldStartTest = true
        ettViewModel.printETT()
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
                EyeTrackingTestEditor()
                    .environmentObject(ettViewModel)
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
    
    @EnvironmentObject var ettViewModel: ETTViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Form {
                Section {
                    TextField("Test Name", text: $ettViewModel.ett.name)
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
