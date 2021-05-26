//
//  MainView.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 26/5/21.
//

import SwiftUI
import Resolver
import EyeTrackKit

struct MainView: View {
    @ObservedObject var eyeTrackController: EyeTrackController = Resolver.resolve()
    @State var didMatch: Bool = false
    
    init() {
        self.eyeTrackController.onUpdate = { info in
            print(info?.centerEyeLookAtPoint ?? "none")
        }
    }
    
    var body: some View {
        ZStack {
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
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
