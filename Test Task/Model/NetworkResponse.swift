//
//  NetworkResponse.swift
//  Test Task
//
//  Created by Алсу Гиниятуллина  on 13.06.2021.
//

import Foundation

struct NetworkResponse: Codable {
    
    let next: String
    let countries: [Country]
}
