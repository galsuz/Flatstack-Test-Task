//
//  CountryDescriptionTableViewCell.swift
//  Test Task
//
//  Created by Алсу Гиниятуллина  on 14.06.2021.
//

import UIKit

class CountryDescriptionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countryDescriptionLabel: UILabel!
    
    func setup(description: String) {
     
        self.countryDescriptionLabel.text = description
    }
}
