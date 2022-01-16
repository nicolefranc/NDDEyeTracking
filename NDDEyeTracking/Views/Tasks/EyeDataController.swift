//
//  DataController.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 2/6/21.
//

import Foundation
//import EyeTrackKit

enum TrackingStatus {
    case initialized
    case recording
    case finished
}

class EyeDataController: ObservableObject {
    @Published var trackingStatus: TrackingStatus = .initialized
    @Published var eyeTrackData: [EyeTrackInfo] = []
    @Published var laps: [Int] = []
    
    public func startRecording() {
        self.trackingStatus = .recording
    }
    
    public func addTrackingData(info: EyeTrackInfo) {
        if self.trackingStatus == .recording {
            self.eyeTrackData.append(info)
        }
    }
    
    public func takeLap() {
        laps.append(eyeTrackData.count)
        print(laps)
    }
    
    public func stopRecording() {
        print("Acquired \(eyeTrackData.count) frames")
        self.trackingStatus = .finished
    }
    
    public func resetTracking() {
        self.eyeTrackData.removeAll()
        self.trackingStatus = .initialized
    }
}
