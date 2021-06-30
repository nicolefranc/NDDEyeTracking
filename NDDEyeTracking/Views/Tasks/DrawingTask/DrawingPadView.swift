//
//  DrawingPadView.swift
//  NDDEyeTracking
//
//  Created by Richard Deng on 27/6/21.
//

import SwiftUI

struct Drawing {
    var points : [CGPoint] = [CGPoint]()
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

struct DrawingPadView: View {
    @Binding var currentDrawing : Drawing
    @Binding var drawings : [Drawing]
    let color : Color = .black
    let lineWidth : CGFloat = 3.0
    let user : DrawingData = DrawingData()
    
    /**
     This just prints the drawing so it is visible to the user, the drawing itself is updated and stored
     using the TouchCaptureView
     */
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for drawing in self.drawings {
                    self.add(drawing: drawing, toPath: &path)
                }
                self.add(drawing: self.currentDrawing, toPath: &path)
            }
            .stroke(self.color, lineWidth: self.lineWidth)
            .background(Color(white:0.95))
        }
        .frame(maxHeight: .infinity)
    }

    private func add(drawing : Drawing, toPath path : inout Path) {
        let points = drawing.points
        if points.count > 1 {
            for i in 0..<points.count - 1 {
                let current = points[i]
                let next = points[i+1]
                path.move(to: current)
                path.addLine(to: next)
            }
        }
    }
}


