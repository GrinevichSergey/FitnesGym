//
//  ExerciseCell.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 21.05.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import UIKit

class ExerciseHomeCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.backgroundColor = #colorLiteral(red: 0.3294117647, green: 0.431372549, blue: 0.4784313725, alpha: 1)
        self.layer.cornerRadius = 20
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        
        let iconView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.262745098, blue: 0.3058823529, alpha: 1)
            view.layer.cornerRadius = 30
            view.layer.masksToBounds = true
            return view
        }()
        
        
        let iconImage: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.image = #imageLiteral(resourceName: "dumbbell1")
            image.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.262745098, blue: 0.3058823529, alpha: 1)
            image.clipsToBounds = true
            image.contentMode = .scaleAspectFit
            return image
            
        }()
        
        iconView.addSubview(iconImage)
        iconImage.centerYAnchor.constraint(equalTo: iconView.centerYAnchor).isActive = true
        iconImage.centerXAnchor.constraint(equalTo: iconView.centerXAnchor).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 40).isActive = true


        let nameLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont(name: "Roboto-Regular", size: 23)
            label.textColor = .white
            label.text = "Exercise"
            return label
        }()

        let arrowImage: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.image = #imageLiteral(resourceName: "chevron-right")

            image.contentMode = .scaleAspectFit
            return image

        }()


        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 10.0
        stackView.addArrangedSubview(iconView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(arrowImage)

        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(stackView)

        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        iconView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 60).isActive = true

        arrowImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        arrowImage.heightAnchor.constraint(equalToConstant: 30).isActive = true

        nameLabel.widthAnchor.constraint(equalToConstant: 210).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}
