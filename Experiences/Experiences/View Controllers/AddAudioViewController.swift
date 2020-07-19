//
//  AddAudioViewController.swift
//  Experiences
//
//  Created by patelpra on 7/19/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import UIKit
import AVFoundation

class AddAudioViewController: UIViewController {
    
    var recordingURL: URL?
    var audioRecorder: AVAudioRecorder?
    var delegate: AddMediaViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
