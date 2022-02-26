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
    @Published var paths: [CustomPath]
        
    init() {
        paths = [
            CustomPath(trackingData: [], pathFunc: archSpiral),
            CustomPath(trackingData: [], pathFunc: archSpiral),
            CustomPath(trackingData: [], pathFunc: archSpiral)
        ]
    }
    
    func updateTrackingData(laps: [Int], trackingData: [EyeTrackInfo]) {
        // 1. Process trackingInfo: Split into laps
        print("========= UPDATING =========\n\(laps)")
        let firstLapData = Array(trackingData[...laps[0]])
        let secondLapData = Array(trackingData[laps[0] + 1...laps[1]])
        let lastLapData = Array(trackingData[laps[1] + 1...trackingData.count - 1])
        
        // 2. Add the lap data to the corresponding photo
        paths[0].trackingData = firstLapData
        paths[1].trackingData = secondLapData
        paths[2].trackingData = lastLapData
    }
}
