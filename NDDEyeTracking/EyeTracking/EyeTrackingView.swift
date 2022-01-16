//
//  EyeTrackingView.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import SwiftUI
import Resolver
//import EyeTrackKit

// TO BE DELETED - for reference only
//struct EyeTrackingView: View {
//    @ObservedObject var eyeTrackController: EyeTrackController = Resolver.resolve()
//
//    init() {
//        self.eyeTrackController.onUpdate = { info in
//            print(info?.centerEyeLookAtPoint ?? "none")
//        }
//    }
//
//    var body: some View {
//        ZStack(alignment: .top) {
//            ZStack(alignment: .topLeading) {
//                self.eyeTrackController.view
//                Circle()
//                    .fill(Color.red.opacity(0.5))
//                    .frame(width: 15, height: 15)
//                    .position(x: eyeTrackController.eyeTrack.lookAtPoint.x, y: eyeTrackController.eyeTrack.lookAtPoint.y)
//            }
//                .edgesIgnoringSafeArea(.all)
//
//            Text("x: \(eyeTrackController.eyeTrack.lookAtPoint.x), y: \(eyeTrackController.eyeTrack.lookAtPoint.y)")
//        }
//    }
//}

//struct EyeTrackingView_Previews: PreviewProvider {
//    static var previews: some View {
//        EyeTrackingView()
//    }
//}
