//
//  ImagePredictor.swift
//  AcneDetector
//
//  Created by Nguyen Tran on 7/19/22.
//

import Foundation
import Vision
import CoreML

class ImagePredictor {
    
    static let shared = ImagePredictor()
    var model:VNCoreMLModel
    var request = [VNRequest]()
    
    private init() {
        model = ImagePredictor.createImageClassifier()
    }
    
    static func createImageClassifier() -> VNCoreMLModel {
        // Use a default model configuration.
        let defaultConfig = MLModelConfiguration()

        // Create an instance of the image classifier's wrapper class.
        let imageClassifierWrapper = try? AcneClassifier_1(configuration: defaultConfig)

        guard let imageClassifier = imageClassifierWrapper else {
            fatalError("App failed to create an image classifier model instance.")
        }

        // Get the underlying model instance.
        let imageClassifierModel = imageClassifier.model

        // Create a Vision instance using the image classifier's model instance.
        guard let imageClassifierVisionModel = try? VNCoreMLModel(for: imageClassifierModel) else {
            fatalError("App failed to create a `VNCoreMLModel` instance.")
        }

        return imageClassifierVisionModel
    }
}
