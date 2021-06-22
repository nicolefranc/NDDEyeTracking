//
//  ImageTaskViewModel.swift
//  NDDEyeTracking
//
//  Created by Richard Deng on 21/6/21.
//

import Foundation
import EyeTrackKit

class DrawingTaskViewModel: ObservableObject {
    @Published var shapes: [Any]
    
    init() {
        drawings = [
            Template(shape: "circle", trackingData: [])
            /*Photo(filename: "penguin", trackingData: [], dimensions: tempDimensions),
            Photo(filename: "snail", trackingData: [], dimensions: tempDimensions),
            Photo(filename: "field", trackingData: [], dimensions: tempDimensions)*/
        ]
    }
    
    // TODO: Change trackingData type to [EyeTrackInfo]
    func updateTrackingData(laps: [Int], trackingData: [EyeTrackInfo]) {
        // 1. Process trackingInfo: Split into laps
        print("========= UPDATING =========\n\(laps)")
        let firstLapData = Array(trackingData[...laps[0]])
        //let secondLapData = Array(trackingData[laps[0] + 1...laps[1]])
        //let lastLapData = Array(trackingData[laps[1] + 1...trackingData.count - 1])
        
        // 2. Add the lap data to the corresponding photo
        drawings[0].trackingData = firstLapData
        //images[1].trackingData = secondLapData
        //images[2].trackingData = lastLapData
    }
}
