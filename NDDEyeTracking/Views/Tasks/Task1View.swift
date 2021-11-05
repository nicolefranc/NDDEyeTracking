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
    
    @ViewBuilder
    private func displayInstructions() -> some View {
        ZStack {
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
        }
    }
    
    private func displayImageTask() -> some View {
        ZStack {
            image
            eyeTrackingView
///            Debugging
//            Button("Task 1 Result") {
//                ettViewModel.addTaskResult(key: "Task 1", result: imageTaskViewModel.images)
//                currentTask = .task3
//            }
        }
    }
    
    var image: some View {
        Image(taskVM.filenames[currentImgIdx])
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                        .onReceive(taskVM.imageTimer) { _ in
                            self.dataController.takeLap()
                            self.currentImgIdx += 1
                            // If we have shown all pictures we mark the task as complete
                            if (self.currentImgIdx == taskVM.filenames.count) {
                                taskVM.imageTimer.upstream.connect().cancel()
                                self.dataController.stopRecording()
                                self.taskVM.updateTrackingData(
                                    laps: self.dataController.laps,
                                    trackingData: self.dataController.eyeTrackData
                                )
                                taskVM.setCheckpoint(to: .complete)
                            }
                        }
    }
    
    var eyeTrackingView: some View {
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
}

struct Task1_Previews: PreviewProvider {
    static var previews: some View {
//        Task1View(currentTask: .constant(.task1), imageTaskViewModel: ImageTaskViewModel())
        MainView()
    }
}
