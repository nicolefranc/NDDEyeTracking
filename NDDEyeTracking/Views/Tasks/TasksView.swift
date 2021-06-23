//
//  TasksView.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 2/6/21.
//

import SwiftUI

enum TaskType: String {
    case start
    case task1
    case task2
    case task3
}

struct TasksView: View {
    @Binding var patient: Patient
    @EnvironmentObject var ettViewModel: ETTViewModel
    
    @State var currentTask: TaskType = .start
    
    var body: some View {
        VStack {
            displayTask()
                .navigationBarHidden(true)
        }
    }
    
    @ViewBuilder
    private func displayTask() -> some View {
        switch currentTask {
        case .start: displayStartTest()
        case .task1: Task1View(currentTask: $currentTask).environmentObject(ettViewModel)
        case .task2: Task2View(currentTask: $currentTask).environmentObject(ettViewModel)
        case .task3: Task3View(currentTask: $currentTask).environmentObject(ettViewModel)
        }
    }
    
    @ViewBuilder
    private func displayStartTest() -> some View {
        VStack {
            Text("You are taking the Eye Tracking Test.").font(.title)
            Text("This test consists of 3 tasks.\nPress START to begin.").multilineTextAlignment(.center)
            Button(action: {
                currentTask = .task1
            }) {
                Text("Start").font(.title)
            }.padding()
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(patient: .constant(Patient("Worcestershire")))
    }
}
