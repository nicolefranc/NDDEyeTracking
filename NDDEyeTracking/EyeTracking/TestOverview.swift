//
//  TestOverview.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import SwiftUI

enum Checkpoint {
    case startTest
    case startTask1
    case endTask1
    case startTask2
    case endTask2
    case startTask3
    case endTask3
}

// TO BE DELETED - for reference only
struct TestOverview: View {
    @State private var checkpoint: Checkpoint
    @State private var seconds: Int = 3
    @State private var timer: Timer? = nil
    @State private var shouldNavigate: Bool = false
    @State private var isCountdownDone: Bool = false
    @State private var isTestFinished: Bool = false
    
    var body: some View {
        ZStack {
            switch checkpoint {
            case .startTest:
                self.startTest()
            case .startTask1:
                self.startTask1()
            case .endTask1:
                self.endTask1()
            case .startTask2:
                self.startTask2()
            case .endTask2:
                self.endTask2()
            case .startTask3:
                self.startTask3()
            case .endTask3:
                self.endTask3()
            }
        }
            .navigationBarHidden(true)
    }
    
    init(checkpoint: Checkpoint) {
        self.checkpoint = checkpoint
    }
    
    // MARK: - Constants
    private let countdownTime: Int = 3
    private let instructionTime: Int = 3
    
    // MARK: - Display Task Views
    
    func startTest() -> some View {
        return VStack {
            Text("You are taking the Eye Tracking Test.").font(.title)
            Text("This test consists of 3 tasks.\nPress START to begin.").multilineTextAlignment(.center)
            Button(action: {
                self.checkpoint = .startTask1
                self.seconds = countdownTime
                self.startTimer()
            }) {
                Text("Start").font(.title)
            }.padding()
        }
    }
    
    func startTask1() -> some View {
        ZStack {
            if (shouldNavigate) {
//                Task1View()
            } else if (!isCountdownDone && self.seconds > 0) {
                Text("\(self.seconds)").font(.system(size: 96)).bold()
            } else {
                VStack {
                    Text("TASK 1").font(.headline).bold()
                    Text("Look at the images carefully").font(.title)
                }
            }
        }
    }
    
    func endTask1() -> some View {
        return VStack {
            Text("Task 1").font(.headline)
            Text("Complete 🎉").font(.largeTitle)
            Button(action: {
                self.checkpoint = .startTask2
                self.seconds = countdownTime
                self.startTimer()
            }) {
                Text("Next Task")
            }.padding()
        }
    }

    func startTask2() -> some View {
        return ZStack {
            if (shouldNavigate) {
                Task2View()
            } else if (!isCountdownDone && self.seconds > 0) {
                Text("\(self.seconds)").font(.system(size: 96)).bold()
            } else {
                VStack {
                    Text("TASK 2").font(.headline).bold()
                    Text("Follow the dot as it moves").font(.title)
                }
            }
        }
    }

    func endTask2() -> some View {
        return VStack {
            Text("Task 2").font(.headline)
            Text("Complete 🎉").font(.largeTitle)
            Button(action: {
                self.checkpoint = .startTask3
                self.seconds = countdownTime
                self.startTimer()
            }) {
                Text("Next Task")
            }.padding()
        }
    }

    func startTask3() -> some View {
        return ZStack {
            if (shouldNavigate) {
//                Task3View()
            } else if (!isCountdownDone && self.seconds > 0) {
                Text("\(self.seconds)").font(.system(size: 96)).bold()
            } else {
                VStack {
                    Text("TASK 3").font(.headline).bold()
                    Text("Draw something").font(.title)
                }
            }
        }
    }

    func endTask3() -> some View {
        print(String(self.isTestFinished))
        return VStack {
            Text("Task 3").font(.headline)
            Text("Complete 🎉").font(.largeTitle)
            Button(action: {
                self.isTestFinished = true
            }) {
                Text("Finish Test")
            }.padding()
            // TODO: Navigate to EyeTrackingTestView displaying the test completed
            NavigationLink(destination: EmptyView(),
                isActive: $isTestFinished) { EmptyView() }
        }
    }
    
    // MARK: - Timer functions
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.seconds == 0 {
                if !isCountdownDone {
                    self.isCountdownDone = true
                    self.seconds = instructionTime
                } else {
                    self.shouldNavigate = true
                    self.stopTimer()
                }
            } else {
                self.seconds = self.seconds - 1
            }
        }
    }
    
    private func stopTimer() {
        self.seconds = -1
        timer?.invalidate()
        timer = nil
    }
}

struct TestOverview_Previews: PreviewProvider {
    static var previews: some View {
        TestOverview(checkpoint: .startTest)
    }
}
