//
//  Task1View.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import SwiftUI

struct Task1View: View {
    @State private var seconds: Int = 3
    @State private var isTimerStopped = false
    @State private var timer: Timer? = nil
    @State private var shouldNavigate: Bool = false
    @State private var isTaskComplete = false
    
    var body: some View {
        ZStack {
            ImageTaskView()
            EyeTrackingView()
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.seconds == -3 {
                self.shouldNavigate = true
                self.stopTimer()
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

struct Task1_Previews: PreviewProvider {
    static var previews: some View {
        Task1View()
    }
}
