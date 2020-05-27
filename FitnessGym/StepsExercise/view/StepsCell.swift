//
//  StepsCell.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 17.05.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import UIKit

class StepsCell: UICollectionViewCell {
    
    
     var numberSteps : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.MyThemeColor.exerciseLabelColor
        label.font = UIFont(name: "Roboto-Regular", size: 22)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()
    
    var stepsLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.MyThemeColor.exerciseLabelColor
        label.font = UIFont(name: "Roboto-Regular", size: 15)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let numberView: UIView = {
            let view = UIView()
            view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            view.layer.cornerRadius = 25
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        addSubview(numberView)
        numberView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        numberView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true     
        numberView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        numberView.widthAnchor.constraint(equalToConstant: 50).isActive = true
      
        numberView.addSubview(numberSteps)
        
        numberSteps.centerYAnchor.constraint(equalTo: numberView.centerYAnchor).isActive = true
        numberSteps.centerXAnchor.constraint(equalTo: numberView.centerXAnchor).isActive = true
        
        
        let stepsView: UIView = {
            let view = UIView()

            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        
        addSubview(stepsView)
        stepsView.leadingAnchor.constraint(equalTo: numberView.trailingAnchor, constant: 10).isActive = true
        stepsView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stepsView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        stepsView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
   
        stepsView.addSubview(stepsLabel)
      
        stepsLabel.leadingAnchor.constraint(equalTo: stepsView.leadingAnchor).isActive = true
        stepsLabel.trailingAnchor.constraint(equalTo: stepsView.trailingAnchor).isActive = true
        stepsLabel.bottomAnchor.constraint(equalTo: stepsView.bottomAnchor).isActive = true
        stepsLabel.topAnchor.constraint(equalTo: stepsView.topAnchor).isActive = true
        stepsLabel.centerXAnchor.constraint(equalTo: stepsView.centerXAnchor).isActive = true
        

        let border : CALayer = {
            let br = CALayer()
            br.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width - 80, height: 1)
            br.backgroundColor = UIColor.black.cgColor
            return br
        }()
       
        stepsView.layer.addSublayer(border)
        
    
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
