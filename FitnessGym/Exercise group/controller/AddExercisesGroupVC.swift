//
//  AddExercisesGroupVC.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 05/11/2019.
//  Copyright © 2019 Grinevich Sergey. All rights reserved.
//

import UIKit
import Firebase

class AddExercisesGroupVC: UIViewController {
    
    var proverka: Int?
    
    lazy var logoExercisesGroup: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "add-image.png")
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLogoZoomTap)))
        return imageView
        
    }()
    
    
    lazy var imageExercisesGroup: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "add-image.png")
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleImageZoomTap)))
        
        //тень для изображения
        imageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        imageView.layer.shadowOpacity = 0.7
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        
        return imageView
        
    }()

    lazy var nameExercisesGroup : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите новую группу"
        return textField
    }()
    
    lazy var activityIndicator : UIActivityIndicatorView = {
        
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.center = view.center
        self.view.addSubview(indicator)
        return indicator
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupComponentsAddExercisesGroupView()
        
    }
    

    //MARK: Интерфейс 
    func setupComponentsAddExercisesGroupView() {
        
        let addButtonExercisesGroup = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addExercisesGroup))
        
        navigationItem.rightBarButtonItems = [addButtonExercisesGroup]
  

        let containerView : UIView = {
            let view = UIView()
    
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        view.addSubview(containerView)
        
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        
        containerView.addSubview(logoExercisesGroup)
        
        logoExercisesGroup.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        logoExercisesGroup.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 100).isActive = true
        logoExercisesGroup.widthAnchor.constraint(equalToConstant: 96).isActive = true
        logoExercisesGroup.heightAnchor.constraint(equalToConstant: 96).isActive = true
    
        containerView.addSubview(imageExercisesGroup)
        
        imageExercisesGroup.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        imageExercisesGroup.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        imageExercisesGroup.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageExercisesGroup.topAnchor.constraint(equalTo: logoExercisesGroup.bottomAnchor, constant: 10).isActive = true
        
        
        containerView.addSubview(nameExercisesGroup)
        
        nameExercisesGroup.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        nameExercisesGroup.topAnchor.constraint(equalTo: imageExercisesGroup.bottomAnchor, constant: 10).isActive = true
        nameExercisesGroup.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        nameExercisesGroup.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
      
    }
    
    //MARK: Добавление группы упражнений
    @objc func addExercisesGroup() {
        
        activityIndicator.startAnimating()
        
        let name = nameExercisesGroup.text
        let imageArray = ["logoImage": logoExercisesGroup.image, "exercisesImage": imageExercisesGroup.image]
        
        let ref =  Database.database().reference().child("ExercisesGroup")
        let childRef = ref.childByAutoId()
        
        
        for (key, image) in imageArray {

            let postRef = childRef.child("images")
//            let autoID = postRef.childByAutoId().key
            let childStorageRef = Storage.storage().reference().child("Images").child(name!).child("\(key).jpg")
             
            //        if let imageExercisesGroup = self.logoExercisesGroup.image, let uploadData = imageExercisesGroup.jpegData(compressionQuality: 0.1) {
            if let uploadData = image!.jpegData(compressionQuality: 0.1) {
                
                childStorageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                        return
                    }
                    
    
                childStorageRef.downloadURL { (url, error) in
                    if error != nil {
                        print("Failed to download url:", error!)
                        return
                    } else {
                        if let imageExercisesGroupUrl = url?.absoluteString {


                            let values = ["uid": childRef.key as AnyObject, "name": name as AnyObject]
                            let value = [key: imageExercisesGroupUrl]

                            childRef.updateChildValues(values)
                            postRef.updateChildValues(value)

                            
                           
                        }
                       
                    }

                }
                }
            }
            
        }
         self.navigationController?.popViewController(animated: true)
      //  activityIndicator.stopAnimating()
        
    }
    
    
}

//MARK: ImagePickerController
extension AddExercisesGroupVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    
    @objc func handleImageZoomTap() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        proverka = 1
        present(picker, animated: true, completion: nil)
    }
    
    @objc func handleLogoZoomTap() {
         let picker = UIImagePickerController()
         picker.delegate = self
         picker.allowsEditing = true
         proverka = 0
         present(picker, animated: true, completion: nil)
     }
    
    

     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         dismiss(animated: true, completion: nil)
     }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
         var selectedImageForPicker: UIImage?
        
        if let editingImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageForPicker = editingImage
      
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageForPicker = originalImage
        }
        
        if proverka == 0 {
            if let logoSelectedImage = selectedImageForPicker {
                self.logoExercisesGroup.image = logoSelectedImage
            }
        }
        else if proverka == 1 {
            if let selectedImage = selectedImageForPicker {
                self.imageExercisesGroup.image = selectedImage
            }
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
}
