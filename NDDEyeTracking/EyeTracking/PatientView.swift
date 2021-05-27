//
//  PatientView.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import SwiftUI

struct PatientView: View {
    private(set) var patient: Patient
    
    init(patient: Patient) {
        self.patient = patient
    }
    
    var body: some View {
        List {
            Section(header: Text("Eye Tracking Tests")) {
                ForEach(patient.eyeTrackingTests) { eyeTrackingTest in
                    NavigationLink(
                        destination: EyeTrackingTestView(patient: patient, eyeTrackingTest: eyeTrackingTest),
                        label: {
                            Text(eyeTrackingTest.name)
                        })
                }
            }
        }
        .toolbar {
            Button(action: {
                print("Add new test")
            }, label: {
                Image(systemName: "plus").imageScale(.large)
                Text("New Test")
            })
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(patient.name)
    }
}
