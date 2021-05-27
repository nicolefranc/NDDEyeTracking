//
//  ImageTaskView.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 27/5/21.
//

import SwiftUI

struct ImageTaskView: View {
    var body: some View {
        Image("penguin")
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
    }
}

struct ImageTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ImageTaskView()
    }
}
