//
//  RecordingView.swift
//  NDDEyeTracking
//
//  Created by Jason Shang on 11/26/22.
//

import SwiftUI
import AVKit

struct RecordingView: View {
    @StateObject var cameraViewModel = CameraViewModel()
    
    var body: some View {
        ZStack {
            CameraView().environmentObject(cameraViewModel)
            VStack {
                Spacer()
                
                HStack {
                    Button(action: {print("start button pressed")}, label: {
                        Text("Start")
                        
                    })
                    
                    Button(action: {print("next button pressed")}, label: {
                        Text("Next")
                    })
                }
            }
        }
    }
    
}
