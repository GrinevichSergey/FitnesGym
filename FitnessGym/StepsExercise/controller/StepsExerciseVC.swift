//
//  StepsExerciseVC.swift
//  FitnessGym
//
//  Created by Сергей Гриневич on 16.05.2020.
//  Copyright © 2020 Grinevich Sergey. All rights reserved.
//

import UIKit
import SwiftyGif
import AlamofireImage
import AVKit
import SQLite


class StepsExerciseVC: UIViewController, UIScrollViewDelegate, StepsJsonDelegate {
    
    var player: AVPlayer?
    var playerViewController: AVPlayerViewController!
    var stepsJson = StepsJson()
    var stepsItems = StepsModal()
    var stepsContent = ContentsModal()
    //    var yPosition : CGFloat = 0
    //    var scrollViewContentSize: CGFloat = 0
    var exercise : ExerciseModal?
    fileprivate var padding:  CGFloat = 10
    var headerView: StepsHeaderCell?
    var cellID = "cellID"
    var headerID = "headerID"
    
    var database: Connection!
    let favoriteTable = Table("Favorite")
    let id_favorite = Expression<Int>("id_favorite")
    let id_exercise = Expression<Int>("id_exercise")
    
    lazy var pageControll: UIPageControl = {
        let pageControll = UIPageControl()
        //pageControll.numberOfPages = stepsContent.count
        pageControll.translatesAutoresizingMaskIntoConstraints = false
        pageControll.currentPage = 0
        //pageControll.tintColor = UIColor.red
        pageControll.pageIndicatorTintColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        pageControll.currentPageIndicatorTintColor = .black
        return pageControll
        
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 210))
        //  scrollView.backgroundColor = .yellow
        return scrollView
    }()
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupCollectionView()
        setupCollectionViewLayout()
        stepsJson.delegate = self
        
        database = LocalDatabase.shared.connection
        
        setUpFavoriteButton(favorite: listFavorite())
        
    }
    
    deinit {
       // FavoriteVC.shared.listFavorite()
        print("Steps deinit")
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
//
//        print("erfergverg")
//    }
    
    
    func itemsStepsDowloaded(steps: StepModal) {
        
        stepsItems.append(steps)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func itemsContentDowloaded(content: ContentModal) {
        stepsContent.append(content)
        DispatchQueue.main.async {
            self.addStepsMediaForScrollView()
            self.pageControll.numberOfPages = self.stepsContent.count
        }
    }
    
    fileprivate func addStepsMediaForScrollView() {
        
        for  i in stride(from: 0, to: stepsContent.count, by: 1) {
            var frame = CGRect.zero
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(i)
            frame.origin.y = 0
            frame.size = self.scrollView.frame.size
            self.scrollView.isPagingEnabled = true
            
            switch stepsContent[i].type {
            case "gif":
                guard let url = URL(string: stepsContent[i].path) else { return }
                uploadGIF(url: url, frame: frame)
                break
            case "image":
                guard let url = URL(string: stepsContent[i].path) else { return }
                uploadImage(url: url, frame: frame)
                
                break
            case "video":
                guard let url = URL(string: stepsContent[i].path) else { return }
                uploadVideo(url: url, frame: frame)
                break
                
            default:
                break
            }
            
        }
        
        scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * CGFloat(stepsContent.count), height: self.scrollView.frame.size.height)
        
    }
    
    fileprivate func uploadImage(url: URL, frame: CGRect) {
        let myImageView = UIImageView()
        myImageView.contentMode = .scaleAspectFill
        myImageView.clipsToBounds = true
        myImageView.frame = frame
        myImageView.af.cancelImageRequest()
        myImageView.af.setImage(withURL: url)
        scrollView.addSubview(myImageView)
    }
    
    fileprivate func uploadVideo(url: URL, frame: CGRect) {
        
        self.player =  AVPlayer(url: url)
        self.playerViewController = AVPlayerViewController()
        playerViewController.player = self.player
        playerViewController.view.frame = frame
        playerViewController.player?.pause()
        scrollView.addSubview(playerViewController.view)
        
    }
    
    
    fileprivate func uploadGIF(url: URL, frame: CGRect) {
        let myImageView = UIImageView()
        myImageView.setGifFromURL(url)
        myImageView.contentMode = .scaleAspectFit
        myImageView.clipsToBounds = true
        myImageView.frame = frame
        scrollView.addSubview(myImageView)
    }
    
    fileprivate func createFavoriteTable() {
        do {
            let itExists = try database.scalar(favoriteTable.exists)
            if itExists {
                print("table Favorite already exists ")
            }
        } catch {
            let createTable = self.favoriteTable.create { (table) in
                table.column(self.id_favorite, primaryKey: true)
                table.column(self.id_exercise)
            }
            do {
                try self.database.run(createTable)
                print("Created table")
            } catch {
                print(error)
            }
        }
    }
    
    
    fileprivate func insertFavorite() {
        if let id = self.exercise?.id_exercise {
            let insertFavorite = self.favoriteTable.insert(self.id_exercise <- id)
            do {
                try self.database.run(insertFavorite)
                
                print("insert favorite")
            } catch {
                print(error)
            }
        }
    }
    
    fileprivate func deleteFavoriteItems() {
        guard let id = exercise?.id_exercise else { return }
        let favorite = self.favoriteTable.filter(self.id_exercise == id)
        let delete = favorite.delete()
        do {
            try self.database.run(delete)
        } catch {
            print(error)
        }
    }
    
    fileprivate func listFavorite() -> Bool {
        var isFavorite = Bool()
        do {
            let favorites = try self.database.prepare(self.favoriteTable)
            for favorite in favorites {
                if exercise?.id_exercise == favorite[self.id_exercise] {
                    isFavorite = true
                    break
                } else {
                    isFavorite = false
                }
                // findFavorite(id_exercise: exercise?.id_exercise, favorites: favorite[self.id_exercise])
            }
        } catch {
            print(error)
        }
        return isFavorite
    }
    
    
    
    @objc func favoriteTapBtn() {
        if !listFavorite() {
            let alert = UIAlertController(title: "Внимание", message: "Добавить упражнение в избранное?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Yes", style: .cancel) { [weak self] (_) in
                guard let self = self else { return }
        
                self.createFavoriteTable()
                self.insertFavorite()
                self.setUpFavoriteButton(favorite: true)
                
            }
            let noAction = UIAlertAction(title: "No", style: .default) { (_) in
                print("No")
            }
            alert.addAction(yesAction)
            alert.addAction(noAction)
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Внимание", message: "Удалить упражнение из избранного?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Yes", style: .cancel) { [weak self] (_) in
                guard let self = self else { return }
                self.deleteFavoriteItems()
                self.setUpFavoriteButton(favorite: false)
                
            }
            let noAction = UIAlertAction(title: "No", style: .default) { (_) in
                print("No")
            }
            alert.addAction(yesAction)
            alert.addAction(noAction)
            present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    fileprivate func setUpFavoriteButton(favorite: Bool) {
        
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        if favorite {
            menuBtn.setImage(UIImage(named:"icons8-star-100"), for: .normal)
        } else {
            menuBtn.setImage(UIImage(named:"star"), for: .normal)
        }
        menuBtn.addTarget(self, action: #selector(favoriteTapBtn), for: .touchUpInside)
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
        currHeight?.isActive = true
        self.navigationItem.rightBarButtonItem = menuBarItem
    }
    
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    //смена / переключение
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControll.currentPage) * scrollView.frame.size.width
        
        scrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
        
    }
    
    //менять курсор
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControll.currentPage = Int(pageNumber)
        playerViewController.player?.pause()
    }
    
    
}

