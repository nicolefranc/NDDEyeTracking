//
//  TasksView.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 2/6/21.
//

import SwiftUI

struct TasksView: View {
    @Binding var patient: Patient
    @EnvironmentObject var ettViewModel: ETTViewModel
    @Environment(\.presentationMode) var presentationMode // To programmatically dismiss view
    
    var body: some View {
        VStack {
            Button("Task Result") {
                ettViewModel.addTaskResult(key: "Task 1", result: "SUCCESS")
                patient.addTest(ett: ettViewModel.ett)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(patient: .constant(Patient("Worcestershire")))
    }
}
