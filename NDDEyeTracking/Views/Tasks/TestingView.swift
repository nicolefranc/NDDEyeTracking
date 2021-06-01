//
//  TestingView.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 1/6/21.
//

import SwiftUI
import Resolver
import EyeTrackKit

struct TestingView: View {
    @Binding var patient: Patient
    @Binding var eyeTrackingTest: EyeTrackingTest
    @EnvironmentObject var imageTaskViewModel: ImageTaskViewModel
    @State private var currentImgIdx: Int = 0
    @State private var seconds: Int = ImageTaskView.defaultSeconds
    @State var shouldNavigate: Bool = false
    
    // Eye Tracking
    @ObservedObject var eyeTrackController: EyeTrackController = Resolver.resolve()
    @ObservedObject var dataController: DataController = Resolver.resolve()
    
    init(patient: Binding<Patient>, eyeTrackingTest: Binding<EyeTrackingTest>) {
        _patient = patient
        _eyeTrackingTest = eyeTrackingTest
        let data: DataController = Resolver.resolve()
        self.eyeTrackController.onUpdate = { info in
            data.addTrackingData(info: info!)
            print(info?.centerEyeLookAtPoint ?? "nil")
        }
    }
    
    var body: some View {
        NavigationLink(
            // MARK: - TODO: Change checkpoint to .endTask1
            destination: TestOverview(patient: $patient, eyeTrackingTest: $eyeTrackingTest, checkpoint: .endTask3),
            isActive: $shouldNavigate) { EmptyView() }
        ZStack {
            Image(imageTaskViewModel.imageNames[currentImgIdx])
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .onReceive(timer, perform: { _ in
                    self.startTimer()
                })
            
            // Eye Tracking View
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
        }
        .onAppear {
            self.startRecording()
        }
        .onDisappear {
            // Save task result in eye tracking test
            eyeTrackingTest.saveTaskResult(type: .task1, task: imageTaskViewModel.imageTask)
        }
    }
    
    private func startRecording() {
        self.eyeTrackController.startRecord()
        self.dataController.startRecording()
    }
    
    private func stopRecording() {
        self.dataController.stopRecording()
        self.eyeTrackController.stopRecord(finished: { path in print("Video File Path: \(path)") }, isExport: false)
        
        print("Count- \(self.dataController.eyeTrackData.count)")
        self.dataController.resetTracking()
        imageTaskViewModel.imageTask.images[currentImgIdx].addTrackInfo(data: self.dataController.eyeTrackData)
    }
    
    // MARK: - Timer Constants
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    static let defaultSeconds: Int = 3
    
    // MARK: - Timer functions
    
    private func startTimer() {
//        print("\(seconds) seconds")
        if self.seconds == 0 {
            if (self.currentImgIdx < imageTaskViewModel.imageNames.count - 1) {
                self.stopRecording()
                self.currentImgIdx += 1
                self.startRecording()
                self.seconds = ImageTaskView.defaultSeconds
            } else {
                self.timer.upstream.connect().cancel()
                self.shouldNavigate = true
            }
        } else {
            self.seconds -= 1
        }
    }
}

struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
//        TestingView()
        MainView()
    }
}
