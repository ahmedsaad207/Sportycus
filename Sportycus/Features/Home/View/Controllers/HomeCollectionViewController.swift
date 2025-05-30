//
//  HomeCollectionViewController.swift
//  Sportycus
//
//  Created by Ahmed Saad on 29/05/2025.
//

import UIKit

private let sportCellIdentifier = "SportCell"

class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let sportsImages = [
        "football",
        "basketball",
        "tennis",
        "cricket",
    ]
    
    private let sportsTitles = [
        "Football",
        "Basketball",
        "Tennis",
        "Cricket",
    ]
    
    func setupAppBar(){
        self.navigationItem.title = "Sports"
    }
    

    func registerNibs(){
        let nibSport = UINib(nibName: sportCellIdentifier, bundle: nil)
        collectionView.register(nibSport, forCellWithReuseIdentifier: sportCellIdentifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppBar()
        registerNibs()

        

    }

//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let size = (collectionView.bounds.width)*0.45
//        
//     return CGSize(width: size, height: size)
//    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sportCellIdentifier, for: indexPath) as! SportCell
    
        let sportImage = sportsImages[indexPath.row]
        let sportTitle = sportsTitles[indexPath.row]
        cell.config(imgName: sportImage, title: sportTitle)
    
        return cell
    }

}
