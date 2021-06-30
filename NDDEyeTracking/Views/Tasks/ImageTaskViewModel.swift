//
//  ImageTaskViewModel.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 2/6/21.
//

import Foundation
import EyeTrackKit

class ImageTaskViewModel: ObservableObject {
    @Published var images: [Photo]
    let tempDimensions: [Int] = [0, 0]
    
    // TODO: Implement actual image dimensions
    init() {
        images = [
            Photo(filename: "penguin", trackingData: [], dimensions: tempDimensions),
            Photo(filename: "snail", trackingData: [], dimensions: tempDimensions),
            Photo(filename: "field", trackingData: [], dimensions: tempDimensions)
        ]
    }
    
    var filenames: [String] {
        get {
            images.map { image in
                image.filename
            }
        }
    }
    
    func updateTrackingData(laps: [Int], trackingData: [EyeTrackInfo]) {
        // 1. Process trackingInfo: Split into laps
        print("========= UPDATING =========\n\(laps)")
        let firstLapData = Array(trackingData[...laps[0]])
        let secondLapData = Array(trackingData[laps[0] + 1...laps[1]])
        let lastLapData = Array(trackingData[laps[1] + 1...trackingData.count - 1])
        
        // 2. Add the lap data to the corresponding photo
        images[0].trackingData = firstLapData
        images[1].trackingData = secondLapData
        images[2].trackingData = lastLapData
    }
}
