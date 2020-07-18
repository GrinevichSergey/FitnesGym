//
//  AddTrainingRowCell.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 06.06.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import UIKit
import AlamofireImage

//
//protocol MyCellDelegate: class {
//    func didTapButtonInCell(_ cell: AddTrainingRowCell)
//}

class AddTrainingRowCell: UITableViewCell {
    
   // weak var delegate: MyCellDelegate?
    
    var exercise: ExerciseModal? {
        didSet {
            fetchItems(exercise: exercise!)
        }
    }
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Roboto-Regular", size: 15)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
        
    }()
    
    var imageURL: UIImageView = {
        var imageView = UIImageView(image: #imageLiteral(resourceName: "weightlifting"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    
    
    let checkImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "unCheck")
        image.contentMode = .scaleAspectFit
        return image
        
    }()
    
    
    
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
        
        self.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 5.0
        stackView.addArrangedSubview(imageURL)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(checkImage)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        imageURL.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageURL.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: imageURL.rightAnchor, constant: 5).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        checkImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        checkImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        selectionStyle = .none
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//
//    @objc func checkCell(_ sender: UIButton) {
//
//
//        delegate?.didTapButtonInCell(self)
//    }
//
    //
    
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        self.backgroundColor =  #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
////        // contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
////        contentView.layer.cornerRadius = 5
////        contentView.layer.shadowColor = UIColor.lightGray.cgColor
////        contentView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
////        contentView.layer.shadowRadius = 1.0
////        contentView.layer.shadowOpacity = 1.0
////        contentView.layer.masksToBounds = false
////        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
////        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
//
//    }
//
    
}
