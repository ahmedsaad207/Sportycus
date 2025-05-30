//
//  LeagueDetailsController.swift
//  Sportycus
//
//  Created by Youssif Nasser on 30/05/2025.
//

import UIKit


class LeagueDetailsController: UICollectionViewController {

    
    func setupAppBar(){
        let heartImage = UIImage(systemName: "heart")
            let heartButton = UIBarButtonItem(
                image: heartImage,
                style: .plain,
                target: self,
                action: #selector(heartButtonTapped)
            )
            navigationItem.rightBarButtonItem = heartButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppBar()
        

    }

   
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseIdentifier", for: indexPath)
    
    
        return cell
    }

    @objc func heartButtonTapped() {
        print("Heart button tapped")
    }
}
