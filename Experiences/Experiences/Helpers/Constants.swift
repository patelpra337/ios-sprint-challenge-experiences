//
//  Constants.swift
//  Experiences
//
//  Created by patelpra on 7/18/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation
import MapKit

struct BR {
    static let buttonCornerRadius: CGFloat = 4.0
}

struct Locations {
    static let apple = CLLocationCoordinate2D(latitude: 38.429483, longitude: -121.479189)
}

struct ReuseIdentifiers {
    static let annotation = "ExperienceAnnotationView"
}

struct SegueIdentifiers {
    static let addExperienceSegue: String = "AddExperienceSegue"
    static let addImageSegue: String = "AddImageSegue"
    static let addAudioSegue: String = "AddAudioSegue"
    static let addVideoSegue: String = "AddVideoSegue"
}
