//
//  ApiService.swift
//  Test Task
//
//  Created by Алсу Гиниятуллина  on 13.06.2021.
//

import Foundation
import UIKit
import Alamofire

class ApiService {
    
    static let apiService = ApiService()
    
    func getData(page: String, complition: @escaping (NetworkResponse?, Error?) -> ()) {
        
        AF.request(page).responseData { response in
            
            switch response.result {
            
            case .failure(let error):
                print("DataTask error: \(error.localizedDescription)")
                
            case .success(let data):
                guard let networkResponse = try? JSONDecoder().decode(NetworkResponse.self, from: data) else {
                    return
                }
                
                DispatchQueue.main.async {
                    complition(networkResponse, nil)
                }
            }
        }
    }
    
    func getImage(url: String, complition: @escaping (UIImage?) -> ()) {
        
        AF.request(url).responseData { response in
            
            
            switch response.result {
            case .failure(let error):
                complition(nil)
                print("DataTask error: \(error.localizedDescription)")
            case .success(let data):
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        complition(image)
                    }
                }
            }
        }
    }
    
    func getImages(flagImage: String, imagesURL: [String], complition: @escaping ([UIImage]) -> Void) {
        
        let group = DispatchGroup()
        var images: [UIImage] = []
        
        for imageURL in imagesURL {
            
            group.enter()
            AF.request(imageURL).responseData { response in
                
                switch response.result {
                case .success(let data):
                    if let image = UIImage(data: data) {
                        images.append(image)
                    }
                case .failure(let error):
                    print("DataTask error: \(error.localizedDescription)")
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            
            if images.isEmpty {
                
                AF.request(flagImage).responseData { response in
                    
                    if let data = response.data {
                        
                        if let image = UIImage(data: data) {
                            complition([image])
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    complition(images)
                }
            }
        }
    }
}
