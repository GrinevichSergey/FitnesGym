//
//  HeaderCell.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 16.05.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import UIKit


class HeaderCell: UITableViewHeaderFooterView {
    
    static let reuseIdentifier: String = String(describing: self)
    
    var imageExercise: UIImageView = {
        var imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    
    var nameExercise:  UILabel = {
        let label = UILabel()
        label.text = "Neck"
        label.font = UIFont(name: "Roboto-Bold", size: 30)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    
    
   var visualEffectView =  UIVisualEffectView(effect: nil)
   let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        //  self.backgroundColor = .red
        contentView.addSubview(imageExercise)
        
        imageExercise.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
        imageExercise.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageExercise.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageExercise.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
   
        contentView.addSubview(nameExercise)
        
        nameExercise.translatesAutoresizingMaskIntoConstraints = false
        nameExercise.topAnchor.constraint(equalTo: topAnchor).isActive = false
        nameExercise.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        nameExercise.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16).isActive = true
        nameExercise.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true

        
//        setupVisualEffectBlur()
//        setupGradientLayer()
    }
    


//
//    fileprivate func setupVisualEffectBlur() {
//
//        contentView.addSubview(visualEffectView)
//
//        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
//        visualEffectView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
//        visualEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        visualEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        visualEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//
//
//        animator.addAnimations {
//
//            self.visualEffectView.effect = UIBlurEffect(style: .regular)
//        }
//
//
//        animator.fractionComplete = 0
//
//    }
//
//
//
//    func setupGradientLayer() {
//
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
//        gradientLayer.locations = [0.5, 1]
//
////        layer.addSublayer(gradientLayer)
//        let gradientConteinerView = UIView()
//
//        contentView.addSubview(gradientConteinerView)
//
//        gradientConteinerView.translatesAutoresizingMaskIntoConstraints = false
//        gradientConteinerView.topAnchor.constraint(equalTo: topAnchor).isActive = false
//        gradientConteinerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        gradientConteinerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        gradientConteinerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//
//
//        gradientConteinerView.layer.addSublayer(gradientLayer)
//
//        gradientLayer.frame = self.bounds
//        gradientLayer.frame.origin.y -= bounds.height
//
//        let label = UILabel()
//        label.text = "Neck"
//        label.font = UIFont(name: "Roboto-Bold", size: 30)
//        label.numberOfLines = 0
//        label.textColor = .white
//
//        contentView.addSubview(label)
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.topAnchor.constraint(equalTo: topAnchor).isActive = false
//        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
//        label.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16).isActive = true
//        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
//
//
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



