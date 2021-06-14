//
//  CountryTableViewCell.swift
//  Test Task
//
//  Created by Алсу Гиниятуллина  on 13.06.2021.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var capitalNameLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var countryFlagImageView: UIImageView!
    
    func setup(country: Country) {
        
        self.countryNameLabel.text = country.name
        self.capitalNameLabel.text = country.capital
        self.shortDescriptionLabel.text = country.description_small
        
        ApiService.apiService.getImage(url: country.country_info.flag, complition: { image in
            
            if let image = image {
                self.countryFlagImageView.image = image
            }
        })
    }
    
}
