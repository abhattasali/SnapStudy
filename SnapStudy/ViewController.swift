//  Copyright (c) 2019 abhattasali. All rights reserved.

import UIKit
import MobileCoreServices
import TesseractOCR
import GPUImage
import Reductio
import Foundation

class ViewController: UIViewController
{
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var loadingIcon: UIImageView!
  var testFlashset = FlashSet()
  
  
    
  override func viewDidLoad()
  {
    super.viewDidLoad()
    print(testFlashset.getDate())
    print(testFlashset.getSetName())
   
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let toggleNavigationController = segue.destination as? UINavigationController
    guard let wordToggleViewController = toggleNavigationController?.viewControllers.first as? WordToggleTest else {return}
    wordToggleViewController.wt_flashset = testFlashset
  }
  
    //CounterButton Stuff
    @IBOutlet weak var counterLabel: UILabel!
    var counter = 0
    
    

  // IBAction methods
  @IBAction func backgroundTapped(_ sender: Any) {
    view.endEditing(true)
  }
 
  @IBAction func takePhoto(_ sender: Any) {
        let imagePickerActionSheet =
            UIAlertController(title: "Snap/Upload Image", message: nil, preferredStyle: .actionSheet)
        // 2
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraButton = UIAlertAction(
                title: "Take Photo",
                style: .default) { (alert) -> Void in
                    self.counter = self.counter + 1
                    self.counterLabel.text = "\(self.counter)"
                    //self.activityIndicator.startAnimating()
                    self.loadingIcon.image = UIImage.animatedImageNamed("Loading-Book_", duration: 3.0)
                    UIView.animate(withDuration: 0.2) { self.loadingIcon.alpha = 1.0
                    }
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = .camera
                    imagePicker.mediaTypes = [kUTTypeImage as String]
                    self.present(imagePicker, animated: true, completion: {
                        //self.activityIndicator.stopAnimating()
                        UIView.animate(withDuration: 0.2) { self.loadingIcon.alpha = 0
                        }
                    })
            }
            imagePickerActionSheet.addAction(cameraButton)
        }
        
        // 3
        let libraryButton = UIAlertAction(
            title: "Choose Existing",
            style: .default) { (alert) -> Void in
                self.counter = self.counter + 1
                self.counterLabel.text = "\(self.counter)"
                //self.activityIndicator.startAnimating()
                self.loadingIcon.image = UIImage.animatedImageNamed("Loading-Book_", duration: 3.0)
                UIView.animate(withDuration: 0.2) { self.loadingIcon.alpha = 1.0
                }
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                imagePicker.mediaTypes = [kUTTypeImage as String]
                self.present(imagePicker, animated: true, completion: {
                    //self.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2) { self.loadingIcon.alpha = 0
                    }
                })
        }
        imagePickerActionSheet.addAction(libraryButton)
        // 4
    let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: {action in
        if self.counter != 0{
            self.counter = self.counter - 1
            self.counterLabel.text = "\(self.counter)"
            
        }
    })
        imagePickerActionSheet.addAction(cancelButton)
        // 5
        present(imagePickerActionSheet, animated: true)
    
    }
  
    // Tesseract Image Recognition
    func performImageRecognition(_ image: UIImage) {
        let scaledImage = image.scaledImage(1000) ?? image
        let preprocessedImage = scaledImage.preprocessedImage() ?? scaledImage
        
        /************************** !!! *************************/
        if let tesseract = G8Tesseract(language: "eng+fra") {
            tesseract.engineMode = .tesseractCubeCombined
            tesseract.pageSegmentationMode = .auto
            tesseract.image = preprocessedImage
            tesseract.recognize()
            textView.text = tesseract.recognizedText //IMPORTANT
          
          guard let myKeywords = tesseract.recognizedText else { return }
          Reductio.keywords(from: myKeywords, count: 7)
          {
            words in
            print(words)
            for keyword in words.sorted() {
              testFlashset.myWordCards[keyword] = Flashcard(keyword: keyword, definition: jsonExtract(key: keyword), image: UIImage())
            }
          }
        }
        //activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.2) { self.loadingIcon.alpha = 0
        }
    }
  
  func cutDef(def: String) -> String {
    if(def.count <= 500) { return def }
    var firstPeriod = 500
    while(firstPeriod != def.count && def[def.index(def.startIndex, offsetBy: firstPeriod)] != ".") {
      firstPeriod = firstPeriod + 1
    }
    return def[0...firstPeriod]
  }
  
  func jsonExtract(key: String) -> String {
    let url = Bundle.main.url(forResource: "dictionary", withExtension: "json")!
    let data = try! Data(contentsOf: url)
    do {
      // make sure this JSON is in the format we expect
      if let jsonFile = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
        if let definition: String = jsonFile[key] as? String { return cutDef(def: definition) } //DEFINITION
      }
    }
    catch let error as NSError {
      print("Failed to load: \(error.localizedDescription)")
    }
    return "No definition available at the time."
  }
  
}


// MARK: - UINavigationControllerDelegate
extension ViewController: UINavigationControllerDelegate {
}

extension String {
  subscript (bounds: CountableClosedRange<Int>) -> String {
    let start = index(startIndex, offsetBy: bounds.lowerBound)
    let end = index(startIndex, offsetBy: bounds.upperBound)
    return String(self[start...end])
  }
  
  subscript (bounds: CountableRange<Int>) -> String {
    let start = index(startIndex, offsetBy: bounds.lowerBound)
    let end = index(startIndex, offsetBy: bounds.upperBound)
    return String(self[start..<end])
  }
}

// MARK: - UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    // 1
    guard let selectedPhoto =
      info[.originalImage] as? UIImage else {
        dismiss(animated: true)
        return
    }
    //activityIndicator.startAnimating()
    UIView.animate(withDuration: 0.2) { self.loadingIcon.alpha = 1.0
    }
    dismiss(animated: true) {
      self.performImageRecognition(selectedPhoto)
    }
  }
}

extension UIImage
{
  func scaledImage(_ maxDimension: CGFloat) -> UIImage?
  {
    var scaledSize = CGSize(width: maxDimension, height: maxDimension)
    
    if size.width > size.height
    {
      scaledSize.height = size.height / size.width * scaledSize.width
    }
    else
    {
      scaledSize.width = size.width / size.height * scaledSize.height
    }

    UIGraphicsBeginImageContext(scaledSize)
    draw(in: CGRect(origin: .zero, size: scaledSize))
    let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return scaledImage
  }
  
  func preprocessedImage() -> UIImage?
  {
    let stillImageFilter = GPUImageAdaptiveThresholdFilter()
    stillImageFilter.blurRadiusInPixels = 15.0
    let filteredImage = stillImageFilter.image(byFilteringImage: self)
    return filteredImage
  }
  
}

