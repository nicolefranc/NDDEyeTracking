//
//  ImageTaskViewModel.swift
//  NDDEyeTracking
//
//  Created by Richard Deng on 21/6/21.
//

import Foundation
import EyeTrackKit

class DrawingTaskViewModel: ObservableObject {
    var shapes: [CustomShape] = [
        CustomShape(shape: .archSpiral, trackingData: []),
        CustomShape(shape: .spiroGraph, trackingData: []),
        CustomShape(shape: .spiroSquare, trackingData: [])
    ]
    
    func updateTrackingData(laps: [Int], trackingData: [EyeTrackInfo]) {
        // 1. Process trackingInfo: Split into laps
        print("========= UPDATING =========\n\(laps)")
        let firstLapData = Array(trackingData[...laps[0]])
        let secondLapData = Array(trackingData[laps[0] + 1...laps[1]])
        let lastLapData = Array(trackingData[laps[1] + 1...trackingData.count - 1])
        
        // 2. Add the lap data to the corresponding photo
        shapes[0].trackingData = firstLapData
        shapes[1].trackingData = secondLapData
        shapes[2].trackingData = lastLapData
    }
}
