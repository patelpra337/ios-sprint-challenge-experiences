//
//  AddImageViewController.swift
//  Experiences
//
//  Created by patelpra on 7/19/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins
import Photos

protocol AddMediaViewControllerDelegate {
    func saveMedia(mediaType: MediaType, to url: URL)
}

class AddImageViewController: UIViewController {
    
    @IBOutlet var brightnessSlider: UISlider!
    @IBOutlet var contrastSlider: UISlider!
    @IBOutlet var saturationSlider: UISlider!
    @IBOutlet var blurSlider: UISlider!
    @IBOutlet var imageView: UIImageView!
    
    var originalImage: UIImage? {
        didSet {
            guard let originalImage = originalImage else {
                scaledImage = nil
                return
            }
            
            var scaledSize = imageView.bounds.size
            let scale = UIScreen.main.scale
            
            scaledSize = CGSize(width: scaledSize.width*scale,
                                height: scaledSize.height*scale)
            
            guard let scaledUIImage = originalImage.imageByScaling(toSize: scaledSize) else {
                scaledImage = nil
                return
            }
            
            scaledImage = CIImage(image: scaledUIImage)
        }
    }
    
    var scaledImage: CIImage? {
        didSet {
            updateImage()
        }
    }
    
    private let context = CIContext()
    private let colorControlsFilter = CIFilter.colorControls()
    private let blurFilter = CIFilter.gaussianBlur()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalImage = imageView.image
        presentImagePickerController()
    }
    
    var delegate: AddMediaViewControllerDelegate?
    
    private func image(byFiltering inputImage: CIImage) -> UIImage? {
        
        colorControlsFilter.inputImage = inputImage
        colorControlsFilter.saturation = saturationSlider.value
        colorControlsFilter.brightness = brightnessSlider.value
        colorControlsFilter.contrast = contrastSlider.value
        
        blurFilter.inputImage = colorControlsFilter.outputImage?.clampedToExtent()
        blurFilter.radius = blurSlider.value
        
        guard let outputImage = blurFilter.outputImage else { return originalImage! }
        
        guard let renderedImage = context.createCGImage(outputImage, from: inputImage.extent) else {
            return originalImage! }
        
        return UIImage(cgImage: renderedImage)
        }
                
    private func updateImage() {
        if let scaledImage = scaledImage {
            imageView.image = image(byFiltering: scaledImage)
        } else {
            imageView.image = nil
        }
    }
    
    private func presentImagePickerController() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("The photo library is not available")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func brightnessChanged(_ sender: Any) {
        updateImage()
    }
    @IBAction func contrastChanged(_ sender: Any) {
        updateImage()
    }
    @IBAction func saturationChanged(_ sender: Any) {
        updateImage()
    }
    @IBAction func blurChanged(_ sender: Any) {
        updateImage()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let originalImage = originalImage?.flattened, let ciImage = CIImage(image: originalImage) else { return }
        
        guard let processedImage = image(byFiltering: ciImage) else { return }
        let imageURL = MediaFormats.newURL(forType: .image)
        
        saveImage(image: processedImage, to: imageURL)
        delegate?.saveMedia(mediaType: .image, to: imageURL)
        
        navigationController?.popViewController(animated: true)
    }
    
    private func saveImage(image: UIImage, to url: URL) {
        if let imageData = image.pngData() {
            do {
                try imageData.write(to: url)
            } catch  let error {
                print("Error saving file: \(error)")
                
            }
        }
    }
}

extension AddImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            imageView.backgroundColor = .clear
            imageView.image = image
            originalImage = image
        } else if let image = info[.originalImage] as? UIImage {
            imageView.backgroundColor = .clear
            imageView.image = image
            originalImage = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
}
