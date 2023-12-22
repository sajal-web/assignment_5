//
//  MapManager.swift
//  Assignment 5
//
//  Created by SENTIENTGEEKS on 22/12/23.
//
import MapKit

class MapManager {
    func updateMap(_ mapView: MKMapView, with location: CLLocation) {
        let coordinate = location.coordinate
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Current Location"
        mapView.addAnnotation(annotation)
    }
}
