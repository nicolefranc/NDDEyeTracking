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
    @Published var taskReport: TaskReport = TaskReport(initialText: "")
    
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
        
        taskReport.taskData = generateReport()
    }
    
    public func resetTracking() {
        self.eyeTrackData.removeAll()
        self.trackingStatus = .initialized
    }
    
    private func generateReport() -> String {
        var taskReport: String = ""
        
        for data in eyeTrackData {
            for col in data.toCSV {
                taskReport.append(col + ",")
            }
            taskReport.append("\n==================\n")
        }
        
        return taskReport
    }
    
    public func getReport() -> TaskReport {
        return taskReport
    }
}
