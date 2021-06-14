//
//  CountriesViewController.swift
//  Test Task
//
//  Created by Алсу Гиниятуллина  on 13.06.2021.
//

import UIKit

class CountriesViewController: UIViewController {
    
    let firstPage = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json"
    
    @IBOutlet weak var tableView: UITableView!
    
    var countries: [Country] = []
    var nextPage: String?
    var refresher = UIRefreshControl()
    var pagination = true
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupTableView()
        setupRefresher()
        fetchData(page: firstPage)
    }
    
    //MARK: Getting data
    
    func fetchData(page: String) {
        
        ApiService.apiService.getData(page: page) { networkResponse, error in
            
            if let networkResponse = networkResponse {
                
                self.countries = networkResponse.countries
                self.nextPage = networkResponse.next
                self.tableView.reloadData()
                self.refresher.endRefreshing()
                
            }
        }
    }
    
    //MARK: Pagination
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            
            if pagination {
                
                guard nextPage != nil else {
                    return
                }
                
                ApiService.apiService.getData(page: nextPage!) { networkResponse, error in
                    
                    if let networkResponse = networkResponse {
                        
                        self.countries.append(contentsOf: networkResponse.countries)
                        self.pagination = false
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    //MARK: Refresher
    
    func setupRefresher() {
        
        refresher.addTarget(self, action: #selector(pulledToRefresh), for: .valueChanged)
        tableView.refreshControl = refresher
    }
    
    @objc func pulledToRefresh() {
        
        countries.removeAll()
        fetchData(page: firstPage)
    }
}

//MARK: TableView stack

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let countryCellNib = UINib(nibName: "CountryTableViewCell", bundle: nil)
        tableView.register(countryCellNib, forCellReuseIdentifier: "counrtyCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "counrtyCell") as! CountryTableViewCell
        
        cell.setup(country: countries[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(identifier: "detailViewController") as! DetailInformationViewController
        dvc.country = countries[indexPath.row]
        
        navigationController?.pushViewController(dvc, animated: true)
    }
}
