//
//  AppsController.swift
//  Appstore
//
//  Created by Sai Grandhi on 5/21/19.
//  Copyright © 2019 Grandhi. All rights reserved.
//

import UIKit

class AppsPageController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "id"
    let headerId = "headerId"
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .black
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
        
        // Header1: Setting up the header for collection view. Sliding carousel of images
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: headerId)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
        fetchData()
    }
    
    var socialApps = [SocialApp]()
    var groups = [AppGroup]()
    
    fileprivate func fetchData() {
        
        var group1: AppGroup?
        var group2: AppGroup?
        
        // help you sync your data fetches together
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        
        print("Retrieving JSON data to fill AppPageHeader")
        Service.shared.fetchTopGrossing() {(appGroup, err) in
            if let err = err {
                print("Failed to fetch games: ", err)
                return
            }
            dispatchGroup.leave()
            group1 = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchGames() {(appGroup, err) in
            if let err = err {
                print("Failed to fetch games: ", err)
                return
            }
            dispatchGroup.leave()
            group2 = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchAppsSocial { (apps, err) in
            if let err = err {
                print("Failed to fetch header apps cells: ", err)
                return
            }
            dispatchGroup.leave()
            self.socialApps = apps ?? []
            apps?.forEach({print($0.name)})
        }
        
        // completion
        dispatchGroup.notify(queue: .main) {
            print("completed your dispatch group task...")
            self.activityIndicatorView.stopAnimating()
            // Notes: This is called optional binding
            if let group = group1 {
                self.groups.append(group)
            }
            if let group = group2 {
                self.groups.append(group)
            }
            self.collectionView.reloadData()
            
        }
    }
    
    // Header2: function for dequeing a reusable supplementary view to be used as a header
   override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsPageHeader
    header.appHeaderHorizontalController.socialApps = socialApps
    header.appHeaderHorizontalController.collectionView.reloadData()
    return header
    }
    
    // Header3: Function for managing the size of the header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
        print("num groups: ", groups.count)
        let appGroup = groups[indexPath.item]
        cell.titleLabel.text = appGroup.feed.title
        cell.horizontalController.appGroup = appGroup
        cell.horizontalController.collectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
