//
//  Face.swift
//  NDDEyeTracking
//
//  Created by Jason Shang on 1/16/22.
//

import Foundation
import UIKit
import SceneKit
import ARKit

// 顔情報保持クラス
public class Face {
    public let node: SCNNode
    public let rightEye: Eye
    public let leftEye: Eye
    public var transform: simd_float4x4 = simd_float4x4()


    public init(isShowRayHint: Bool = false) {
        // Node生成
        self.node = SCNNode()
        self.rightEye = Eye(isShowRayHint: isShowRayHint)
        self.leftEye = Eye(isShowRayHint: isShowRayHint)
        self.node.addChildNode(self.leftEye.node)
        self.node.addChildNode(self.rightEye.node)
    }

    public func update(anchor: ARFaceAnchor) {
        // 座標更新
        self.transform = anchor.transform
        self.leftEye.node.simdTransform = anchor.leftEyeTransform
        self.rightEye.node.simdTransform = anchor.rightEyeTransform
        // 瞬き情報更新
        updateBlink(anchor: anchor)
    }
    
    private func updateBlink(anchor: ARFaceAnchor) {
        leftEye.updateBlink(blink: anchor.blendShapes[.eyeBlinkLeft]?.floatValue ?? 0.0)
        rightEye.updateBlink(blink: anchor.blendShapes[.eyeBlinkRight]?.floatValue ?? 0.0)
//        self.leftEye.blink = anchor.blendShapes[.eyeBlinkLeft]?.floatValue ?? 0.0
//        self.rightEye.blink = anchor.blendShapes[.eyeBlinkRight]?.floatValue ?? 0.0
    }

    // デバイスとの距離を取得
    public func getDistanceToDevice() -> Float {
        // Average distance from two eyes
        (self.leftEye.getDistanceToDevice() + self.rightEye.getDistanceToDevice()) / 2
    }
}
