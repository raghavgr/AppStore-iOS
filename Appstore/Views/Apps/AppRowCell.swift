//
//  AppRowCell.swift
//  Appstore
//
//  Created by Sai Grandhi on 5/21/19.
//  Copyright © 2019 Grandhi. All rights reserved.
//

import UIKit


class AppRowCell: UICollectionViewCell {
    
    
    let appIconImageView = UIImageView(cornerRadius: 8)
    
    let nameLabel: UILabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20))
    let companyLabel: UILabel = UILabel(text: "Company Inc", font: .systemFont(ofSize: 13))
    
    let getButton = UIButton(title: "GET")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        appIconImageView.backgroundColor = .purple
        //appIconImageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        appIconImageView.constrainWidth(constant: 64)
        appIconImageView.constrainHeight(constant: 64)
        
        getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
        getButton.setTitleColor(.blue, for: .normal)
        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        getButton.layer.cornerRadius = 32/2

        let appInfoStackView = UIStackView(arrangedSubviews: [appIconImageView, VerticalStackView(arrangedSubviews: [nameLabel, companyLabel], spacing: 4), getButton])
        appInfoStackView.spacing = 16
        appInfoStackView.alignment = .center
        
        addSubview(appInfoStackView)
        appInfoStackView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
