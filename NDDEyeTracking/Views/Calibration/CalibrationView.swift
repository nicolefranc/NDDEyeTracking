//
//  CalibrationView.swift
//  NDDEyeTracking
//
//  Created by Haojin Li on 11/12/21.
//

import SwiftUI
import Resolver
import EyeTrackKit

private enum CalibrationCheckpoint {
    case instructions
    case task
    case complete
}

struct CalibrationView: View {
    // Timer Variables
    @State private var fixedPointSeconds: Int = 5
    @State private var countdownSeconds: Int = 5
    @State private var isCountdownDone: Bool = false // TODO: could take out?
    
    private var fixedPointCoordinates: [(x: Int, y: Int)] = [(100, 100), (100, 200), (200, 200), (200, 300), (300, 300)]
    
    // View Builder
    @State fileprivate var checkpoint: CalibrationCheckpoint = .instructions
    
    var body: some View {
        displayFixedPoint()
    }
    
    // MARK: - View Builders
    @ViewBuilder
    private func displayView() -> some View {
        switch checkpoint {
        case .instructions: displayInstructions()
        case .task: displayFixedPoint()
        case .complete: displayCompleteTask()
        }
    }
    
    @ViewBuilder
    private func displayInstructions() -> some View {
        VStack {
            Text("Calibration").font(.headline).bold()
            Text("Follow the red dot").font(.title)
        }
        .onReceive(timer, perform: { time in
            print("Instructions time: \(time)")
            self.startInstructionsTimer()
        })
    }
    
    @ViewBuilder
    private func displayFixedPoint() -> some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .topLeading) {
                Circle()
                    .fill(Color.red.opacity(0.5))
                    .frame(width: 15, height: 15)
                    .position(x: 100, y: 100)
                    .onReceive(timer, perform: { time in
                        self.startFixedPointTimer()
                    })
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    @ViewBuilder
    private func displayCompleteTask() -> some View {
        VStack {
           Text("Calibration").font(.headline)
           Text("Complete 🎉").font(.largeTitle)
           Button(action: {
                
           }) {
               Text("Finished")
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
    
    private func startFixedPointTimer() {
        if self.fixedPointSeconds > 0 {
            self.fixedPointSeconds -= 1
        } else {
            self.timer.upstream.connect().cancel()
            checkpoint = .task
        }
    }
    
}

struct Calibration_Previews: PreviewProvider {
    static var previews: some View {
        CalibrationView()
    }
}
