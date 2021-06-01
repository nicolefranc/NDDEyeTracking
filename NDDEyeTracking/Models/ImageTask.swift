//
//  ImageTask.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 31/5/21.
//

import Foundation
import EyeTrackKit

struct ImageTask: Identifiable {
    private(set) var id: UUID
    var images: [TrackingData]
    var tempDimensions: [Int] = [0,0]
    
    init() {
        self.id = UUID()
        self.images = [
            ImageTask.TrackingData(filename: "penguin", dimensions: tempDimensions),
            ImageTask.TrackingData(filename: "snail", dimensions: tempDimensions),
            ImageTask.TrackingData(filename: "field", dimensions: tempDimensions)
        ]
    }
    
    mutating func saveRecording(data: TrackingData) {
        self.images.append(data)
    }
}

extension ImageTask {
    struct TrackingData: Identifiable {
        var id: UUID
        var filename: String
        var dimensions: [Int]
        var trackingInfo: [EyeTrackInfo]
        
        init(filename: String, dimensions: [Int]) {
            self.id = UUID()
            self.filename = filename
            self.dimensions = dimensions
            self.trackingInfo = []
        }
        
        mutating func addTrackInfo(data: [EyeTrackInfo]) {
            self.trackingInfo = data
        }
    }
}
