//
//  AppDelegate+Injection.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 26/5/21.
//

import Foundation
import Resolver
import EyeTrackKit

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { EyeTrackController(device: Device(type: .iPad), smoothingRange: 20, blinkThreshold: .infinity, isHidden: true) }.scope(.application)
        register { EyeDataController() }.scope(.application)
    }
}
