//
//  ParticipantTableViewCell.swift
//  RegisterInterestApp
//
//  Created by Jon Phipps on 28/01/2020.
//  Copyright © 2020 Jon Phipps. All rights reserved.
//

import UIKit

//Class that represents a cell in the tabel view
class ParticipantTableViewCell: UITableViewCell {

    //Outlets to link UI elements to the controlling class
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var DOBLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var marketingLabel: UILabel!
    @IBOutlet weak var gpsLatLabel: UILabel!
    @IBOutlet weak var gpsLonLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
