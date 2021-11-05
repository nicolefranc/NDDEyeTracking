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
    @ObservedObject var taskVM: ImageTaskViewModel = ImageTaskViewModel()
    @Binding var currentTask: TaskType

    
    // Photo Loop
    @State var currentImgIdx: Int = 0
    // @State var imageSeconds: Int = Task1View.defaultImageSeconds
    
    // Eye Tracking
    @ObservedObject var eyeTrackController: EyeTrackController = Resolver.resolve()
    @ObservedObject var dataController: DataController = Resolver.resolve()
    
    init(currentTask: Binding<TaskType>) {
        _currentTask = currentTask
        
        // Retrieve Eye Tracking Data
        let data: DataController = Resolver.resolve()
        self.eyeTrackController.onUpdate = { info in
            data.addTrackingData(info: info!)
//            print(info?.centerEyeLookAtPoint ?? "nil")
        }
    }
    
    var body: some View {
        displayView()
            .onAppear {
                self.dataController.startRecording()
            }
            .navigationBarHidden(true)
    }
    
    // MARK: - View Builder
    @ViewBuilder
    private func displayView() -> some View {
        switch taskVM.checkpoint {
            case .instructions: displayInstructions()
            case .task: displayImageTask()
            case .complete: displayCompleteTask()
        }
    }
    
    // @State var countdown: Int = ImageTaskViewModel.defaultCountdownSeconds
    
    @ViewBuilder
    private func displayInstructions() -> some View {
        ZStack {
//            if (countdown > 0) {
//                Text("\(countdown)")
//                    .font(.system(size: 96))
//                    .bold()
//                    .onReceive(taskVM.timer, perform: { _ in countdown -= 1})
//            } else {
                VStack(spacing: 20) {
                    Text("TASK 1").font(.headline).bold()
                    Text("Look at the images carefully").font(.title)
                    Button(
                        action: {
                            taskVM.setCheckpoint(to: .task)
                        }, label: {
                            Text("GO!")
                                .font(.system(size: 26, weight: .bold, design: .default))
                        }
                    )
                }
//                .onAppear {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                        taskVM.setCheckpoint(to: .task)
//                    }
//                }
//            }
        }
//        .onReceive(taskVM.timer, perform: { time in
//            print("\(time)")
//            self.startInstructionsTimer()
//        })
    }
    
    private func displayImageTask() -> some View {
        ZStack {
            Image(taskVM.filenames[currentImgIdx])
                            .resizable()
                            .scaledToFit()
                            .aspectRatio(contentMode: .fit)
                            .ignoresSafeArea()
                            .onReceive(taskVM.timer) { _ in
                                self.dataController.takeLap()
                                self.currentImgIdx += 1
                                // If we have shown all pictures we mark the task as complete
                                if (self.currentImgIdx == taskVM.filenames.count) {
                                    taskVM.timer.upstream.connect().cancel()
                                    self.dataController.stopRecording()
                                    self.taskVM.updateTrackingData(
                                        laps: self.dataController.laps,
                                        trackingData: self.dataController.eyeTrackData
                                    )
                                    taskVM.setCheckpoint(to: .complete)
                                }
                            }
            
//             Eye Tracking View
            ZStack(alignment: .top) {
                ZStack(alignment: .topLeading) {
                    self.eyeTrackController.view
                    Circle()
                        .fill(Color.red.opacity(0.5))
                        .frame(width: 15, height: 15)
                        .position(
                            x: eyeTrackController.eyeTrack.lookAtPoint.x,
                            y: eyeTrackController.eyeTrack.lookAtPoint.y
                        )
                }
                    .edgesIgnoringSafeArea(.all)
                
                Text("x: \(eyeTrackController.eyeTrack.lookAtPoint.x), y: \(eyeTrackController.eyeTrack.lookAtPoint.y)")
            }
            
///            Debugging
//            Button("Task 1 Result") {
//                ettViewModel.addTaskResult(key: "Task 1", result: imageTaskViewModel.images)
//                currentTask = .task3
//            }
        }
    }
    
    private func displayCompleteTask() -> some View {
        VStack {
           Text("Task 1").font(.headline)
           Text("Complete 🎉").font(.largeTitle)
           Button(
            action: {
                ettViewModel.addTaskResult(key: "Task 1", result: taskVM.images)
                currentTask = .task3
            },
            label: {
               Text("Next Task")
            }).padding()
       }
    }
    
    // MARK: - Timer Constants
        
//    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    static let defaultCountdownSeconds: Int = 3
//    static let defaultInstructionsSeconds: Int = 3
//    static let defaultImageSeconds: Int = 5
    
    // MARK: - Timer functions
    
//    private func startInstructionsTimer() {
//        if self.countdownSeconds == 0 {
//            if !isCountdownDone {
//                isCountdownDone = true
//                countdownSeconds = taskVM.defaultInstructionsSeconds
//            } else {
//                checkpoint = .task
//            }
//        } else {
//            self.countdownSeconds -= 1
//        }
//    }
        
//    private func startImageTimer() {
////        print("\(seconds) seconds")
//        if self.imageSeconds == 0 {
//            if (self.currentImgIdx < taskVM.filenames.count - 1) {
//                self.dataController.takeLap()
//                self.currentImgIdx += 1
//                self.imageSeconds = Task1View.defaultImageSeconds
//            } else {
//                self.timer.upstream.connect().cancel()
//                self.dataController.stopRecording()
//                self.taskVM.updateTrackingData(laps: self.dataController.laps, trackingData: self.dataController.eyeTrackData)
//                checkpoint = .complete
//            }
//        } else {
//            self.imageSeconds -= 1
//        }
//    }
}

struct Task1_Previews: PreviewProvider {
    static var previews: some View {
//        Task1View(currentTask: .constant(.task1), imageTaskViewModel: ImageTaskViewModel())
        MainView()
    }
}
