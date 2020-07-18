//
//  CameraPreviewView.swift
//  Experiences
//
//  Created by patelpra on 7/18/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import AVFoundation
import UIKit

/// Use this class to make a fullscreen or partial screen view that can
/// display a live camera preview

class CameraPreviewView: UIView {
    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
    
    var session: AVCaptureSession? {
        get { return videoPreviewLayer.session }
        set { videoPreviewLayer.session = newValue }
    }
}
