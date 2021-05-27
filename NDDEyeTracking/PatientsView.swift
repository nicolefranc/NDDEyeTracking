//
//  PatientsView.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import SwiftUI

struct PatientsView: View {
    private var patients: [Patient] = DataStore.patients
    
    var body: some View {
        List {
            ForEach(patients) { patient in
                NavigationLink(
                    destination: PatientView(patient: patient),
                    label: {
                        Text(patient.name)
                    })
            }
        }
        .navigationBarTitle("Patients")
    }
}

struct PatientView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
