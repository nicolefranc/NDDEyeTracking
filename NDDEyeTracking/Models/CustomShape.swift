//
//  CustomShapes.swift
//  NDDEyeTracking
//
//  Created by Jason Shang on 6/21/21.
//

import Foundation
import SwiftUI
import CoreGraphics
import EyeTrackKit

class CustomShape: TaskData, Identifiable {
    var id: UUID
    var trackingData: [EyeTrackInfo]
    var shape: String
    
    init(shape: String, trackingData: [EyeTrackInfo], taskType: TaskType) {
        self.id = UUID()
        self.trackingData = trackingData
        self.shape = shape
        super.init(taskType: taskType)
    }
}

// MARK: shape structs

struct SpiroSquare: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rotations = 5
        let amount = .pi / CGFloat(rotations)
        let transform = CGAffineTransform(rotationAngle: amount)
        
        for _ in 0 ..< rotations {
            path = path.applying(transform)
            
            path.addRect(CGRect(x: -rect.width / 2, y: -rect.height / 2, width: rect.width, height: rect.height))
        }
        
        return path
    }
}

struct ArchSpiral: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for theta in stride(from: 0, through: 6.0*CGFloat.pi, by: 0.01) {
            let x = 500 + cos(theta) * 14 * theta
            let y = 250 + sin(theta) * 14 * theta
            if x > 800 || y > 800  || x < 0 || y < 0 {
                break
            }
            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            }
            else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        return path
    }
}

struct Spirograph: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for theta in stride(from: 0, through: 100*CGFloat.pi, by: 0.01) {
            let x = 500 + 5.5 * (25 * cos(theta) + 15 * cos(1/3 * theta))
            let y = 250 + 5.5 * (25 * sin(theta) - 15 * sin(1/3 * theta))
            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            }
            else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        return path
    }
}
