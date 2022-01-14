//
//  Task5View1.swift
//  NDDEyeTracking
//
//  Created by Haojin Li on 1/14/22.
//

import SwiftUI
import Resolver
import EyeTrackKit

private enum Task5View1Checkpoint {
    case instructions
    case task
    case complete
}

struct Task5View1: View {
    @ObservedObject var visuallyGuidedViewModel: VisuallyGuidedViewModel = VisuallyGuidedViewModel()
    
    @EnvironmentObject var ettViewModel: ETTViewModel
    @Binding var currentTask: TaskType
    
    // View Builder
    @State fileprivate var checkpoint: Task5View1Checkpoint = .instructions
    
    // Eye Tracking
    @ObservedObject var eyeTrackController: EyeTrackController = Resolver.resolve()
    @ObservedObject var dataController: EyeDataController = Resolver.resolve()
    
    // Timer Variables
    @State private var countdownSeconds: Int = 15
    @State private var isCountdownDone: Bool = false // TODO: could take out?
    
    // Randomized animation timer (how long circle stays at each position)
    @State var randomTimeArray = [Float?](repeating: nil, count:6)
    
    init(currentTask: Binding<TaskType>) {
        _currentTask = currentTask
        
        // Retrieve Eye Tracking Data
        let data: EyeDataController = Resolver.resolve()
        self.eyeTrackController.onUpdate = { info in
            data.addTrackingData(info: info!)
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
        case .task: displayVisuallyGuidedTask()
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
    private func displayVisuallyGuidedTask() -> some View {
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
            let pointArray: [CGPoint] = visuallyGuidedViewModel.points
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
    
    // MARK: - Animation Timer
    private let animationTimer = Timer.publish(every: TimeInterval(Double.random(in: 1.4 ... 2.4)), on: .main, in: .common).autoconnect()
}

//struct Task5View1_Previews: PreviewProvider {
//    static var previews: some View {
//        Task5View1()
//    }
//}
