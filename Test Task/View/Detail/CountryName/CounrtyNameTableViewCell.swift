//
//  CounrtyNameTableViewCell.swift
//  Test Task
//
//  Created by Алсу Гиниятуллина  on 14.06.2021.
//

import UIKit

class CounrtyNameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countryNameLabel: UILabel!
    
    func setup(name: String) {

        countryNameLabel.text = name
    }
}
