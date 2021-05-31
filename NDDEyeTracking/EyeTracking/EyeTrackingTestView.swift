//
//  EyeTrackingTestView.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import SwiftUI

struct EyeTrackingTestView: View {
    @Binding var eyeTrackingTest: EyeTrackingTest
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ETTDetails()
            ETTResults()
        }
            .navigationBarTitle(eyeTrackingTest.name, displayMode: .inline)
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
        EyeTrackingTestView(eyeTrackingTest: .constant(EyeTrackingTest("Test Preview #constant")))
    }
}
