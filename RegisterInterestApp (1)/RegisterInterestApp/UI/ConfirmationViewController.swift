//
//  ConfirmationViewController.swift
//  RegisterInterestApp
//
//  Created by Jon Phipps on 27/01/2020.
//  Copyright © 2020 Jon Phipps. All rights reserved.
//

import MapKit
import UIKit

//Controller for the confirmation view
class ConfirmationViewController: UIViewController {
    
    //Outlets to link UI elements to the controlling class
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var DOBLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var marketingLabel: UILabel!
    @IBOutlet weak var gpsLatLabel: UILabel!
    @IBOutlet weak var gpsLonLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    //Manager objects to handle various tasks
    let networkManager = NetworkManager()
    let locationManager = LocationManager()
    
    //Participant object of hold the record to be displayed from the interest form
    var information: Participant = Participant(name: "",email: "",dob: "",subjectArea: "",marketingUpdates: false,gpsLat: 0,gpsLon: 0)!
    
    //Constructor of the confirmation view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Posts the participant record to the provided url and creates an alert with the response message
        self.networkManager.postSubjectToURL(participant: information){(result) in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Information", message: result, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        //Sets up the view text fields with all of the information from the participant object
        nameLabel.text = information.getNameString()
        emailLabel.text = information.getEmailString()
        DOBLabel.text = information.getDOBString()
        subjectLabel.text = information.getSubjectAreaString()
        marketingLabel.text = information.getMarketingUpdatesString()
        gpsLatLabel.text = information.getGPSLatString()
        gpsLonLabel.text = information.getGPSLonString()
        
        //Sets up the map view to display the recorded location of the participant
        let region = locationManager.getMapRegion(latitude: information.GpsLat, longitude: information.GpsLon)
        mapView.showsUserLocation = true
        mapView.setRegion(region, animated: true)
    }
}
