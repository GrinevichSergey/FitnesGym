//
//  ExerciseCell.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 16.05.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import UIKit
import AlamofireImage

class ExerciseCell: UITableViewCell {
    
    var exercise: ExerciseModal? {
        didSet {
            fetchItems(exercise: exercise!)
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        //self.imageURL.image = nil
        //self.imageURL.af.cancelImageRequest()
    }
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Roboto-Regular", size: 17)
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
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
            image.image = #imageLiteral(resourceName: "forward1")
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
        
        contentView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        
        iconView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        arrowImage.widthAnchor.constraint(equalToConstant: 25).isActive = true
        arrowImage.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: 5).isActive = true
 
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor =  #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
       // contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.lightGray.cgColor
        contentView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        contentView.layer.shadowRadius = 1.0
        contentView.layer.shadowOpacity = 1.0
        contentView.layer.masksToBounds = false
        
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
