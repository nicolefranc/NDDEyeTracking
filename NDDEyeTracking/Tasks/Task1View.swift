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
            .navigationBarHidden(true)
    }
}

struct Task1_Previews: PreviewProvider {
    static var previews: some View {
        Task1View()
    }
}
