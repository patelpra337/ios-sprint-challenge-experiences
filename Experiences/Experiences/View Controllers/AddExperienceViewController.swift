//
//  AddExperienceViewController.swift
//  Experiences
//
//  Created by patelpra on 7/18/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import UIKit

class AddExperienceViewController: UIViewController {
    
    var experienceController: ExperienceController!
    
    var imageURL: URL?
    var audioURL: URL?
    var videoURL: URL?
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var audioButton: UIButton!
    @IBOutlet var videoButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        audioButton.layer.cornerRadius = BR.buttonCornerRadius
        videoButton.layer.cornerRadius = BR.buttonCornerRadius
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty else { return }
        
        experienceController.createExperience(title: title, imageURL: imageURL, audioURL: audioURL, videoURL: videoURL)
        
        dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.addImageSegue {
            guard let destinationVC = segue.destination as? AddImageViewController else { return }
            destinationVC.delegate = self
        } else if segue.identifier == SegueIdentifiers.addAudioSegue {
            guard let destinationVC = segue.destination as? AddAudioViewController else { return }
            destinationVC.delegate = self
        } else if segue.identifier == SegueIdentifiers.addVideoSegue {
            guard let destinationVC = segue.destination as? AddVideoViewController else { return }
            destinationVC.delegate = self
        }
    }
    
    private func image(at url: URL) -> UIImage? {
        guard let imageData = FileManager.default.contents(atPath: url.relativePath),
            let image = UIImage(data: imageData) else { return nil }
        
        return image
    }
}

extension AddExperienceViewController: AddMediaViewControllerDelegate {
    func saveMedia(mediaType: MediaType, to url: URL) {
        switch mediaType {
        case .image:
            imageURL = url
            if let image = image(at: url) {
                imageView.contentMode = .scaleAspectFit
                imageView.backgroundColor = .clear
                imageView.image = image
            }
        case .audio:
            audioURL = url
            audioButton.setTitle("Re-record Audio", for: .normal)
        case .video:
            videoURL = url
            videoButton.setTitle("Re-record Video", for: .normal)
        }
    }
}

