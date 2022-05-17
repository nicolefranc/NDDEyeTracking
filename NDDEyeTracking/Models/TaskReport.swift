//
//  testReport.swift
//  NDDEyeTracking
//
//  Created by Jason Shang on 5/14/22.
//

import SwiftUI
import UniformTypeIdentifiers

// contains string representing the eye track data collected for a single task
struct TaskReport: FileDocument, Codable, Hashable, Identifiable {

    // by default our document is empty
    var id: UUID
    var taskName = ""
    var taskReportText = ""
    
    // tell the system we support only plain text
    static var readableContentTypes = [UTType.plainText]

    // a simple initializer that creates new, empty documents
    init(taskName: String, taskReportText: String) {
        self.id = UUID()
        self.taskName = taskName
        self.taskReportText = taskReportText
        TaskReport.readableContentTypes = []
    }
    
    mutating func setTaskName(taskName: String) {
        self.taskName = taskName
    }

    // this initializer loads data that has been saved previously
    init(configuration: ReadConfiguration) throws {
        self.init(taskName: "", taskReportText: "")
        if let data = configuration.file.regularFileContents {
            taskReportText = String(decoding: data, as: UTF8.self)
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }

    // this will be called when the system wants to write our data to disk
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(taskReportText.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
    
    // print report String for debugging
    func printReport() {
        print("printing report: \(taskReportText)")
    }
    
    /**
     Called when a report is to be saved. Saves contents of this object to system storage for later access and conversion to CSV.
        Folder hierarchy: patient -> test -> task
     */
    func saveReport(patientID: UUID, testName: String) {
        let url : URL = getDocumentsDirectory(patientFolder: patientID.uuidString, testFolder: testName, taskFile: taskName)
        do {
        let str : String = taskReportText // CSV
            try str.write(to: url, atomically: true, encoding: .utf8)
            //let input = try String(contentsOf: url)
            print("URL: \(url)")
        } catch {
            print("Failed to write to disk")
            print(error.localizedDescription)
        }
    }
}
