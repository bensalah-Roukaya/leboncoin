//
//  Project > Le bon coin
//  Filename > ViewController.swift
//
//  Created by Guillaume Gonzales on 04/10/2018.
//  Copyright © 2018 Tokidev S.A.S. - All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"


class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var offers = [Offer]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .lightGray
        
        self.collectionView!.register(OfferCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        setupNavigationBarTitle()
        fetchOffers()
    }
    

    
    @objc func handleRefresh() {
        fetchOffers()
    }
    
    fileprivate func fetchOffers() {
        offers.removeAll()
        let ref = Database.database().reference().child("offers")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
        self.collectionView.refreshControl?.endRefreshing()

        guard let offersDic = snapshot.value as? [String: Any] else { return }
            
    
        offersDic.forEach({ (oid, offerValue) in
        guard let offerValue = offerValue as? [String: Any] else { return }
        let offer = Offer(dictionary: offerValue)
        self.offers.insert(offer, at: 0)
        })
         
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }) { (err) in
            print("Failed fetching offers:", err)
        }
    }

    fileprivate func setupNavigationBarTitle() {
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "logo").withRenderingMode(.alwaysOriginal))
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.clipsToBounds = true
        navigationItem.titleView = titleImageView
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return offers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            as! OfferCell
        
        let offer = offers[indexPath.row]
        cell.offer = offer
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)-> CGSize{
        return CGSize(width: view.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section : Int)-> CGFloat {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section : Int)-> CGFloat {
        return 1
    }

}

