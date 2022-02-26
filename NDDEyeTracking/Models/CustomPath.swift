//
//  CustomPath.swift
//  NDDEyeTracking
//
//  Created by Jason Shang on 6/23/21.
//

import Foundation
import SwiftUI
//import EyeTrackKit
import CoreGraphics

class CustomPath: TaskData, Identifiable {
    var id: String
    var trackingData: [EyeTrackInfo]
    var path: [CGPoint]
    
    init(trackingData: [EyeTrackInfo], pathFunc: () -> ([CGPoint], String)) {
        self.id = pathFunc().1
        self.trackingData = trackingData
        self.path = pathFunc().0
        super.init(taskType: .task2)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

// MARK: path array definition

func archSpiral() -> ([CGPoint], String) {
    var arr: [CGPoint] = []
    for theta in stride(from: 0, through: 6.0*CGFloat.pi, by: 0.01) {
        let factor = UIScreen.screenWidth / 45
        let x = UIScreen.screenWidth*0.45 + cos(theta) * factor * theta
        let y = UIScreen.screenHeight*0.4 + sin(theta) * factor * theta
        if x > UIScreen.screenWidth || y > UIScreen.screenHeight  || x < 0 || y < 0 {
            break
        }
        arr.append(CGPoint(x: x, y: y))
    }
    return (arr, Pattern.archSpiral.rawValue)
}
