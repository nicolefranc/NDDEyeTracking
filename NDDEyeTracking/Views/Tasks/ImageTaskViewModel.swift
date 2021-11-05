//
//  ImageTaskViewModel.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 2/6/21.
//

import Foundation
import EyeTrackKit

enum Task1Checkpoint {
    case instructions
    case task
    case complete
}

class ImageTaskViewModel: ObservableObject {

    @Published private (set) var checkpoint: Task1Checkpoint = .instructions
    func setCheckpoint(to newCheckpoint: Task1Checkpoint) {
        self.checkpoint = newCheckpoint
    }
    
    static let tempDimensions: [Int] = [0, 0]
    
    let images: [Photo] =
        [
            Photo(filename: "penguin", trackingData: [], dimensions: tempDimensions),
            Photo(filename: "snail", trackingData: [], dimensions: tempDimensions),
            Photo(filename: "field", trackingData: [], dimensions: tempDimensions)
        ]
    
    var filenames: [String] {
        images.map { $0.filename }
    }
    
    // MARK: - Timer Constants
    static let defaultImageSeconds: Double = 5
//    static let defaultCountdownSeconds: Int = 3
//    static let defaultInstructionsSeconds: Int = 3
    
    @Published var timer = Timer.publish(every: defaultImageSeconds, on: .main, in: .common).autoconnect()

    
    
    // TODO: Change trackingData type to [EyeTrackInfo]
    func updateTrackingData(laps: [Int], trackingData: [EyeTrackInfo]) {
        // If there was no data collected, we return
        if (laps[0] == 0) {
            return
        }
        // 1. Process trackingInfo: Split into laps
        print("========= UPDATING =========\n\(laps)")

        let firstLapData = Array(trackingData[...laps[0]])
        let secondLapData = Array(trackingData[laps[0] + 1...laps[1]])
        let lastLapData = Array(trackingData[laps[1] + 1...trackingData.count - 1])
        
        // 2. Add the lap data to the corresponding photo
        images[0].trackingData = firstLapData
        images[1].trackingData = secondLapData
        images[2].trackingData = lastLapData
    }
}
