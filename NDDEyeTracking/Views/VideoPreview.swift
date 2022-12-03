//
//  VideoPreviewView.swift
//  NDDEyeTracking
//
//  Created by Jason Shang on 12/3/22.
//

import SwiftUI

struct VideoPreview: View {
    @StateObject private var model = FrameHandler()
    
    var body: some View {
        FrameView(image: model.frame)
    }
}

struct VideoPreview_Previews: PreviewProvider {
    static var previews: some View {
        VideoPreview()
    }
}
