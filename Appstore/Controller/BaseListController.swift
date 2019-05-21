//
//  BaseListController.swift
//  Appstore
//
//  Created by Sai Grandhi on 5/21/19.
//  Copyright © 2019 Grandhi. All rights reserved.
//

import UIKit
class BaseListController: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
