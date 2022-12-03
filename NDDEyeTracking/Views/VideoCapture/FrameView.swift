//
//  FrameView.swift
//  NDDEyeTracking
//
//  Created by Jason Shang on 12/3/22.
//

import SwiftUI

struct FrameView: View {
    var image: CGImage?
    var display: Bool = true
    private let label = Text("frame")
    
    var body: some View {
        if display {
            if let image = image {
                GeometryReader { geometry in
                    Image(image, scale: 1.0, orientation: .up, label: label)
                      .resizable()
                      .scaledToFill()
                      .frame(
                        width: geometry.size.width,
                        height: geometry.size.height,
                        alignment: .center)
                      .clipped()
                  }
            } else {
                Color.black
            }
        }
    }
}

struct FrameView_Previews: PreviewProvider {
    static var previews: some View {
        FrameView()
    }
}
