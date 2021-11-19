//
//  Task1Saliency.swift
//  NDDEyeTracking
//
//  Created by Edvin Berhan on 05.11.21.
//

import Foundation
import Vision

func getSaliency(imageName: String) -> CVPixelBuffer? {
    guard let imageURL = Bundle.main.url(forResource: "penguin", withExtension: nil)
    else { print("missing image"); return nil }
    // Is this the way to get the url for the asset??
    print(imageURL)
    
    let handler = VNImageRequestHandler(url: imageURL)
    let request: VNImageBasedRequest = VNGenerateAttentionBasedSaliencyImageRequest();
    request.revision = VNGenerateAttentionBasedSaliencyImageRequestRevision1
    
    try? handler.perform([request])
    guard let result = request.results?.first
    else { fatalError("missing result") }
    
    let observation = result as? VNSaliencyImageObservation
    
    let pixelbuffer = observation?.pixelBuffer
    
    return pixelbuffer
}
