//
//  Project > Le bon coin
//  Filename > NewOfferController.swift
//
//  Created by Guillaume Gonzales on 04/10/2018.
//  Copyright © 2018 Tokidev S.A.S. - All rights reserved.
//

import UIKit
import Firebase

class NewOfferController: UIViewController {
    var offers = [Offer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBarTitle()
        setupNewOffer()
    }
    
    fileprivate func setupNavigationBarTitle() {
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "logo").withRenderingMode(.alwaysOriginal))
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.clipsToBounds = true
        navigationItem.titleView = titleImageView
    }
    
    let titleTF : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    let categoryTF : UITextField = {
        let textField = UITextField()
        textField.placeholder = "category"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    let cityTF : UITextField = {
        let textField = UITextField()
        textField.placeholder = "city"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    let descTF : UITextField = {
        let textField = UITextField()
        textField.placeholder = "description"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()

    let priceTF : UITextField = {
        let textField = UITextField()
        textField.placeholder = "price"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    let createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(red: 255/255, green: 127/255, blue: 0/255, alpha: 0.5)
        button.addTarget(self, action: #selector(handleOffer), for: .touchUpInside)
        return button
    }()
    

    fileprivate func setupNewOffer() {
        view.addSubview(titleTF)
        view.addSubview(categoryTF)
        view.addSubview(cityTF)
        view.addSubview(descTF)
        view.addSubview(priceTF)
        view.addSubview(createButton)
        
        titleTF.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 50)
        
        categoryTF.anchor(top: titleTF.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 50)
        
        cityTF.anchor(top: categoryTF.bottomAnchor, leading:  view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 50)
        
        descTF.anchor(top: cityTF.bottomAnchor, leading:  view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 50)
        
        priceTF.anchor(top: descTF.bottomAnchor, leading:  view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 50)
        
        createButton.anchor(top: priceTF.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 50)
        
    }
    
    @objc func handleTextChange() {
        let formValid = titleTF.text?.isEmpty == false && categoryTF.text?.isEmpty == false && cityTF.text?.isEmpty == false
        && descTF.text?.isEmpty == false && priceTF.text?.isEmpty == false
        
        if formValid {
            createButton.backgroundColor = UIColor(red: 255/255, green: 127/255, blue: 0/255, alpha: 1)
            createButton.isEnabled = true
        } else {
            createButton.backgroundColor = UIColor(red: 255/255, green: 127/255, blue: 0/255, alpha: 0.5)
            createButton.isEnabled = false
        }
    }
    
    @objc func handleOffer() {
        guard let title = titleTF.text else { return }
        guard let category = categoryTF.text else { return }
        guard let city = cityTF.text else { return }
        guard let desc = descTF.text else { return }
        guard let price = priceTF.text else { return }
        
        let values = ["title": title, "category": category, "city": city, "desc": desc, "price": price ] as [String: Any]
        
        let ref = Database.database().reference().child("offers").childByAutoId()
        ref.updateChildValues(values){
            (err, ref) in
            if let err = err {
                print("Error :", err)
                return
            }
        }
        
        
        let alertController = UIAlertController(title: "Le bon coin", message: "New offer added !", preferredStyle: .alert)
        
        
        self.present(alertController, animated: true, completion: nil)
        
        let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            print("You've pressed on ok");
            
        }
        alertController.addAction(action1)
        
    }
    
    
}
    
    
    

