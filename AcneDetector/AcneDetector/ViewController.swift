//
//  ViewController.swift
//  AcneDetector
//
//  Created by Nguyen Tran on 7/18/22.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        picker.delegate = self
        picker.sourceType = .camera
        picker.mediaTypes = ["public.image"]
    }
    
    let picker = UIImagePickerController()

    @IBAction func imagePickerBarButtonDidTap(_ sender: UIBarButtonItem) {
        present(picker, animated: true)
    }
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var selectedImageView: UIImageView!
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                self.selectedImageView.image = image
                // pass it to vision
                guard let cgImage = image.cgImage
                else {
                    fatalError("cannot convert to cg image")
                }
                
                let handler = VNImageRequestHandler(cgImage: cgImage)
                let imageClassificationRequest = VNCoreMLRequest(model: ImagePredictor.shared.model) { request, error in
                    if let error = error {
                        print(error)
                        return
                    }
                    guard let observations = request.results as? [VNClassificationObservation] else {
                        print("VNRequest produced the wrong result type: \(type(of: request.results)).")
                        return
                    }
                    if let classification = observations.first {
                        self.resultLabel.text = classification.identifier
                    }

                    
                }
                ImagePredictor.shared.request.append(imageClassificationRequest)
                do {
                    try handler.perform(ImagePredictor.shared.request)
                }
                catch {
                    print(error.localizedDescription)
                }
                
                
                dismiss(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
}
