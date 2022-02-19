//
//  DrawingData.swift
//  NDDEyeTracking
//
//  Created by Richard Deng on 27/6/21.
//

import Foundation
import CoreGraphics
import SwiftUI

// Main Data type for storing the drawing information
// Feel free to add values as necessary
class DrawingData {
    var coordinates : [ CGPoint ]
    var timestamps : [ TimeInterval ]
    var velocities : [ Double ]
    var forces : [ CGFloat ]
    var azimii : [ CGFloat ]
    var altitudes : [ CGFloat ]
    var started : Bool
    var frameWidth : CGFloat
    var frameHeight : CGFloat
//    Following variables used for calculating velocities
    var lastPoint : CGPoint
    var lastTime : TimeInterval
    
    
    init() {
        coordinates = [CGPoint]()
        timestamps = [TimeInterval]()
        velocities = [Double]()
        forces = [CGFloat]()
        azimii = [CGFloat]()
        altitudes = [CGFloat]()
        lastPoint = CGPoint(x: -1, y: -1)
        lastTime = TimeInterval()
        started = false
        frameWidth = 0.0
        frameHeight = 0.0
    }
    
    // Called when drawing has changed or started
    func update(value : UITouch, view : UIView) {
        let location = value.location(in: view)
        let azimuth = value.azimuthAngle(in: view)
        let altitude = value.altitudeAngle
        let force = value.force
        
        coordinates.append(location)
        timestamps.append(value.timestamp)
        forces.append(force)
        azimii.append(azimuth)
        altitudes.append(altitude)
        
        if !started {
            lastPoint = location
            lastTime = value.timestamp
            velocities.append(0)
            frameWidth = view.frame.size.width
            frameHeight = view.frame.size.height
            started = true
        } else {
            let timeint = value.timestamp - lastTime
            let distance = sqrt(pow(lastPoint.x - location.x, 2)
                + pow(lastPoint.y - location.y, 2))
            velocities.append(Double(distance) / timeint)
        }
    }
    
    // get URL of folder and/or filename passed in
    func getDocumentsDirectory(foldername foldercomponent : String?, filename pathcomponent : String) -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            .first!
        
        if let folder = foldercomponent {
            do {
                try FileManager.default.createDirectory(at: path.appendingPathComponent(folder), withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Could not create directory \(folder) at \(path)")
                print(error)
            }
            return path.appendingPathComponent(folder, isDirectory: true)
                .appendingPathComponent(pathcomponent, isDirectory: false)
        } else {
            return path.appendingPathComponent(pathcomponent, isDirectory: false)
        }
    }
    
    /**
        Stores drawing data; returns false if no drawing has been made (no coordinate point is recorded)
     */
    func finishDrawing(patient : String, drawingName : String = "drawing.csv") -> Bool {
        
        let url : URL = getDocumentsDirectory(foldername: patient, filename: drawingName)
        do {
        let str : String = CSVString()
            try str.write(to: url, atomically: true, encoding: .utf8)
            //let input = try String(contentsOf: url)
            //print(input)
        } catch {
            print("Failed to write to disk")
            print(error.localizedDescription)
        }
        return true
    }
    
    /**
    Converts file contents to a CSV string that can be printed to a file
     */
    private func CSVString() -> String {
        var str : String = "Coordinates ("  + frameWidth.description + "\",\" " + frameHeight.description + "),Timestamp,Velocity,force,azimuthAngle,altitudeAngle\n"
        for index in 0...coordinates.count - 1 {
            str = str + "\"" + coordinates[index].x.description + "," + coordinates[index].y.description + "\"," + timestamps[index].description + "," + velocities[index].description + "," + forces[index].description + "," + azimii[index].description + "," + altitudes[index].description + "\n"
        }

        return str
    }
    
    func printInfo() {
//        TODO
    }
    
    // Most likely will be unused, feel free to delete
    func convertToJSON() {
//        TODO
    }
}

