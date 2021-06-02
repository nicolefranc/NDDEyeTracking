//
//  Photo.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 2/6/21.
//

import Foundation
import EyeTrackKit

class Photo {
    var filename: String
    var trackingData: [EyeTrackInfo]
    var dimensions: [Int]
    
    init(filename: String, trackingData: [EyeTrackInfo], dimensions: [Int]) {
        self.filename = filename
        self.trackingData = trackingData
        self.dimensions = dimensions
    }
}
