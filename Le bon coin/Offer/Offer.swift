//
//  Offer.swift
//  Le bon coin
//
//  Created by mbdse on 17/10/2019.
//  Copyright © 2019 Tokidev S.A.S. All rights reserved.
//

import Foundation
struct Offer {
    var title : String
    var category : String
    var city : String
    var desc : String
    var price : String
    
    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.category = dictionary["category"] as? String ?? ""
        self.city = dictionary["city"] as? String ?? ""
        self.desc = dictionary["desc"] as? String ?? ""
        self.price = dictionary["price"] as? String ?? ""
    }
}
