//
//  DetailViewController.swift
//  WLTest
//
//  Created by Martin on 20/12/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    @IBOutlet weak private var stackView: UIStackView!
    @IBOutlet weak private var mapView: MKMapView!
    var detail : POIDetail?

    override func viewDidLoad() {
        super.viewDidLoad()
        addTitleLabel(detail?.title)
        addDescriptionLabel(detail?.desc)
        addDescriptionLabel(detail?.address)
        addDescriptionLabel(detail?.phone)
        addDescriptionLabel(detail?.email)
        addDescriptionLabel(detail?.transport)
        if let coords = detail?.geocoordinates, let location = LocationHelper.location(geocoordinates: coords) {
            mapView.centerMap(location: location, radius: Map.closeRegionRadius)
            let annotation = MKPointAnnotation()
            annotation.title = title
            annotation.coordinate = location.coordinate
            mapView.addAnnotation(annotation)
            mapView.isUserInteractionEnabled = false
        }
    }

    private func addTitleLabel(_ text: String?) {
        addCustomLabel(text: text, font: UIFont.primaryBoldFont(ofSize: 17))
    }


    private func addDescriptionLabel(_ text: String?) {
        addCustomLabel(text: text, font: UIFont.primaryFont(ofSize: 15))
    }

    private func addCustomLabel(text: String?, font : UIFont) {
        guard let text = text, text != "null" else { return }
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.customDarkBlue
        label.text = text.trimmingCharacters(in: .whitespaces)
        label.font = font
        label.textAlignment = .justified
        stackView.addArrangedSubview(label)
    }
}
