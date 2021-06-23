//
//  ImageTaskViewModel.swift
//  NDDEyeTracking
//
//  Created by Richard Deng on 21/6/21.
//

import Foundation
import EyeTrackKit

class DrawingTaskViewModel: ObservableObject {
    var drawings: [CustomShape] = [
        CustomShape(shape: .archSpiral, trackingData: [], taskType: .task2),
        CustomShape(shape: .spiroGraph, trackingData: [], taskType: .task2),
        CustomShape(shape: .spiroSquare, trackingData: [], taskType: .task2)
    ]
    
    
    // TODO: Change trackingData type to [EyeTrackInfo]
    func updateTrackingData(laps: [Int], trackingData: [EyeTrackInfo]) {
        // 1. Process trackingInfo: Split into laps
        print("========= UPDATING =========\n\(laps)")
        let firstLapData = Array(trackingData[...laps[0]])
        let secondLapData = Array(trackingData[laps[0] + 1...laps[1]])
        let lastLapData = Array(trackingData[laps[1] + 1...trackingData.count - 1])
        
        // 2. Add the lap data to the corresponding photo
        drawings[0].trackingData = firstLapData
        drawings[1].trackingData = secondLapData
        drawings[2].trackingData = lastLapData
    }
}
