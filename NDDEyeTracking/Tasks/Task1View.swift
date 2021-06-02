//
//  Task1View.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import SwiftUI

struct Task1View: View {
    @EnvironmentObject var ettViewModel: ETTViewModel
    @Binding var currentTask: TaskType
    
    var body: some View {
//        ZStack {
//            ImageTaskView()
//            EyeTrackingView()
//        }
//            .navigationBarHidden(true)
        
        VStack {
            Button("Task 1 Result") {
                ettViewModel.addTaskResult(key: "Task 1", result: "SUCCESS")
                currentTask = .task3
            }
        }
    }
}

struct Task1_Previews: PreviewProvider {
    static var previews: some View {
        Task1View(currentTask: .constant(.task1))
    }
}
