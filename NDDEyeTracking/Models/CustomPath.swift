//
//  CustomPath.swift
//  NDDEyeTracking
//
//  Created by Jason Shang on 6/23/21.
//

import Foundation
import SwiftUI
import EyeTrackKit
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
}

// MARK: path array definition

func archSpiral() -> ([CGPoint], String) {
    var arr: [CGPoint] = []
    for theta in stride(from: 0, through: 6.0*CGFloat.pi, by: 0.01) {
        let x = 500 + cos(theta) * 14 * theta
        let y = 250 + sin(theta) * 14 * theta
        if x > 800 || y > 800  || x < 0 || y < 0 {
            break
        }
        arr.append(CGPoint(x: x, y: y))
    }
    return (arr, "ArchSpiral")
}
