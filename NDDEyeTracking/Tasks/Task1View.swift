//
//  Task1View.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import SwiftUI
import Resolver
import EyeTrackKit

struct Task1View: View {
    @EnvironmentObject var ettViewModel: ETTViewModel
    @Binding var currentTask: TaskType
    @ObservedObject var imageTaskViewModel: ImageTaskViewModel = ImageTaskViewModel()
    
    // Photo Loop
    @State var currentImgIdx: Int = 0
    @State var seconds: Int = ImageTaskView.defaultSeconds
    
    // Eye Tracking
    @ObservedObject var eyeTrackController: EyeTrackController = Resolver.resolve()
    @ObservedObject var dataController: DataController = Resolver.resolve()
    
    init(currentTask: Binding<TaskType>) {
        _currentTask = currentTask
        let data: DataController = Resolver.resolve()
        self.eyeTrackController.onUpdate = { info in
            data.addTrackingData(info: info!)
            print(info?.centerEyeLookAtPoint ?? "nil")
        }
    }
    
    var body: some View {
//        ZStack {
//            ImageTaskView()
//            EyeTrackingView()
//        }
//            .navigationBarHidden(true)
        
        ZStack {
            Image(imageTaskViewModel.filenames[currentImgIdx])
                            .resizable()
                            .scaledToFit()
                            .aspectRatio(contentMode: .fill)
                            .ignoresSafeArea()
                            .onReceive(timer, perform: { _ in
                                self.startTimer()
                            })
            
//             Eye Tracking View
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
            
            Button("Task 1 Result") {
//                imageTaskViewModel.updateTrackingData(imageIndex: 0, trackingData: ["TRACKING INFO"])
                ettViewModel.addTaskResult(key: "Task 1", result: imageTaskViewModel.images)
                currentTask = .task3
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            self.dataController.startRecording()
        }
    }
    
    // MARK: - Timer Constants
        
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    static let defaultSeconds: Int = 3
    
    // MARK: - Timer functions
        
    private func startTimer() {
//        print("\(seconds) seconds")
        if self.seconds == 0 {
            if (self.currentImgIdx < imageTaskViewModel.filenames.count - 1) {
                self.dataController.takeLap()
                self.currentImgIdx += 1
                self.seconds = ImageTaskView.defaultSeconds
            } else {
                self.timer.upstream.connect().cancel()
                self.dataController.stopRecording()
                self.imageTaskViewModel.updateTrackingData(laps: self.dataController.laps, trackingData: self.dataController.eyeTrackData)
            }
        } else {
            self.seconds -= 1
        }
    }
}

struct Task1_Previews: PreviewProvider {
    static var previews: some View {
//        Task1View(currentTask: .constant(.task1), imageTaskViewModel: ImageTaskViewModel())
        MainView()
    }
}
