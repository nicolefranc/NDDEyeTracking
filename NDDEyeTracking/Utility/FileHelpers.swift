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
    var path = getDocumentsDirectoryRoot()
//    print("DIRECTORY ROOT: \(path)")
    do {
        let urls = try FileManager.default.contentsOfDirectory(at: getDocumentsDirectoryRoot(), includingPropertiesForKeys: nil, options: .skipsSubdirectoryDescendants)
//        print("url array: \(urls)")

    }
    catch {
        print("error")
    }

    
    if let folder = patientFolder {
        do {
            try FileManager.default.createDirectory(at: path.appendingPathComponent(patientFolder!), withIntermediateDirectories: true, attributes: nil)
            path = path.appendingPathComponent(patientFolder!)
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

func getExportURLs(patientIDSelection: Set<UUID>) -> Set<URL> {
    print("SELECTION SIZE: \(patientIDSelection.count)")
    var exportURLs = Set<URL>()
    var idStrings = Set<String>()
    for patientID in patientIDSelection {
        idStrings.insert(patientID.uuidString)
    }
    let urls : [URL]
    do {
        try urls = FileManager.default.contentsOfDirectory(at: getDocumentsDirectoryRoot(), includingPropertiesForKeys: nil, options: .skipsSubdirectoryDescendants)
    } catch {
        print("urls array did not get initialized")
        urls = [URL]()
    }
    for url in urls {
        print("URL ARRAY URL: \(url)")
        let patientID = url.lastPathComponent
        if idStrings.contains(String(patientID)) {
            exportURLs.insert(url)
        }
    }
    return exportURLs
}

//// Updates the URL path to create differently named directories every time we export (named based on date & time of export)
//func updateDocumentsPath(createDirectory: Bool, patientSelection: Set<Patient>) -> URL {
//    var selectionIDs = Set<String>()
//    for patient in patientSelection {
//        selectionIDs.insert(patient.id.uuidString)
//    }
//
//    // root documents directory
//    let path = getDocumentsDirectoryRoot()
//    if (createDirectory) {
//        // get current date to add as name of new directory in documents directory (to export)
//        let now = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMM-d-y-HH:mm"
//        let folderName: String = formatter.string(from: now)
//
//        do {
//            try FileManager.default.createDirectory(at: path.appendingPathComponent(folderName), withIntermediateDirectories: true, attributes: nil)
//        } catch {
//            print("Could not create directory \(folderName) at \(path)")
//        }
//
//        let newRootDirectory = path.appendingPathComponent(folderName, isDirectory: true)
//
//        let urls : [URL]
//        do {
//            try urls = FileManager.default.contentsOfDirectory(at: getDocumentsDirectoryRoot(), includingPropertiesForKeys: nil, options: .skipsSubdirectoryDescendants)
//        } catch {
//            print("urls array did not get initialized")
//            urls = [URL]()
//        }
//
//        for url in urls {
//            print("URL ARRAY URL: \(url)")
//            let components = url.absoluteString.split(separator: "/")
//            let patientID = components[components.count - 3]
//            if selectionIDs.contains(String(patientID)) {
//                let newURL = newRootDirectory.appendingPathComponent(url.lastPathComponent)
//                do {
//                    try FileManager.default.moveItem(at: url, to: newURL)
//                } catch {
//                    print("Could not move item from \(url) to \(newURL)")
//                }
//            }
//        }
//        print("UPDATED URL: \(newRootDirectory)")
//        return newRootDirectory
//    } else {
//        return path
//    }
//}

// Original app root directory URL
func getDocumentsDirectoryRoot() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
}
