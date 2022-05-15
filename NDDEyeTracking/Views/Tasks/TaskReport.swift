//
//  testReport.swift
//  NDDEyeTracking
//
//  Created by Jason Shang on 5/14/22.
//

import SwiftUI
import UniformTypeIdentifiers

// contains string representing the eye track data collected for a single task
struct TaskReport: FileDocument {
    // tell the system we support only plain text
    static var readableContentTypes = [UTType.plainText]

    // by default our document is empty
    var taskData = ""

    // a simple initializer that creates new, empty documents
    init(initialText: String = "") {
        taskData = initialText
    }

    // this initializer loads data that has been saved previously
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            taskData = String(decoding: data, as: UTF8.self)
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }

    // this will be called when the system wants to write our data to disk
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(taskData.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}
