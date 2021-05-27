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

struct TestOverview: View {
    @State private var checkpoint: Checkpoint
    @State private var seconds: Int = 3
    @State private var isTimerStopped = false
    @State private var timer: Timer? = nil
    @State private var shouldNavigate: Bool = false
    
    var body: some View {
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
    
    init(checkpoint: Checkpoint) {
        self.checkpoint = checkpoint
    }
    
    func startTest() -> some View {
        return VStack {
            Text("You are taking the Eye Tracking Test.").font(.title)
            Text("This test consists of 3 tasks.\nPress START to begin.").multilineTextAlignment(.center)
            Button(action: {
                checkpoint = .startTask1
                seconds = 3
                self.startTimer()
            }) {
                Text("Start").font(.title)
            }.padding()
        }
    }
    
    func startTask1() -> some View {
        ZStack {
            if (shouldNavigate) {
                Task1()
            } else if (self.seconds  > 0) {
                Text("\(self.seconds)").font(.system(size: 96)).bold()
            } else {
                VStack {
                    Text("TASK 1").font(.headline).bold()
                    Text("Look at the images carefully.").font(.title)
                }
            }
        }
    }
    
    func endTask1() -> some View {
        return ZStack {
            Text("End task 1")
        }
    }

    func startTask2() -> some View {
        return ZStack {
            Text("Start task 2")
        }
    }

    func endTask2() -> some View {
        return ZStack {
            Text("End task 2")
        }
    }

    func startTask3() -> some View {
        return ZStack {
            Text("Start task 3")
        }
    }

    func endTask3() -> some View {
        return ZStack {
            Text("End task 3")
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.seconds == -3 {
                self.shouldNavigate = true
                self.stopTimer()
            } else {
                self.seconds = self.seconds - 1
            }
        }
    }
    
    func stopTimer() {
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
