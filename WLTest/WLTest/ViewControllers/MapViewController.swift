//
//  ViewController.swift
//  WLTest
//
//  Created by Martin on 18/12/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import UIKit
import RealmSwift
import MapKit

class MapViewController: UIViewController {

    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    private let service = DependencyManager.resolve(interface: POIServiceProtocol.self)
    private var loaded : Bool = false
    private var pois : [POI]? {
        didSet {
            configMap()
        }
    }

    @IBAction func searchButtonPressed() {
        let searchController = UISearchController.withResetButton(searchBarDelegate: self)
        present(searchController, animated: true, completion: nil)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        title = Texts.defaultTitle
        loadPois()
    }

    private func deselectAnnoations() {
        mapView.annotations.forEach { [weak self] (annotation) in
            self?.mapView.deselectAnnotation(annotation, animated: true)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        deselectAnnoations()
    }

    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        if !loaded {
            loadPois()
        }
    }
}

extension MapViewController {

    private func configMap() {
        mapView.removeAnnotations(mapView.annotations)
        if let pois = pois, let poi = pois.first, let geocoordinates = poi.geocoordinates, let firstLocation = LocationHelper.location(geocoordinates: geocoordinates) {
            mapView.addAnnotations(pois: pois)
            mapView.centerMap(location: firstLocation, radius: Map.farRegionRadius)
        }
    }

    func loadPois() {
        activityIndicator.startAnimating()
        service?.getPois(successful: { [weak self] (pois) in
            self?.activityIndicator.stopAnimating()
            self?.pois = pois
            self?.loaded = true
            }, failure: { [weak self] (reason) in
                self?.activityIndicator.stopAnimating()
                self?.presentAlert(title: Texts.errorTitle, message: Texts.errorFetchingPois)
                self?.deselectAnnoations()
        })
    }
}

extension MapViewController : UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        if let text = searchBar.text {
            pois = service?.search(text: text)
            title = text
        }
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}

extension MapViewController : MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotationTitle = view.annotation?.title, let filteredPois = pois?.filter({$0.title == annotationTitle}), let poi = filteredPois.first, let poiId = poi.id {
            activityIndicator.startAnimating()
            service?.getPoiDetail(poiId: poiId, successful: { [weak self] (detail) in
                self?.activityIndicator.stopAnimating()
                self?.performSegue(withIdentifier: Storyboards.DetailSegue, sender: detail)
                }, failure: { [weak self] (reason) in
                    self?.activityIndicator.stopAnimating()
                    self?.presentAlert(title: Texts.errorTitle, message: Texts.errorFetchingPoiDetail)
                    self?.deselectAnnoations()
            })
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboards.DetailSegue, let detailViewController = segue.destination as? DetailViewController, let detail = sender as? POIDetail {
            detailViewController.detail = detail
        }
    }
}
