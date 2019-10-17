//
//  OfferCell.swift
//  Le bon coin
//
//  Created by mbdse on 17/10/2019.
//  Copyright © 2019 Tokidev S.A.S. All rights reserved.
//

import UIKit

class OfferCell: UICollectionViewCell {
    
    var offer : Offer?{
        didSet{
            setOffer()
        }
    }
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .orange
        return label
    }()
    
    let descLabel : UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let priceLabel : UILabel = {
        let label = UILabel()
        label.text = "1$"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(frame: CGRect){
        super.init(frame:frame)
        addSubview(titleLabel)
        addSubview(descLabel)
        addSubview(priceLabel)
        
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        
        descLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        
        priceLabel.anchor(top: descLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    private func setOffer(){
        guard let offer = offer else{
            return
            
        }
        
        titleLabel.text = offer.title
        descLabel.text = offer.desc
        priceLabel.text = offer.price
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)has not been implemented")
    }
    
   
}

