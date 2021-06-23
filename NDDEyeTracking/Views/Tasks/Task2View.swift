//
//  Task2View.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 28/5/21.
//  Modified by Nathan Huang on 21/6/21.
//

import SwiftUI
import Resolver
import EyeTrackKit

private enum Task2Checkpoint {
    case instructions
    case task
    case complete
}

struct Task2View: View {
    @EnvironmentObject var ettViewModel: ETTViewModel
    @Binding var currentTask: TaskType
    @ObservedObject var movingDotViewModel: MovingDotViewModel = MovingDotViewModel()
    
    // View Builder
    @State fileprivate var checkpoint: Task2Checkpoint = .instructions
    @State var isCountdownDone: Bool = false
    @State var countdownSeconds: Int = Task2View.defaultCountdownSeconds
    
    // Photo Loop
    @State var currentShapeIdx: Int = 0
    @State var imageSeconds: Int = Task2View.defaultImageSeconds
    
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
        switch checkpoint {
        case .instructions: displayInstructions()
        case .task: displayMovingDotTask()
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
                    Text("TASK 2").font(.headline).bold()
                    Text("Descriptive Text").font(.title)
                }
            }
        }
        .onReceive(timer, perform: { _ in
            self.startInstructionsTimer()
        })
    }
    
    @ViewBuilder
    private func displayMovingDotTask() -> some View {
        ZStack {
            // Moving Dot Task View
            switch movingDotViewModel.shapes[currentShapeIdx].shape {
            case .archSpiral: ArchSpiral()
            case .spiroSquare: Spirograph()
            case .spiroGraph: SpiroSquare()
            }
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
//            }
        }
    }
    
    @ViewBuilder
    private func displayCompleteTask() -> some View {
        VStack {
           Text("Task 2").font(.headline)
           Text("Complete 🎉").font(.largeTitle)
           Button(action: {
                ettViewModel.addTaskResult(key: "Task 2", result: movingDotViewModel.images)
                currentTask = .task3
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
                countdownSeconds = Task2View.defaultInstructionsSeconds
            } else {
                checkpoint = .task
            }
        } else {
            self.countdownSeconds -= 1
        }
    }

    /*
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
    }*/
}

struct Task2View___Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
