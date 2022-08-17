//
//  ViewController.swift
//  AcneDetector
//
//  Created by Nguyen Tran on 7/18/22.
//

import UIKit
import CoreML
import Vision

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        picker.delegate = self
//        picker.sourceType = .camera
        picker.sourceType = .photoLibrary
        picker.mediaTypes = ["public.image"]
        
        // testing json parsing
    }
    
    let picker = UIImagePickerController()

    @IBAction func imagePickerBarButtonDidTap(_ sender: UIBarButtonItem) {
        present(picker, animated: true)
    }
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var selectedImageView: UIImageView!
    
    func startLoad(title: String) {
//        let url = URL(string: "https://en.wikipedia.org/w/api.php?action=query&prop=extracts&titles=\(title)&format=json&exintro=0&indexpageids=1")!
        let url = URL(string: "https://en.wikipedia.org/w/api.php?action=query&prop=extracts&titles=acne&format=json&exintro=0&indexpageids=1")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                return
            }
            
            if let data = data {
                self.parseData(data: data)
            }
        }
        task.resume()
    }
    
    func parseData(data: Data) {
        let decoder = JSONDecoder()
        do {
            WikipediaResultManager.shared.wikiAPIResult = try decoder.decode(WikiAPIResults.self, from: data)
            
            DispatchQueue.main.sync {
                performSegue(withIdentifier: "homeToInfoSegue", sender: nil)
            }

            
        }
        catch {
            print(error.localizedDescription)
        }
    }
}


extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
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
                    if let classificationTextResult = observations.first {
                        
                        self.startLoad(title: classificationTextResult.identifier)
//                        self.resultLabel.text = classificationTextResult.identifier
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
