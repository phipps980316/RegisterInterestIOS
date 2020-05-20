//
//  RecordViewController.swift
//  RegisterInterestApp
//
//  Created by Jon Phipps on 28/01/2020.
//  Copyright © 2020 Jon Phipps. All rights reserved.
//

import MapKit
import UIKit

//Controller for the record view
class RecordViewController: UIViewController {

    //Outlets to link UI elements to the controlling class
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var marketingLabel: UILabel!
    @IBOutlet weak var gpsLatLabel: UILabel!
    @IBOutlet weak var gpsLonLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    //Manager objects to handle various tasks
    let networkManager = NetworkManager()
    let locationManager = LocationManager()
    
    //Participant object of hold the record to be displayed from the interest form
    var participant:Participant = Participant(name: "",email: "",dob: "",subjectArea: "",marketingUpdates: false,gpsLat: 0,gpsLon: 0)!
    
    //Constructor of the record view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Sets up the view text fields with all of the information from the participant object
        nameLabel.text = "Name: " + participant.getNameString()
        emailLabel.text = participant.getEmailString()
        dobLabel.text = participant.getDOBString()
        subjectLabel.text = participant.getSubjectAreaString()
        marketingLabel.text = participant.getMarketingUpdatesString()
        gpsLatLabel.text = participant.getGPSLatString()
        gpsLonLabel.text = participant.getGPSLonString()
        
        //Sets up the map view to display the recorded location of the participant
        let region = locationManager.getMapRegion(latitude: participant.GpsLat, longitude: participant.GpsLon)
        mapView.showsUserLocation = true
        mapView.setRegion(region, animated: true)
    }
    
    //Function that is called when the sync button is clicked
    @IBAction func syncButtonClicked(_ sender: UIBarButtonItem) {
        //Posts the participant record to the provided url and creates an alert with the response message
        self.networkManager.postSubjectToURL(participant: self.participant){(result) in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Information", message: result, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
