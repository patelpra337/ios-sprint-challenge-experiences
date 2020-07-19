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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var delegate: AddMediaViewControllerDelegate?
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
