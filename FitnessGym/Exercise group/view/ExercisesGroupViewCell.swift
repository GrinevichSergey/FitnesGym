//
//  ExercisesGroupViewCell.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 02/11/2019.
//  Copyright © 2019 Grinevich Sergey. All rights reserved.
//

import UIKit

class ExercisesGroupViewCell: UITableViewCell {
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
    
        
    }
    let exercisesGroupImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
        
    }()
    
    var exercisesImageLeftConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubview(exercisesGroupImageView)
        
        
        //сделать глобальный констраинт для сдвига изображения в таблице при редаетировании
//        
        exercisesImageLeftConstraint = exercisesGroupImageView.leftAnchor.constraint(equalTo: self.leftAnchor)
        exercisesImageLeftConstraint?.isActive = true
  
        exercisesGroupImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        exercisesGroupImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        exercisesGroupImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    



    
}
