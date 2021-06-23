//
//  CustomPath.swift
//  NDDEyeTracking
//
//  Created by Jason Shang on 6/23/21.
//

import Foundation
import SwiftUI
import EyeTrackKit
import CoreGraphics

class CustomPath: TaskData, Identifiable {
    var id: UUID
    var trackingData: [EyeTrackInfo]
    var path: [CGPoint]
    
    init(path: [CGPoint], trackingData: [EyeTrackInfo]) {
        self.id = UUID()
        self.trackingData = trackingData
        self.path = path
        super.init(taskType: .task2)
    }
}

// MARK: path array definition

private var archSpiralArray: [CGPoint] = {
    
}
