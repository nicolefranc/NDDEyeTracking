//
//  CameraView.swift
//  NDDEyeTracking
//
//  Created by Jason Shang on 12/10/22.
//

import AVFoundation
import SwiftUI

struct CameraView: View {
    @EnvironmentObject var cameraViewModel: CameraViewModel
    @State private var displayPreview: Bool = false
    
    var body: some View {
        ZStack {
            if displayPreview {
                GeometryReader{proxy in
                    let size = proxy.size
                    
                    CameraPreview(size: size).environmentObject(cameraViewModel)
                }
                .onAppear(perform: cameraViewModel.checkPermission)
                .alert(isPresented: $cameraViewModel.alert) {
                    Alert(title: Text("Please Enable Camera Access"))
                }
            }
        }
    }
}

struct CameraPreview: UIViewRepresentable {
    @EnvironmentObject var cameraModel: CameraViewModel
    var size: CGSize
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        
        cameraModel.preview = AVCaptureVideoPreviewLayer(session: cameraModel.session)
        cameraModel.preview.frame.size = size
        
        cameraModel.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(cameraModel.preview)
        
        cameraModel.session.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
