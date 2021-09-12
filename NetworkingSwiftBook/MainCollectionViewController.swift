//
//  MainCollectionViewController.swift
//  NetworkingSwiftBook
//
//  Created by Konstantin on 12.09.2021.
//

import UIKit

enum UserActions: String, CaseIterable {
    case downloadImage = "Download Image"
}

class MainCollectionViewController: UICollectionViewController {
    
    private let userActions = UserActions.allCases


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }


    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UserActionCell
    
        cell.userActionLabel.text = userActions[indexPath.item].rawValue
    
        return cell
    }

    // MARK: UICollectionViewDelegate


}
