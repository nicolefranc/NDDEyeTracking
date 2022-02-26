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
    
    // Timer Variables
    @State private var countdownSeconds: Int = 5
    @State private var isCountdownDone: Bool = false // TODO: could take out?
    
    // Animation variables
    // Path number - keeps track of which of the 3 paths is being run right now
    @State var currentPathNumber: Int = 0
    // Index in path - keeps track of index within each path array
    @State var currentIdxInPath: Int = 0
    
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
    
    // MARK: - View Builders
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
        VStack {
            Text("TASK 2").font(.headline).bold()
            Text("Follow the black dot").font(.title)
        }
        .onReceive(timer, perform: { time in
            print("Instructions time: \(time)")
            self.startInstructionsTimer()
        })
    }
    
    @ViewBuilder
    private func displayMovingDotTask() -> some View {
        
        // MARK: Eye Tracking View
        
        ZStack(alignment: .top) {
            ZStack(alignment: .topLeading) {
                self.eyeTrackController.view
                Circle()
                    .fill(Color.red.opacity(0.5))
                    .frame(width: 15, height: 15)
                    .position(x: eyeTrackController.eyeTrack.lookAtPoint.x, y: eyeTrackController.eyeTrack.lookAtPoint.y)
            }
                .edgesIgnoringSafeArea(.all)
        }
        
        // MARK: Moving Dot Task View
        
        VStack {
            let pointArray: [CGPoint] = movingDotViewModel.paths[currentPathNumber].path
            Text("x: \(eyeTrackController.eyeTrack.lookAtPoint.x), y: \(eyeTrackController.eyeTrack.lookAtPoint.y)")
            Circle()
                .fill(Color.black.opacity(0.5))
                .frame(width: 15, height: 15)
                .onReceive(animationTimer, perform: { time in
                    print("Anim Timer: \(time)") // TODO: Remove after debugging
                    print(pointArray.count)
                    print("current point in array: \(currentIdxInPath)")
                    print("current path number: \(currentPathNumber)")
                    self.startAnimation(points: pointArray)
                })
                .position(x: pointArray[currentIdxInPath].x, y: pointArray[currentIdxInPath].y)
        }.padding().frame(height: UIScreen.screenHeight)
    }
    
    @ViewBuilder
    private func displayCompleteTask() -> some View {
        VStack {
           Text("Task 2").font(.headline)
           Text("Complete 🎉").font(.largeTitle)
           Button(action: {
                ettViewModel.addTaskResult(key: TaskType.task2.rawValue, result: movingDotViewModel.paths)
                currentTask = .task3
           }) {
               Text("Next Task")
           }.padding()
       }
    }
    
    
    // MARK: - Timer Constants
        
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    static let defaultInstructionsSeconds: Int = 3

    
    // MARK: - Timer functions
    
    private func startInstructionsTimer() {
        if self.countdownSeconds > 0 {
            self.countdownSeconds -= 1
        } else {
            self.timer.upstream.connect().cancel()
            checkpoint = .task
        }
    }

    
    // MARK: - Animation Constants
    
    private let animationTimer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    // MARK: - Animation Functions
    
    private func startAnimation(points: [CGPoint]) {
        print("Current Point: \(currentIdxInPath)")
        // @Nicole put a minus 1 here because the update of the index is weird
        if (currentIdxInPath < points.count - 1) {
            print("updating")
            currentIdxInPath += 1
        } else {
            print("index not in range anymore")
            self.stopAnimation()
        }
    }
    
    private func stopAnimation() {
        print("Stopping animation...")
        // @Nicole same reason as above
        if (currentPathNumber < movingDotViewModel.paths.count - 1) {
            self.dataController.takeLap()
            currentIdxInPath = 0 // Reset path index state
            currentPathNumber += 1 // Proceed to next CustomPath
        } else {
            animationTimer.upstream.connect().cancel() // Stop the timer
            self.dataController.stopRecording()
            self.movingDotViewModel.updateTrackingData(laps: self.dataController.laps, trackingData: self.dataController.eyeTrackData)
            checkpoint = .complete
        }
    }
}

struct Task2View_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
