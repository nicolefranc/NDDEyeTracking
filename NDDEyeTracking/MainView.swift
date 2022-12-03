//
//  MainView.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 26/5/21.
//

import SwiftUI

struct MainView: View {
    @StateObject private var model = FrameHandler()
    
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
                NavigationLink(destination: VideoPreview(), label: {
                    Text("Video Preview")
                })
            }
            .navigationBarTitle("Menu")
            .padding(.leading, 1)
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
