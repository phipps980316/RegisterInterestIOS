//
//  ViewController.swift
//  RegisterInterestApp
//
//  Created by Jon Phipps on 26/01/2020.
//  Copyright © 2020 Jon Phipps. All rights reserved.
//

import UIKit
import CoreLocation

//Controller for the interest form view
class InterestFormViewController: UIViewController, UIPickerViewDataSource {
    
    //Outlets to link UI elements to the controlling class
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var birthDatePickerView: UIDatePicker!
    @IBOutlet weak var subjectPickerView: UIPickerView!
    @IBOutlet weak var marketingSwitch: UISwitch!
    
    //Manager objects to handle various tasks
    let validator = ValidationManager()
    let dataManager = DataManager()
    let networkManager = NetworkManager()
    let locationManager = LocationManager()
    
    var subjects: [String] = [] //Array of subject area strings
    
    //Constructor of the interest view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load the subjects from the provided url and supply them to the picker view
        networkManager.getSubjectsFromURL(){(result) in
            self.subjects = result
            DispatchQueue.main.async {
                self.subjectPickerView.dataSource = self
                self.subjectPickerView.delegate = self
                self.loadingLabel.isHidden = true
            }
        }
        
        //Dismisses Keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    //Function to decide if the application should perform the segue
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        //If the segue has the following identifier, check if the form fields have valid data and if the data is valid then allow the segue to occur. Otherwise if the form data is invalid, display an alert with the reason that the data is invalid and stop the seque from happening. If there is a segue with another identifier allow the segue to take place
        if identifier == "ToConfirmationSegue" {
            var message = ""
            
            if firstNameTextField.text!.isEmpty {
                message = "Please Enter First Name"
            }
            else if lastNameTextField.text!.isEmpty {
                message = "Please Enter Last Name"
            }
            else if emailTextField.text!.isEmpty {
                message = "Please Enter Email"
            }
            else if !validator.validEmail(email: emailTextField.text!) {
                message = "Please Enter Valid Email"
            }
            else if !validator.validAge(birthDate: birthDatePickerView.date) {
                message = "Must Be Aged 16 Or Over"
            }
                       
            if message != "" {
                let alert = UIAlertController(title: "Information", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                return false
            }
            else {
                return true
            }
        }
        else {
            return true
        }
    }
    
    //Function to prepare to move to the next view controller by segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if the seque identifier matches the following identifier, get the next view controller and compile the form data into an object of participant. This compiled data will then be passed to the next view controller and the record will be saved to core data
        if segue.identifier == "ToConfirmationSegue" {
            let nextView = segue.destination as! ConfirmationViewController
            let name = firstNameTextField.text! + " " + lastNameTextField.text!
            let email = emailTextField.text!
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let dateOfBirth = dateFormatter.string(from: birthDatePickerView.date)
            
            let subject = subjects[subjectPickerView.selectedRow(inComponent: 0)]
            let marketingUpdates = marketingSwitch.isOn
            
            let deviceLocation = locationManager.getDeviceLocation()
            let gpsLat = deviceLocation.latitude
            let gpsLon = deviceLocation.longitude
            
            let newParticipant = Participant(name: name, email: email, dob: dateOfBirth, subjectArea: subject, marketingUpdates: marketingUpdates, gpsLat: gpsLat, gpsLon: gpsLon)!
            
            nextView.information = newParticipant
            dataManager.insertRecord(participant: newParticipant)
        }
    }
}
 
extension InterestFormViewController: UIPickerViewDelegate{
    //Function to return the number of components needed in the picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    //Function to return the number of rows in the selected component of the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subjects.count
    }

    //Function to return the title of a row in the selected component of the picker view
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subjects[row]
    }
}
