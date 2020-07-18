//
//  AddTrainingSectionCell.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 06.06.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import UIKit

class AddTrainingSectionCell: UITableViewCell {
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Roboto-Bold", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
        
    }()
    
    var imageURL: UIImageView = {
        var imageView = UIImageView(image: #imageLiteral(resourceName: "idumbbell-51"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        let arrowImage: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.image = #imageLiteral(resourceName: "arrowBottom")
            image.contentMode = .scaleAspectFit
            return image
            
        }()
        
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 5.0
        stackView.addArrangedSubview(imageURL)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(arrowImage)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        
        imageURL.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageURL.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        arrowImage.widthAnchor.constraint(equalToConstant: 25).isActive = true
        arrowImage.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: imageURL.rightAnchor, constant: 10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
