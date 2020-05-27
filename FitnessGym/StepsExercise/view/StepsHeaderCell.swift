//
//  StepsHeaderViewCell.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 17.05.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import Foundation
import UIKit

class StepsHeaderCell: UICollectionReusableView {
    
    var headingLabel: UILabel = {
        let label = UILabel()
  
        label.text = "Description"
        label.textColor = .black
        label.font = UIFont(name: "Roboto-Regular", size: 20)
        label.numberOfLines = 0
        return label
        
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()

        label.textColor = .gray
        label.textAlignment =  .justified
        label.font = UIFont(name: "Roboto-Regular", size: 15)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()
    
    
    var visualEffectView =  UIVisualEffectView(effect: nil)
    let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 3
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        let stackView = UIStackView(arrangedSubviews:
        [headingLabel, descriptionLabel]
        )
        stackView.axis = .vertical
        //stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.spacing = 5.0
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        //stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = false
        
        
        setupVisualEffectBlur()
        setupGradientLayer()
        
        
    }
    
    fileprivate func setupVisualEffectBlur() {
        
        self.addSubview(visualEffectView)
        
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
        visualEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
       
        animator.addAnimations {
            self.visualEffectView.effect = UIBlurEffect(style: .regular)
        }
    
        animator.fractionComplete = 0
        
        animator.startAnimation()
        animator.stopAnimation(true)
    }
    
    func setupGradientLayer() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [-0.5, 1.0]

//        layer.addSublayer(gradientLayer)
        let gradientConteinerView = UIView()
        
        addSubview(gradientConteinerView)
        
        gradientConteinerView.translatesAutoresizingMaskIntoConstraints = false
        gradientConteinerView.topAnchor.constraint(equalTo: topAnchor).isActive = false
        gradientConteinerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        gradientConteinerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        gradientConteinerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        

        gradientConteinerView.layer.addSublayer(gradientLayer)

        gradientLayer.frame = self.bounds
        gradientLayer.frame.origin.y -= bounds.height
    

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



