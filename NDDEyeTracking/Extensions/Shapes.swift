//
//  Shapes.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 30/6/21.
//

import SwiftUI

/// This file consists of declarations of new shapes


// MARK: ArchSpiral

struct ArchSpiral: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for theta in stride(from: 0, through: 6.0*CGFloat.pi, by: 0.01) {
            let factor = UIScreen.screenWidth / 45
            let x = UIScreen.screenWidth*0.45 + cos(theta) * factor * theta
            let y = UIScreen.screenHeight*0.4 + sin(theta) * factor * theta
            if x > UIScreen.screenWidth || y > UIScreen.screenHeight  || x < 0 || y < 0 {
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


// MARK: Spirograph

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


// MARK: SpiroSquare

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
