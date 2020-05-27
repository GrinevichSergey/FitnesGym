//
//  ExerciseCell.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 16.05.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import UIKit
import AlamofireImage

class ExerciseCell: UICollectionViewCell {
    
    var exercise: ExerciseModal? {
        didSet {
            fetchItems(exercise: exercise!)
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        //  self.imageURL.image = nil
        // self.imageURL.af.cancelImageRequest()
    }
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Roboto-Regular", size: 17)
        label.numberOfLines = 0
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
    //
    //    var starImage: UIImageView = {
    //          var imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
    //          imageView.translatesAutoresizingMaskIntoConstraints = false
    //          imageView.clipsToBounds = true
    //          imageView.contentMode = .scaleAspectFill
    //          return imageView
    //
    //      }()
    
    
    func fetchItems(exercise: ExerciseModal) {
        
        nameLabel.text = exercise.name_exercise
        //
        //        if let imageUrl = exercise.image_url, let url = URL(string: imageUrl)  {
        //            self.imageURL.af.cancelImageRequest()
        //            self.imageURL.af.setImage(withURL: url, cacheKey: imageUrl)
        //        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        
        let iconView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.7607843137, blue: 0.7607843137, alpha: 1)
            view.layer.cornerRadius = 30
            view.layer.masksToBounds = true
            return view
        }()
        
        
        iconView.addSubview(imageURL)
        
        imageURL.centerYAnchor.constraint(equalTo: iconView.centerYAnchor).isActive = true
        imageURL.centerXAnchor.constraint(equalTo: iconView.centerXAnchor).isActive = true
        imageURL.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageURL.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        let arrowImage: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.image = #imageLiteral(resourceName: "chevron")
            
            image.contentMode = .scaleAspectFit
            return image
            
        }()
        
        
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 5.0
        stackView.addArrangedSubview(iconView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(arrowImage)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        
        iconView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        arrowImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        arrowImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        nameLabel.widthAnchor.constraint(equalToConstant: 245).isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
