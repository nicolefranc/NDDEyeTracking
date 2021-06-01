//
//  Task1View.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import SwiftUI
import EyeTrackKit

struct Task1View: View {
    @Binding var patient: Patient
//    @EnvironmentObject var eyeTrackingViewModel: EyeTrackingViewModel
    @EnvironmentObject var imageTaskViewModel: ImageTaskViewModel
    @State private var shouldNavigate: Bool = false
    @State private var shouldStopRecording: Bool = false
    
    var body: some View {
//        NavigationLink(
//            // MARK: - TODO: Change checkpoint to .endTask1
//            destination: TestOverview(patient: $patient, checkpoint: .endTask3),
//            isActive: $shouldNavigate) { EmptyView() }
        ZStack {
            ImageTaskView(shouldNavigate: $shouldNavigate, shouldStopRecording: $shouldStopRecording)
                .environmentObject(imageTaskViewModel)
            EyeTrackingView(shouldStopRecording: $shouldStopRecording)
//                .environmentObject(eyeTrackingViewModel)
        }
        .onAppear {
//            eyeTrackingViewModel.startRecording()
        }
//        .onDisappear {
//            eyeTrackingViewModel.stopRecording()
//        }
        .navigationBarHidden(true)
    }
}

struct Task1_Previews: PreviewProvider {
    static var previews: some View {
//        Task1View(imageTaskViewModel: ImageTaskViewModel())
        MainView()
    }
}
