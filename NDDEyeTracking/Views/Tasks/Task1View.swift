//
//  Task1View.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import SwiftUI
import Resolver
//import EyeTrackKit

private enum Task1Checkpoint {
    case instructions
    case task
    case complete
}

struct Task1View: View {
    @EnvironmentObject var ettViewModel: ETTViewModel
    @Binding var currentTask: TaskType
    @ObservedObject var imageTaskViewModel: ImageTaskViewModel = ImageTaskViewModel()
    
    // View Builder
    @State fileprivate var checkpoint: Task1Checkpoint = .instructions
    @State var isCountdownDone: Bool = false
    @State var countdownSeconds: Int = Task1View.defaultCountdownSeconds
    
    // Photo Loop
    @State var currentImgIdx: Int = 0
    @State var imageSeconds: Int = Task1View.defaultImageSeconds
    
    // Eye Tracking
    @ObservedObject var eyeTrackController: EyeTrackController = Resolver.resolve()
    @ObservedObject var dataController: EyeDataController = Resolver.resolve()
    
    init(currentTask: Binding<TaskType>) {
        _currentTask = currentTask
        
        // Retrieve Eye Tracking Data
        let data: EyeDataController = Resolver.resolve()
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
        switch checkpoint {
        case .instructions: displayInstructions()
        case .task: displayImageTask()
        case .complete: displayCompleteTask()
        }
    }
    
    @ViewBuilder
    private func displayInstructions() -> some View {
        ZStack {
            if (!isCountdownDone && self.countdownSeconds > 0) {
                Text("\(self.countdownSeconds)").font(.system(size: 96)).bold()
            } else {
                VStack {
                    Text("TASK 1").font(.headline).bold()
                    Text("Look at the images carefully").font(.title)
                }
            }
        }
        .onReceive(timer, perform: { _ in
            self.startInstructionsTimer()
        })
    }
    
    @ViewBuilder
    private func displayImageTask() -> some View {
        ZStack {
            Image(imageTaskViewModel.filenames[currentImgIdx])
                            .resizable()
                            .scaledToFit()
                            .aspectRatio(contentMode: .fill)
                            .ignoresSafeArea()
                            .onReceive(timer, perform: { _ in
                                self.startImageTimer()
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
            
///            Debugging
//            Button("Task 1 Result") {
//                ettViewModel.addTaskResult(key: "Task 1", result: imageTaskViewModel.images)
//                currentTask = .task3
//            }
        }
    }
    
    @ViewBuilder
    private func displayCompleteTask() -> some View {
        VStack {
           Text("Task 1").font(.headline)
           Text("Complete 🎉").font(.largeTitle)
           Button(action: {
                ettViewModel.addTaskResult(key: TaskType.task1.rawValue, result: imageTaskViewModel.images)
                currentTask = .task2
           }) {
               Text("Next Task")
           }.padding()
       }
    }
    
    
    // MARK: - Timer Constants
        
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    static let defaultCountdownSeconds: Int = 3
    static let defaultInstructionsSeconds: Int = 3
    static let defaultImageSeconds: Int = 5
    
    // MARK: - Timer functions
    
    private func startInstructionsTimer() {
        if self.countdownSeconds == 0 {
            if !isCountdownDone {
                isCountdownDone = true
                countdownSeconds = Task1View.defaultInstructionsSeconds
            } else {
                checkpoint = .task
            }
        } else {
            self.countdownSeconds -= 1
        }
    }
        
    private func startImageTimer() {
//        print("\(seconds) seconds")
        if self.imageSeconds == 0 {
            if (self.currentImgIdx < imageTaskViewModel.filenames.count - 1) {
                self.dataController.takeLap()
                self.currentImgIdx += 1
                self.imageSeconds = Task1View.defaultImageSeconds
            } else {
                self.timer.upstream.connect().cancel()
                self.dataController.stopRecording()
                self.imageTaskViewModel.updateTrackingData(laps: self.dataController.laps, trackingData: self.dataController.eyeTrackData)
                checkpoint = .complete
            }
        } else {
            self.imageSeconds -= 1
        }
    }
}

struct Task1_Previews: PreviewProvider {
    static var previews: some View {
//        Task1View(currentTask: .constant(.task1), imageTaskViewModel: ImageTaskViewModel())
        MainView()
    }
}
