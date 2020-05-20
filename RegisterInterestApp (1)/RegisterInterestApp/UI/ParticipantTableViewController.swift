//
//  ParticipantTableViewController.swift
//  RegisterInterestApp
//
//  Created by Jon Phipps on 28/01/2020.
//  Copyright © 2020 Jon Phipps. All rights reserved.
//

import UIKit

//Controller for the participant table view
class ParticipantTableViewController: UITableViewController {
    
    //Array of all participants saved in core data
    var participants: [Participant] = []
    
    //Manager objects to handle various tasks
    let dataManager = DataManager()

    //Constructor of the participant table view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        //Fetch the records from core data and sort them according the name alphabetically
        participants = dataManager.getRecords()
        participants.sort(by: {($0.getNameString()) < ($1.getNameString())})
    }

    //Function to return the number sections in the table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //Function to return the number of rows in the selected table view section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participants.count
    }

    //Function to return the cell selected from the table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipantCell", for: indexPath) as? ParticipantTableViewCell else{
            fatalError("Chosen cell is not an instance of ParticipantTableViewCell")
        }
        
        //Fetch the participant data from the array and use it to populate the cell field
        let participant = participants[indexPath.row]
        cell.nameLabel.text = "Name: " + participant.getNameString()
        cell.emailLabel.text = "Email: " + participant.getEmailString()
        cell.DOBLabel.text = "DOB: " + participant.getDOBString()
        cell.subjectLabel.text = "Subject: " + participant.getSubjectAreaString()
        cell.marketingLabel.text = "Marketing Opt In: " + participant.getMarketingUpdatesString()
        cell.gpsLatLabel.text = "GPS Lat: " + participant.getGPSLatString()
        cell.gpsLonLabel.text = "GPS Lon: " + participant.getGPSLonString()

        //Return the completed cell
        return cell
    }
    
    //Function to prepare to move to the next view controller by segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //If the segue has the following identifier, get the next view controller and pass the selected participant data through
        if segue.identifier == "ViewRecordSegue" {
            let nextView = segue.destination as! RecordViewController
            let selectedParticipant = participants[tableView.indexPathForSelectedRow!.row]
            nextView.participant = selectedParticipant
        }
    }
    
    //Function to run when the clear button is clicked
    @IBAction func clearButtonClicked(_ sender: UIBarButtonItem) {
        //Clear all records from core data and reload the table view
        dataManager.clearRecords()
        participants.removeAll()
        tableView.reloadData()
    }
}
