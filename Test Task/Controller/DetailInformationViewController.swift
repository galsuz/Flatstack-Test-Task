//
//  DetailInformationViewController.swift
//  Test Task
//
//  Created by Алсу Гиниятуллина  on 14.06.2021.
//

import UIKit

class DetailInformationViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    var country: Country!
    var flagImage: UIImage!
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        fetchImages()
        setupCollectionView()
    }
    
    //MARK: Getting data
    
    func fetchImages() {
        
        let flagImage = country.country_info.flag
        let imagesURL = country.country_info.images
        
        ApiService.apiService.getImages(flagImage: flagImage, imagesURL: imagesURL) { images in
            
            DispatchQueue.main.async {
                
                self.images = images
                self.pageControl.numberOfPages = images.count 
                self.collectionView.reloadData()
            }
        }
    }
}

//MARK: TableView stack

extension DetailInformationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let countryNameCell = UINib(nibName: "CounrtyNameTableViewCell", bundle: nil)
        tableView.register(countryNameCell, forCellReuseIdentifier: "counrtyNameCell")
        
        let countryInfoCell = UINib(nibName: "CounrtyInfoTableViewCell", bundle: nil)
        tableView.register(countryInfoCell, forCellReuseIdentifier: "countryInfoCell")
        
        let descriptionCell = UINib(nibName: "CountryDescriptionTableViewCell", bundle: nil)
        tableView.register(descriptionCell, forCellReuseIdentifier: "descriptionCell")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.row == 0 {
            return 58
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "counrtyNameCell") as! CounrtyNameTableViewCell
            cell.setup(name: country.name)
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "countryInfoCell") as! CounrtyInfoTableViewCell
            
            cell.setup(image: #imageLiteral(resourceName: "i-star"), title: "Capital", countryInfo: country.capital)
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "countryInfoCell") as! CounrtyInfoTableViewCell
            
            cell.setup(image: #imageLiteral(resourceName: "i-face"), title: "Population", countryInfo: "\(country.population)")
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "countryInfoCell") as! CounrtyInfoTableViewCell
            
            cell.setup(image: #imageLiteral(resourceName: "i-earth"), title: "Continent", countryInfo: country.continent)
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell") as! CountryDescriptionTableViewCell
            cell.setup(description: country.description)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

//MARK: CollectionView stack

extension DetailInformationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let cellNib = UINib(nibName: "CountryImagesCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "imagesCell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagesCell", for: indexPath) as! CountryImagesCollectionViewCell
        cell.imageView.image = images[indexPath.row]
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(collectionView.contentOffset.x) / Int(self.collectionView.frame.width)
    }
}
