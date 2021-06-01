//
//  ImageTaskViewModel.swift
//  NDDEyeTracking
//
//  Created by Nicole Yu on 31/5/21.
//

import Foundation

class ImageTaskViewModel: ObservableObject {
    @Published var imageTask: ImageTask = ImageTask()
    
    var imageNames: [String] {
        var images: [String] = []
        for image in imageTask.images {
            images.append(image.filename)
        }
        
        return images
    }
}
