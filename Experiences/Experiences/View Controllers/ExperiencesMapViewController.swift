//
//  ExperiencesMapViewController.swift
//  Experiences
//
//  Created by patelpra on 7/18/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import UIKit
import AVFoundation
import MapKit

class ExperiencesMapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var createExperiencesAgain: UIButton!
    
    var experiences: [Experience] = [] {
        didSet {
            let oldExperiences = Set(oldValue)
            let newExperiences = Set(experiences)
            
            let addExperiences = Array(newExperiences.subtracting(oldExperiences))
            let removedExperiences = Array(oldExperiences.subtracting(newExperiences))
            
            mapView.removeAnnotations(removedExperiences)
            mapView.addAnnotations(addExperiences)
        
        }
    }
    
    private var isCurrentlyFetchingExperiences = false
    private var shouldRequestExperiencesAgain = false
    
    var experienceController = ExperienceController()
    private var userTrackingButton: MKUserTrackingButton!
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        userTrackingButton = MKUserTrackingButton(mapView: mapView)
        userTrackingButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userTrackingButton)
        
        NSLayoutConstraint.activate([
            userTrackingButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20),
            mapView.bottomAnchor.constraint(equalTo: userTrackingButton.bottomAnchor, constant: 60)
        ])
        
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: ReuseIdentifiers.annotation)
        
        fetchExperiences()
    }
    
    private func fetchExperiences() {
        guard !isCurrentlyFetchingExperiences else {
            shouldRequestExperiencesAgain = true
            return
        }
        
        isCurrentlyFetchingExperiences = true
        
        let visibleRegion = mapView.visibleMapRect
        
        fetchExperiences(in: visibleRegion) { experiences in
            self.isCurrentlyFetchingExperiences = false
            
            defer {
                if self.shouldRequestExperiencesAgain {
                    self.shouldRequestExperiencesAgain = false
                    self.fetchExperiences()
                }
            }
            
            self.experiences = Array(experiences.prefix(100))
        }
    }
    
    func fetchExperiences(in region: MKMapRect? = nil, completion: @escaping ([Experience]) -> Void) {
        
        let experiencesInRegion = experienceController.experiences.filter {
            region?.contains(MKMapPoint($0.coordinate)) ?? true }
        
        completion(experiencesInRegion)
        }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.addExperienceSegue {
            guard let destinationVC = segue.destination as? UINavigationController, let targetController = destinationVC.topViewController as? AddExperienceViewController else { return }
            targetController.experienceController = experienceController
        }
    }
}

extension ExperiencesMapViewController: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        fetchExperiences()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let experience = annotation as? Experience else { return nil }
        
        guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: ReuseIdentifiers.annotation, for: experience) as? MKMarkerAnnotationView else {
            preconditionFailure("Missing the registered map annotation view")
    }
        
        return annotationView
    
    }
}
