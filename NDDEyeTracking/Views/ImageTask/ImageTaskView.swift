//
//  ImageTaskView.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import SwiftUI

struct ImageTaskView: View {
    @EnvironmentObject var viewModel: ImageTaskViewModel
    
    @State private var currentImgIdx: Int = 0
    @State private var seconds: Int = ImageTaskView.defaultSeconds
    @Binding var shouldNavigate: Bool
    @Binding var shouldStopRecording: Bool
    
    
    var body: some View {
        Image(viewModel.imageNames[currentImgIdx])
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
            .onReceive(timer, perform: { _ in
                self.startTimer()
            })
            .onAppear {
                self.startRecording()
            }
    }
    
    // MARK: - Timer Constants
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    static let defaultSeconds: Int = 1
    
    // MARK: - Timer functions
    
    private func startTimer() {
        if self.seconds == 0 {
            if (self.currentImgIdx < viewModel.imageNames.count - 1) {
                self.currentImgIdx += 1
                self.shouldStopRecording = true
                self.saveRecording()
                self.seconds = ImageTaskView.defaultSeconds
            } else {
                self.timer.upstream.connect().cancel()
                self.shouldNavigate = true
            }
        } else {
            self.seconds -= 1
        }
    }
    
    // MARK: - Tracking Data Recording
    
    private func startRecording() {
        
    }
    
    private func saveRecording() {}
}

struct ImageTaskView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
