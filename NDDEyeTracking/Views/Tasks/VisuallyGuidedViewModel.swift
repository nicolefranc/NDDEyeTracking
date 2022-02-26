//
//  VisuallyGuidedViewModel.swift
//  NDDEyeTracking
//
//  Created by Haojin Li on 1/14/21.
//

import Foundation
import EyeTrackKit
import SwiftUI

class VisuallyGuidedViewModel: ObservableObject {
    @Published var points: [CGPoint]
        
    init() {
        points = [
            CGPoint(x: UIScreen.screenWidth/3, y: UIScreen.screenHeight/2),
            CGPoint(x: UIScreen.screenWidth/1.4, y: UIScreen.screenHeight/2.2),
            CGPoint(x: UIScreen.screenWidth/7, y: UIScreen.screenHeight/1),
            CGPoint(x: UIScreen.screenWidth/3.2, y: UIScreen.screenHeight/3),
            CGPoint(x: UIScreen.screenWidth/5.5, y: UIScreen.screenHeight/4.4),
            CGPoint(x: UIScreen.screenWidth/2, y: UIScreen.screenHeight/2.7)
        ]
    }
    
//    func updateTrackingData(laps: [Int], trackingData: [EyeTrackInfo]) {
//        // 1. Process trackingInfo: Split into laps
//        print("========= UPDATING =========\n\(laps)")
//        let firstLapData = Array(trackingData[...laps[0]])
//        let secondLapData = Array(trackingData[laps[0] + 1...laps[1]])
//        let lastLapData = Array(trackingData[laps[1] + 1...trackingData.count - 1])
//
//        // 2. Add the lap data to the corresponding photo
//        paths[0].trackingData = firstLapData
//        paths[1].trackingData = secondLapData
//        paths[2].trackingData = lastLapData
//    }
    
    
}
