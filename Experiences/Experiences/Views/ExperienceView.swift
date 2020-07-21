//
//  ExperienceView.swift
//  Experiences
//
//  Created by patelpra on 7/20/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import UIKit

class ExperienceView: UIView {
    
    var experience: Experience? {
        didSet {
            updateViews()
        }
    }
    
    private let savedMediaTypesLabel = UILabel()
    private let dateLabel = UILabel()
    private let latitudeLabel = UILabel()
    private let longitudeLabel = UILabel()
    
    private lazy var dateFormatter: DateFormatter = {
        let result = DateFormatter()
        result.dateStyle = .short
        result.timeStyle = .short
        return result
    }()
    
    private lazy var latLongFormatter: NumberFormatter = {
        let result = NumberFormatter()
        result.numberStyle = .decimal
        result.maximumIntegerDigits = 1
        result.minimumFractionDigits = 2
        result.maximumIntegerDigits = 2
        return result
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        latitudeLabel.setContentHuggingPriority(.defaultLow+1, for: .horizontal)
            
            let latLonStackView = UIStackView(arrangedSubviews: [latitudeLabel, longitudeLabel])
            latLonStackView.spacing = UIStackView.spacingUseSystem
            let mainStackView = UIStackView(arrangedSubviews: [savedMediaTypesLabel, dateLabel, latLonStackView])
            mainStackView.axis = .vertical
            mainStackView.spacing = UIStackView.spacingUseSystem
            
            mainStackView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(mainStackView)
            mainStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            mainStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            mainStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateViews() {
        guard let experience = experience else { return }
        savedMediaTypesLabel.text = experience.subtitle ?? "No media saved"
        dateLabel.text = dateFormatter.string(from: experience.timestamp)
        latitudeLabel.text = "Latitude: " + latLongFormatter.string(from: experience.geotag.latitude as NSNumber)!
        longitudeLabel.text = "Longitude: " + latLongFormatter.string(from: experience.geotag.longitude as NSNumber)!
        
    }
}


