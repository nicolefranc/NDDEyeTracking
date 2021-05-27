//
//  EyeTrackingTestView.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import SwiftUI

struct EyeTrackingTestView: View {
    private var patient: Patient
    private var eyeTrackingTest: EyeTrackingTest
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ETTDetails()
            ETTResults()
        }
            .navigationBarTitle(eyeTrackingTest.name, displayMode: .inline)
    }
    
    init(patient: Patient, eyeTrackingTest: EyeTrackingTest) {
        self.patient = patient
        self.eyeTrackingTest = eyeTrackingTest
    }
}

// TODO
struct ETTDetails: View {
    var body: some View {
        Text("Details")
            .font(.title)
    }
}

// TODO
struct ETTResults: View {
    // TODO: Add export data functionality
    
    var body: some View {
        Text("Results")
            .font(.title)
    }
}

struct EyeTrackingTestView_Previews: PreviewProvider {
    static var previews: some View {
        EyeTrackingTestView(patient: Patient("Noah Green"), eyeTrackingTest: EyeTrackingTest("Test Preview #000"))
    }
}
