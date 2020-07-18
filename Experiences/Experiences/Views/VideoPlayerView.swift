//
//  VideoPlayerView.swift
//  Experiences
//
//  Created by patelpra on 7/18/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import AVFoundation
import UIKit

/// Use this class to make a full screen or partial screen view to display
/// video from an AVPlayer

class VideoPlayerView: UIView {
    
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    var videoPlayerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    var player: AVPlayer? {
        get { return videoPlayerLayer.player }
        set { videoPlayerLayer.player = newValue }
    }
}
