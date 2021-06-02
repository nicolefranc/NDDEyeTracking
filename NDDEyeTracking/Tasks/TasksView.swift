//
//  TasksView.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 2/6/21.
//

import SwiftUI

enum TaskType: String {
    case task1 = "Task 1"
    case task2 = "Task 2"
    case task3 = "Task 3"
}

struct TasksView: View {
    @Binding var patient: Patient
    @EnvironmentObject var ettViewModel: ETTViewModel
    
    @State var currentTask: TaskType = .task1
    
    var body: some View {
        VStack {
//            Button("Task Result") {
//                ettViewModel.addTaskResult(key: "Task 1", result: "YAAAYYYY")
////                patient.addTest(ett: ettViewModel.ett)
//                currentTask = .task3
//            }
            displayTask()
        }
    }
    
    @ViewBuilder
    private func displayTask() -> some View {
        switch currentTask {
        case .task1: Task1View(currentTask: $currentTask).environmentObject(ettViewModel)
        case .task2: Task2View()
        case .task3: Task3View(patient: $patient).environmentObject(ettViewModel)
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(patient: .constant(Patient("Worcestershire")))
    }
}
