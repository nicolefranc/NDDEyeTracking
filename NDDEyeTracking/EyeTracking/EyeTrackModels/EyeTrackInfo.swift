//
//  EyeTrackInfo.swift
//  NDDEyeTracking
//
//  Created by Jason Shang on 1/16/22.
//

import Foundation
import ARKit

public class EyeTrackInfo {
    private var formatter = DateFormatter()

    public static let CSV_COLUMNS = ["timestamp", "isTracked",
                                     "faceRotaion-x", "faceRotaion-y", "faceRotaion-z", "faceRotaion-w",
                                     "facePosition-x", "facePosition-y", "facePosition-z",
                                     "deviceRotation-x", "deviceRotation-y", "deviceRotation-z", "deviceRotation-w",
                                     "devicePosition-x", "devicePosition-y", "devicePosition-z",
                                     "rightEyePotision-x", "rightEyePotision-y", "rightEyePotision-z",
                                     "leftEyePotision-x", "leftEyePotision-y", "leftEyePotision-z",
                                     "rightEyeLookAtPosition-x", "rightEyeLookAtPosition-y", "rightEyeLookAtPosition-z",
                                     "leftEyeLookAtPosition-x", "leftEyeLookAtPosition-y", "leftEyeLookAtPosition-z",
                                     "rightEyeLookAtPoint-x", "rightEyeLookAtPoint-y",
                                     "leftEyeLookAtPoint-x", "leftEyeLookAtPoint-y",
                                     "centerEyeLookAtPoint-x", "centerEyeLookAtPoint-y",
                                     "rightEyeBlink", "leftEyeBlink",
                                     "rightEyeDistance", "leftEyeDistance"]
    public var timestamp: Date
    public var isTracked: Bool

    public var faceRotation: SCNVector4
    public var facePosition: SCNVector3
    
    public var devicePosition: SCNVector3
    public var deviceRotation: SCNVector4
    
    public var rightEyePosition: SCNVector3
    public var leftEyePosition: SCNVector3

    public var rightEyeLookAtPosition: SCNVector3
    public var leftEyeLookAtPosition: SCNVector3

    public var rightEyeLookAtPoint: CGPoint
    public var leftEyeLookAtPoint: CGPoint
    public var centerEyeLookAtPoint: CGPoint

    public var rightEyeBlinkState: Float
    public var leftEyeBlinkState: Float

    public var rightEyeDistance: Float
    public var leftEyeDistance: Float


    public init(face: Face, device: Device, lookAtPoint: CGPoint, isTracked: Bool) {
        self.timestamp = Date.init()
        self.isTracked = isTracked

        self.faceRotation = face.node.worldOrientation
        self.facePosition = face.node.worldPosition
        self.deviceRotation = device.node.worldOrientation
        self.devicePosition = device.node.worldPosition
        self.rightEyePosition = face.rightEye.node.worldPosition
        self.leftEyePosition = face.leftEye.node.worldPosition

        self.rightEyeLookAtPosition = face.rightEye.target.worldPosition
        self.leftEyeLookAtPosition = face.leftEye.target.worldPosition

        self.rightEyeLookAtPoint = face.rightEye.lookAtPoint
        self.leftEyeLookAtPoint = face.leftEye.lookAtPoint
        self.centerEyeLookAtPoint = lookAtPoint

        self.rightEyeBlinkState = face.rightEye.blinkState
        self.leftEyeBlinkState = face.leftEye.blinkState
        
        self.rightEyeDistance = face.rightEye.getDistanceToDevice()
        self.leftEyeDistance = face.leftEye.getDistanceToDevice()

        formatter.dateFormat = "yyyyMMddHHmmssSSSSS"
    }

    public var toCSV: [String] {
        let detail = [dateToString(date: self.timestamp), String(self.isTracked)]
        let worldPosition = [
            String(self.faceRotation.x), String(self.faceRotation.y), String(self.faceRotation.z), String(self.faceRotation.w),
            String(self.facePosition.x), String(self.facePosition.y), String(self.facePosition.z),
            String(self.deviceRotation.x), String(self.deviceRotation.y), String(self.deviceRotation.z), String(self.deviceRotation.w),
            String(self.devicePosition.x), String(self.devicePosition.y), String(self.devicePosition.z),
            String(self.rightEyePosition.x), String(self.rightEyePosition.y), String(self.rightEyePosition.z),
            String(self.leftEyePosition.x), String(self.leftEyePosition.y), String(self.leftEyePosition.z)]
        let lookAtPosition = [
            String(self.rightEyeLookAtPosition.x), String(self.rightEyeLookAtPosition.y), String(self.rightEyeLookAtPosition.z),
            String(self.leftEyeLookAtPosition.x), String(self.leftEyeLookAtPosition.y), String(self.leftEyeLookAtPosition.z)]
        let lookAtPoint = [
            String(format: "%.8F", Float(self.rightEyeLookAtPoint.x)), String(format: "%.8F", Float(self.rightEyeLookAtPoint.y)),
            String(format: "%.8F", Float(self.leftEyeLookAtPoint.x)), String(format: "%.8F", Float(self.leftEyeLookAtPoint.y)),
            String(format: "%.8F", Float(self.centerEyeLookAtPoint.x)), String(format: "%.8F", Float(self.centerEyeLookAtPoint.y))]
        let eyeself = [
            String(self.rightEyeBlinkState), String(self.leftEyeBlinkState),
            String(self.rightEyeDistance), String(self.leftEyeDistance)]
        var row = detail + worldPosition
        row = row + lookAtPosition
        row = row + lookAtPoint
        row = row + eyeself
        return row
    }

    public func dateToString(date: Date) -> String {
        return formatter.string(from: date)
    }
}
