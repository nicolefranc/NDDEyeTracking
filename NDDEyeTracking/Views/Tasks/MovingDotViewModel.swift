//
//  MovingDotViewModel.swift
//  NDDEyeTracking
//
//  Created by Jason Shang on 6/21/21.
//

import Foundation
import EyeTrackKit
import SwiftUI

class MovingDotViewModel: ObservableObject {
    var shapes: [CustomShape] = [
        CustomShape(shape: .archSpiral, trackingData: [], taskType: .task2),
        CustomShape(shape: .spiroGraph, trackingData: [], taskType: .task2),
        CustomShape(shape: .spiroSquare, trackingData: [], taskType: .task2),
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