extension StepsExerciseVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stepsItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! StepsCell
        
        //cell.backgroundColor = .black
        cell.numberSteps.text = "\(indexPath.row + 1)"
        cell.stepsLabel.text = stepsItems[indexPath.row].steps
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //  return .init(width: view.frame.width, height: 70)
        return .init(width: view.frame.width - 2 * padding, height: 70)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as? StepsHeaderCell
        
        headerView?.descriptionLabel.text = exercise?.description
        
        return headerView!
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffSetY = scrollView.contentOffset.y
        
        if contentOffSetY > 0 {
            headerView?.animator.fractionComplete = abs(contentOffSetY) / 100
            
            return
        }
        headerView?.animator.fractionComplete = 0
        
    }
    
    fileprivate func setupCollectionView() {
        
        collectionView.register(StepsCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(StepsHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: pageControll.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
    }
    
    fileprivate func setupCollectionViewLayout() {
        //layout customization
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
            //отступ между ячейками
            // layout.minimumLineSpacing = 24
        }
    }
    
}



extension StepsExerciseVC {
    
    fileprivate func setupUI() {
        
        view.backgroundColor = .white
        navigationItem.title = exercise?.name_exercise
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 15)!], for: .normal)
        //        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "star2").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(favoriteTapBtn))
        
        let containerImageView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
            
        }()
        view.addSubview(containerImageView)
        
        containerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        containerImageView.heightAnchor.constraint(equalToConstant: 210).isActive = true
        containerImageView.addSubview(pageControll)
        
        pageControll.leftAnchor.constraint(equalTo: containerImageView.leftAnchor).isActive = true
        pageControll.heightAnchor.constraint(equalToConstant: 20).isActive = true
        pageControll.bottomAnchor.constraint(equalTo: containerImageView.bottomAnchor, constant: 20).isActive = true
        pageControll.centerXAnchor.constraint(equalTo: containerImageView.centerXAnchor).isActive = true
        
        pageControll.addTarget(self, action: #selector(changePage), for: UIControl.Event.valueChanged)
        
        containerImageView.addSubview(scrollView)
        scrollView.delegate = self
        
    }
    
}
