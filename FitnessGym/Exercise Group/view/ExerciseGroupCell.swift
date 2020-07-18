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
        label.font = UIFont(name: "Roboto-Bold", size: 24)
        label.textAlignment = .left
        return label
        
    }()
    
    var contentTextView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2960188356)
        //view.layer.opacity = 20
        view.layer.cornerRadius = 10
    
        return view
    }()
    
    
    var imageUrl: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    var countExercise: UILabel = {
        let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.textColor = UIColor.MyThemeColor.labelColor
           label.font = UIFont(name: "Roboto-Bold", size: 12)
           label.textAlignment = .left
        label.text = "15 exercise"
           return label
    }()
    
    func fetchItems(exerciseGroup: ExerciseGroupModal) {
        
        nameLabel.text = exerciseGroup.nameGroup
        
        countExercise.text = "\(String(exerciseGroup.exerciseCount!)) exercise"
        
        if let imageUrl = exerciseGroup.imageURL, let url = URL(string: imageUrl)  {
            self.imageUrl.af.cancelImageRequest()
            self.imageUrl.af.setImage(withURL: url, cacheKey: imageUrl)
        }
        

    }
    
    var contentTextViewLeftConstraint: NSLayoutConstraint?
    var contentTextViewRightConstraint: NSLayoutConstraint?
    
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
        
        imageUrl.addSubview(contentTextView)
        

        contentTextViewLeftConstraint = contentTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30)
        contentTextViewLeftConstraint?.isActive = false
        
        contentTextViewRightConstraint = contentTextView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30)
        contentTextViewRightConstraint?.isActive = false

       // contentTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        contentTextView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 20).isActive = true
        contentTextView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        contentTextView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
     
        
        contentTextView.addSubview(nameLabel)
        nameLabel.leftAnchor.constraint(equalTo: contentTextView.leftAnchor, constant: 5).isActive = true
        nameLabel.topAnchor.constraint(equalTo: contentTextView.topAnchor, constant: 5).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        contentTextView.addSubview(countExercise)
        countExercise.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        countExercise.leftAnchor.constraint(equalTo: contentTextView.leftAnchor, constant: 5).isActive = true
        countExercise.widthAnchor.constraint(equalToConstant: 150).isActive = true
        countExercise.heightAnchor.constraint(equalToConstant: 15).isActive = true
        

    }
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
