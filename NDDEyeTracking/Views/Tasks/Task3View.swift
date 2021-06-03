//
//  Task3View.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 28/5/21.
//

import SwiftUI

struct Task3View: View {
    @Binding var patient: Patient
    @EnvironmentObject var ettViewModel: ETTViewModel
    @Environment(\.presentationMode) var presentationMode // To programmatically dismiss view
    
    var body: some View {
        VStack {
            Text("Task 3 View")
            Button("Finish Test") {
                ettViewModel.addTaskResult(key: "Task 3", result: [Task(taskType: .task3)])
                patient.addTest(ett: ettViewModel.ett)
                presentationMode.wrappedValue.dismiss()
            }
        }
            .navigationBarHidden(true)
    }
}

struct Task3View_Previews: PreviewProvider {
    static var previews: some View {
        Task3View(patient: .constant(Patient("Worcestershire")))
    }
}
