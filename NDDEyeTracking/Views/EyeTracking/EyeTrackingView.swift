//
//  EyeTrackingView.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import SwiftUI
import Resolver
import EyeTrackKit

struct EyeTrackingView: View {
    @ObservedObject var eyeTrackController: EyeTrackController = Resolver.resolve()
//    @EnvironmentObject var eyeTrackingViewModel: EyeTrackingViewModel
    @Binding var shouldStopRecording: Bool
    
//    init() {
//        self.eyeTrackController.onUpdate = { info in
//            // MARK: - ISSUE: need to instantiate view model but should not
////            eyeTrackingViewModel.addTrackingData(info: info!)
//            print(info?.centerEyeLookAtPoint ?? "nil")
//        }
//    }
    
    var body: some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .topLeading) {
                self.eyeTrackController.view
                Circle()
                    .fill(Color.red.opacity(0.5))
                    .frame(width: 15, height: 15)
                    .position(x: eyeTrackController.eyeTrack.lookAtPoint.x, y: eyeTrackController.eyeTrack.lookAtPoint.y)
            }
                .edgesIgnoringSafeArea(.all)
            
            Text("x: \(eyeTrackController.eyeTrack.lookAtPoint.x), y: \(eyeTrackController.eyeTrack.lookAtPoint.y)")
        }
        .onAppear {
//            self.eyeTrackController.onUpdate = { info in
//                self.eyeTrackingViewModel.addTrackingData(info: info!)
//                print(info?.centerEyeLookAtPoint ?? "nil")
//                if (shouldStopRecording) {
//                    eyeTrackingViewModel.stopRecording()
//                }
//            }
        }
    }
}

struct EyeTrackingView_Previews: PreviewProvider {
    static var previews: some View {
//        EyeTrackingView()
        MainView()
    }
}
