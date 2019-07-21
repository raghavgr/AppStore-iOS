//
//  AppsHeaderCell.swift
//  Appstore
//
//  Created by Sai Grandhi on 5/22/19.
//  Copyright © 2019 Grandhi. All rights reserved.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
    
    let companyLabel = UILabel(text: "Facebook", font: .boldSystemFont(ofSize: 12))
    
    let titleLabel = UILabel(text: "Keeping friends closer just got even more easier", font: .systemFont(ofSize: 24))
    
    let imageView = UIImageView(cornerRadius: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        companyLabel.textColor = .blue
        titleLabel.numberOfLines = 2
        
        let appHeaderStackView =  VerticalStackView(arrangedSubviews: [companyLabel, titleLabel, imageView], spacing: 12)
        
        addSubview(appHeaderStackView)
        appHeaderStackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
