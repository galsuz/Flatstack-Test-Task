//
//  CounrtyInfoTableViewCell.swift
//  Test Task
//
//  Created by Алсу Гиниятуллина  on 14.06.2021.
//

import UIKit

class CounrtyInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleForCountryInfoLabel: UILabel!
    @IBOutlet weak var countryInfoValuesLabel: UILabel!
    
    func setup(image: UIImage, title: String, countryInfo: String) {
        
        self.iconImageView.image = image
        self.titleForCountryInfoLabel.text = title
        self.countryInfoValuesLabel.text = countryInfo
    }
}
