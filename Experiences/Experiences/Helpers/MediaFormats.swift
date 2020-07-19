//
//  MediaFormats.swift
//  Experiences
//
//  Created by patelpra on 7/19/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation
class MediaFormats {
    
    static func newURL(forType mediaType: MediaType) -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]

        let name = formatter.string(from: Date())
        
        var fileExtension: String
        
        switch mediaType {
        case .audio:
            fileExtension = "caf"
        case .video:
            fileExtension = "mov"
        case .image:
            fileExtension = "png"
        }
        
        let fileURL = documentsDirectory.appendingPathComponent(name).appendingPathExtension(fileExtension)
        
        return fileURL
    }
}
