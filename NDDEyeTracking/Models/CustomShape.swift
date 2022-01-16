//
//  CustomShapes.swift
//  NDDEyeTracking
//
//  Created by Jason Shang on 6/21/21.
//

import Foundation
//import EyeTrackKit

class CustomShape: TaskData, Identifiable {
    var id: UUID
    var trackingData: [EyeTrackInfo]
    var shape: Pattern
    
    init(shape: Pattern, trackingData: [EyeTrackInfo]) {
        self.id = UUID()
        self.trackingData = trackingData
        self.shape = shape
        super.init(taskType: .task3)
    }
}
