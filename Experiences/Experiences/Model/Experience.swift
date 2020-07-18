//
//  Experience.swift
//  Experiences
//
//  Created by patelpra on 7/18/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation
import MapKit

enum MediaType: String, CaseIterable {
    case image, audio, video
}

class Experience: NSObject {
    
    var experienceTitle: String
    var media: [Media]
    let timestamp: Date
    let geotag: CLLocationCoordinate2D
    
    init(title: String, imageURl: URL?, audioURL: URL?, videoURL: URL?, timestamp: Date = Date(), geotag: CLLocationCoordinate2D? = nil) {
        
        self.experienceTitle = title
        self.timestamp = timestamp
        self.geotag = geotag ?? Locations.apple
        self.media = [ Media(mediaType: .image, url: imageURl),
                       Media(mediaType: .audio, url: audioURL),
                       Media(mediaType: .video, url: videoURL), ]
    }
    
    var savedMedia: [Media] {
        media.filter { $0.url != nil }
    }
    
    var savedMediaTypes: [String] {
        savedMedia.compactMap { $0.mediaType.rawValue }
    }
    
    static func == (lhs: Experience, rhs: Experience) -> Bool {
        lhs.timestamp == rhs.timestamp
    }
    
    struct Media {
        let mediaType: MediaType
        let url: URL?
    }
}

extension Experience: MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D {
        geotag
    }
    
    var title: String? {
        experienceTitle
    }
    
    var subtitle: String? {
        if savedMedia.count == 0 {
            return "No media saved."
        } else {
            return "Saved media: \(savedMediaTypes.joined(separator: ", "))"
        }
    }
}
