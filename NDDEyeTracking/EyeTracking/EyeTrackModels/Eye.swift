//
//  Eye.swift
//  NDDEyeTracking
//
//  Created by Jason Shang on 1/16/22.
//

import Foundation
import UIKit
import SceneKit
import ARKit

// 目情報保持クラス
public class Eye {
    public var lookAtPosition: CGPoint = CGPoint(x: 0, y: 0)
    public var lookAtPoint: CGPoint = CGPoint(x: 0, y: 0)
    public var node: SCNNode
    public var target: SCNNode
    public var blinkState: Float = 0.0 // instantaneous values of "blink" (continuous value from 0.0 - open to 1.0 - closed)
    
    //TODO: need to test and adjust this threshold
    private var blinkThreshold: Float = 0.9

    public var isShowRayHint: Bool
    
    public init(isShowRayHint: Bool = false) {
        self.isShowRayHint = isShowRayHint
        // Node生成 - research how to better model the eye with the SCNNode (and how do we test??)
        self.node = {
            let geometry = SCNCone(topRadius: 0.005, bottomRadius: 0, height: 0.1)
            geometry.radialSegmentCount = 3
            geometry.firstMaterial?.diffuse.contents = isShowRayHint ? UIColor.red : UIColor.clear
            let eyeNode = SCNNode()
            eyeNode.geometry = geometry
            eyeNode.eulerAngles.x = -.pi / 2
            eyeNode.position.z = 0.1

            let parentNode = SCNNode()
            parentNode.addChildNode(eyeNode)
            return parentNode
        }()
        self.target = SCNNode()
        self.node.addChildNode(self.target)
        self.target.position.z = 2
    }

    public func showHint() {
        self.node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
    }
    
    public func hideHint() {
        self.node.geometry?.firstMaterial?.diffuse.contents = UIColor.clear
    }
    
    // Deviceとの距離を取得
    public func getDistanceToDevice() -> Float {
        (self.node.worldPosition - SCNVector3Zero).length()
    }

    // [目と視点を結ぶ直線]と[デバイスのスクリーン平面]の交点を取得
    public func hittingAt(device: Device) -> CGPoint {
        let deviceScreenEyeHitTestResults = device.node.hitTestWithSegment(from: self.target.worldPosition, to: self.node.worldPosition, options: nil)
        for result in deviceScreenEyeHitTestResults {
            self.lookAtPosition.x = CGFloat(result.localCoordinates.x) / (device.screenSize.width / 2) * device.screenPointSize.width + device.compensation.x
            self.lookAtPosition.y = CGFloat(result.localCoordinates.y) / (device.screenSize.height / 2) * device.screenPointSize.height + device.compensation.y
            self.lookAtPoint = CGPoint(x: self.lookAtPosition.x + device.screenPointSize.width / 2, y: self.lookAtPosition.y + device.screenPointSize.height / 2)
        }

        return self.lookAtPosition
    }
    
    // blink = 0.0 is eye completely open, blink = 1.0 is eye completely closed
    public func updateBlinkState(blinkState: Float) {
        self.blinkState = blinkState
    }
}
