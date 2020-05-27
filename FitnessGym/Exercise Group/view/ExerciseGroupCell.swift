//
//  ExerciseGroupCell.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 14.05.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import UIKit
import AlamofireImage

class ExerciseGroupCell: UITableViewCell {
    
    var exerciseGroup: ExerciseGroupModal? {
        didSet {
            fetchItems(exerciseGroup: exerciseGroup!)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageUrl.image = nil
        self.imageUrl.af.cancelImageRequest()
    }
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.MyThemeColor.labelColor
        label.font = UIFont(name: "Roboto-Bold", size: 30)
        return label
        
    }()
    
    var imageUrl: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    func fetchItems(exerciseGroup: ExerciseGroupModal) {
        
        nameLabel.text = exerciseGroup.nameGroup
        
        if let imageUrl = exerciseGroup.imageURL, let url = URL(string: imageUrl)  {
            self.imageUrl.af.cancelImageRequest()
            self.imageUrl.af.setImage(withURL: url, cacheKey: imageUrl)
        }
        

    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.addSubview(imageUrl)
        //        imageUrl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        imageUrl.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageUrl.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageUrl.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageUrl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        //        imageUrl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //        imageUrl.widthAnchor.constraint(equalToConstant: 50).isActive =  true
        //
        imageUrl.addSubview(nameLabel)
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
       
        
        
        
    }
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
