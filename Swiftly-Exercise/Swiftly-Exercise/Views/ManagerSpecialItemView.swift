//
//  ManagerSpecialItemView.swift
//  Swiftly-Exercise
//
//  Created by Megan Herold on 3/6/20.
//  Copyright © 2020 Megan Herold. All rights reserved.
//

import UIKit

class ManagerSpecialItemView: UICollectionViewCell {
    
    static let reuseIdentifier = "ManagerSpecialItemView"
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let originalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textColor = .systemGreen
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = UIColor.secondarySystemBackground
        layer.cornerRadius = 5
    }
    
    func setupSubviews() {
        addSubview(nameLabel)
        addSubview(originalPriceLabel)
        addSubview(priceLabel)
        addSubview(imageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // Names of specials are at the top
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            nameLabel.bottomAnchor.constraint(equalTo: topAnchor, constant: frame.height / 3 ),
            
            imageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        ])
        
        // For horizontal and square views, lead with the image and trail with the prices
        if frame.width >= frame.height {
            NSLayoutConstraint.activate([
                imageView.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -6),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
                
                originalPriceLabel.topAnchor.constraint(greaterThanOrEqualTo: imageView.topAnchor),
                originalPriceLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 6),
                originalPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
                originalPriceLabel.bottomAnchor.constraint(equalTo: imageView.centerYAnchor),
                
                priceLabel.topAnchor.constraint(equalTo: imageView.centerYAnchor),
                priceLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 6),
                priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
                priceLabel.bottomAnchor.constraint(lessThanOrEqualTo: imageView.bottomAnchor)
            ])
        }
        
        // For vertical views, put the image at the top and the prices at the bottom
        else {
            NSLayoutConstraint.activate([
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(frame.height / 3)),
                
                originalPriceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6),
                originalPriceLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                originalPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(frame.height / 6)),
                
                priceLabel.topAnchor.constraint(equalTo: originalPriceLabel.bottomAnchor),
                priceLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6)
            ])
        }
    }
    
    func configure(for item: ManagerSpecialItem) {
        nameLabel.text = item.displayName
        originalPriceLabel.attributedText = NSAttributedString(string: "$" + item.originalPrice, attributes: [.strikethroughStyle: 1])
        priceLabel.text = "$" + item.price
        
        if let url = URL(string: item.imageUrl) {
            imageView.load(url: url)
        }
        
        subviews.forEach { deactivateConstraints(involving: $0) }
        setupConstraints()
    }
    
}
