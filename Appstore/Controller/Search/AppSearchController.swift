//
//  AppSearchController.swift
//  Appstore
//
//  Created by Sai Grandhi on 5/14/19.
//  Copyright © 2019 Grandhi. All rights reserved.
//

import UIKit
import SDWebImage

class AppSearchController: BaseListController, UICollectionViewDelegateFlowLayout,  UISearchBarDelegate {
    
    fileprivate let cellId = "id1234"
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    fileprivate var appResults = [Result]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: 50))
        setupSearchBar()
        
       // fetchItunesApps()
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    var timer: Timer?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print(searchText)
        
        // introduce some delay before performing the search
        // throttling the search
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            // fire a search to the appStore URL
            Service.shared.fetchApps(searchTerm: searchText) { (res, err) in
                self.appResults = res
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
        

    }
    
    fileprivate func fetchItunesApps() {
        Service.shared.fetchApps(searchTerm: "Twitter") { (results, err) in
            
            if let err = err {
                print("Failed to fetch apps: ", err)
                return
            }
            self.appResults = results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  cellId, for: indexPath) as! SearchResultCell
        
        cell.appResult = appResults[indexPath.item] // use item for CollectionViews and row for TableViews

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // run this code everytime the cells count changes
        // ex: hiding the "Please enter search term here" label
        enterSearchTermLabel.isHidden = appResults.count != 0
        return appResults.count
    }
    

    

}
