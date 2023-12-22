//
//  ViewController.swift
//  Assignment 5
//
//  Created by SENTIENTGEEKS on 21/12/23.
//
import MapKit
import UIKit

class ViewController: UIViewController ,HaburgerViewControllerDelegate{
    
    
    @IBOutlet weak var hamburgarView: UIView!
    @IBOutlet weak var backViewForHamburg: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var leadingConstraintForHambargerMenu: NSLayoutConstraint!
    var hambarGarVC : HamburgerViewController?
    private let locationViewModel  = LocationViewModel()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationViewModel.requestLocation()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        backViewForHamburg.isHidden = true
        locationViewModel.didUpdateLocation = {[weak self] location in
            self?.updateMap(with: location)
        }
        
        
    }
    override func prepare(for seague : UIStoryboardSegue, sender : Any?){
        if seague.identifier == "hamburgerSegue" {
            if let controller = seague.destination as? HamburgerViewController{
                self.hambarGarVC = controller
                self.hambarGarVC?.delegate = self
            }
        }
    }
    func hideHamburgerMenu() {
        self.hideHamburgerView()
    }
    private func hideHamburgerView(){
        UIView.animate(withDuration: 0.1) {
            self.leadingConstraintForHambargerMenu.constant = 10
            self.view.layoutIfNeeded()
        } completion: { (status) in
            UIView.animate(withDuration: 0.1) {
                self.leadingConstraintForHambargerMenu.constant = -280
                self.view.layoutIfNeeded()
            } completion: { (status) in
                self.backViewForHamburg.isHidden = true
                self.isHamburgerMenuShown = false
            }
        }
    }
    @IBAction func getLocationButtonPressed(_ sender: UIButton) {
        locationViewModel.requestLocation()
    }
    
    @IBAction func tapToHideHambarger(_ sender: Any) {
        self.hideHamburgerView()
    }
    private func updateMap(with location: CLLocation){
        let coordinate = location.coordinate
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Current Location"
        mapView.addAnnotation(annotation)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationViewModel.stopUpdatingLocation()
    }
    
    @IBAction func showHamburgerMenu(_ sender: Any) {
        UIView.animate(withDuration: 0.01) {
            self.leadingConstraintForHambargerMenu.constant = 10
            self.view.layoutIfNeeded()
        } completion: { (status) in
            self.backViewForHamburg.isHidden = false
            UIView.animate(withDuration: 0.01) {
                self.leadingConstraintForHambargerMenu.constant = 0
                self.view.layoutIfNeeded()
            } completion: { (status) in
                self.isHamburgerMenuShown = true
            }
        }
        self.backViewForHamburg.isHidden = false
    }
    private var isHamburgerMenuShown:Bool = false
      private var beginPoint:CGFloat = 0.0
      private var difference:CGFloat = 0.0
      
      override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          if (isHamburgerMenuShown)
          {
               if let touch = touches.first
              {
                  let location = touch.location(in: backViewForHamburg)
                  beginPoint = location.x
              }
          }
      }
      
      override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
          if (isHamburgerMenuShown)
          {
              if let touch = touches.first
              {
                  let location = touch.location(in: backViewForHamburg)
                  
                  let differenceFromBeginPoint = beginPoint - location.x
                  
                  if (differenceFromBeginPoint>0 || differenceFromBeginPoint<280)
                  {
                      difference = differenceFromBeginPoint
                      self.leadingConstraintForHambargerMenu.constant = -differenceFromBeginPoint
                      self.backViewForHamburg.alpha = 0.75-(0.75*differenceFromBeginPoint/280)
                  }
              }
          }
      }
      
      override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
          if (isHamburgerMenuShown)
          {
              if (difference>140)
              {
                  UIView.animate(withDuration: 0.1) {
                      self.leadingConstraintForHambargerMenu.constant = -290
                  } completion: { (status) in
                      self.backViewForHamburg.alpha = 1
                      self.isHamburgerMenuShown = false
                      self.backViewForHamburg.isHidden = true
                  }
              }
              else{
                  UIView.animate(withDuration: 0.1) {
                      self.leadingConstraintForHambargerMenu.constant = -10
                  } completion: { (status) in
                      self.isHamburgerMenuShown = true
                      self.backViewForHamburg.isHidden = false
                  }
              }
          }
      }
}
