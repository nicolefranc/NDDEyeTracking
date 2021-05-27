//
//  MainView.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 26/5/21.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination: PatientsView(),
                    label: {
                        Text("Patients")
                    })
                NavigationLink(
                    destination: AboutView(),
                    label: {
                        Text("About")
                    })
            }
            .navigationBarTitle("Menu")
            .padding(.leading, 1)
            PatientsView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
