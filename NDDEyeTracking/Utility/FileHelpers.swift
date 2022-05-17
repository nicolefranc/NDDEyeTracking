//
//  FileHelpers.swift
//  Neuro Platform
//
//  Created by user175482 on 7/27/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import Foundation
import SwiftUI

// get URL of folder and/or filename passed in
// used in DrawingView finishInfo and DataObjects finishDrawing functions
func getDocumentsDirectory(patientFolder: String?, testFolder: String?, taskFile: String?) -> URL {
    var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        .first!
    
    if let folder = patientFolder {
        do {
            try FileManager.default.createDirectory(at: path.appendingPathComponent(patientFolder!), withIntermediateDirectories: true, attributes: nil)
            path = path.appendingPathComponent(patientFolder!)
            print("INTERMEDIATE PATH: \(path)")
            try FileManager.default.createDirectory(at: path.appendingPathComponent(testFolder!), withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Could not create directory \(folder) at \(path)")
            print(error)
        }
        return path.appendingPathComponent(testFolder!, isDirectory: true)
            .appendingPathComponent(taskFile!, isDirectory: false)
    } else {
        return path.appendingPathComponent(testFolder!, isDirectory: true)
            .appendingPathComponent(taskFile!, isDirectory: false)
    }
}

// Original app root directory URL
func getDocumentsDirectoryRoot() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
}
