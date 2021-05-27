//
//  Task1.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import SwiftUI

struct Task1: View {
    var body: some View {
        ZStack {
            EyeTrackingView()
            ImageTaskView()
//            EyeTrackingView()
        }
    }
}

struct Task1_Previews: PreviewProvider {
    static var previews: some View {
        Task1()
    }
}
