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
    
    init() {
        images = [
            Photo(filename: "penguin", trackingData: [], dimensions: tempDimensions),
            Photo(filename: "snail", trackingData: [], dimensions: tempDimensions),
            Photo(filename: "field", trackingData: [], dimensions: tempDimensions)
        ]
    }
    
    // TODO: Change trackingData type to [EyeTrackInfo]
    func updateTrackingData(imageIndex: Int, trackingData: [String]) {
        images[imageIndex].trackingData = trackingData
    }
}
