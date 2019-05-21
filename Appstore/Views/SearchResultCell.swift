//
//  SearchResultCell.swift
//  Appstore
//
//  Created by Sai Grandhi on 5/14/19.
//  Copyright © 2019 Grandhi. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    var appResult: Result!   {
        didSet {
            nameLabel.text = appResult.trackName
            categoryLabel.text = appResult.primaryGenreName
            ratingsLabel.text =  "Rating: \(appResult.averageUserRating ?? 0)"
            
            let appIconUrl = URL(string: appResult.artworkUrl100)
            appIconImageView.sd_setImage(with: appIconUrl )
            
            screenshot1ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[0]))
            if appResult.screenshotUrls.count > 1  {
                screenshot2ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[1]))
                
            }
            if appResult.screenshotUrls.count > 2 {
                screenshot3ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[2]))
            }

        }
    }
    
    let appIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let lavel = UILabel()
        lavel.text = "app name"
        return lavel
    }()
    
    let categoryLabel: UILabel = {
        let lavel = UILabel()
        lavel.text = "Photos & Video"
        return lavel
    }()
    
    let ratingsLabel: UILabel = {
        let lavel = UILabel()
        lavel.text = "9.26M"
        return lavel
    }()
    
    let getButton: UIButton = {
       let btn = UIButton(type: .system)
       btn.setTitle("GET", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        btn.backgroundColor = UIColor(white: 0.8, alpha: 1)
        btn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        btn.layer.cornerRadius = 16
        return btn
    }()
    
    lazy var screenshot1ImageView = self.createScreenshotImageView()
    lazy var screenshot2ImageView = self.createScreenshotImageView()
    lazy var screenshot3ImageView = self.createScreenshotImageView()

    func createScreenshotImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        let infoTopStackView = UIStackView(arrangedSubviews: [
            appIconImageView, VerticalStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingsLabel]), getButton])
        infoTopStackView.spacing = 12
        infoTopStackView.alignment = .center
        
        let screenshotStackView = UIStackView(arrangedSubviews: [
                screenshot1ImageView, screenshot2ImageView, screenshot3ImageView
            ])
        screenshotStackView.spacing = 12
        screenshotStackView.distribution = .fillEqually
        
        let overallStackView = VerticalStackView(arrangedSubviews: [infoTopStackView, screenshotStackView], spacing: 16)
        
        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
