//
//  ViewController.swift
//  TopItunes
//
//  Created by Admin on 05.07.2018.
//  Copyright © 2018 roshy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    
    
    //connect to model
 fileprivate var  listOfMove = [Moves]()
   var textName = ""
   var textImageName = ""
    
    
    private let apiToContact = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/10/explicit.json"

    
    @IBOutlet weak var topMovesCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
      //request
            getMoves(apiToContact: apiToContact)
      
    }
    
    func getMoves(apiToContact:String) {
        ServerManager.sharedInstance.getRequest(apiToContact: apiToContact) { (result) in
            
            switch result {
                
            case.Success(let data):
                self.listOfMove = data
                self.topMovesCollection.reloadData()
                
            case.Error(let massage):
                
                DispatchQueue.main.async { [weak self] in
                    self?.showAlertWith(title: "Error", message: massage)
                }
    }
    }
    }
    
    func showAlertWith(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: title, style: .default) {
            [weak self]
            (action) in
            self?.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
       present(alert, animated: true, completion: nil)
    }
   
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfMove.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoveCell", for: indexPath) as! MoveCell
       
        
         let textData = listOfMove[indexPath.row]
        
        cell.moveName.text = textData.name
        cell.moveImage.setImageFromURl(stringImageUrl: textData.linkImage)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  
        
    let textData = listOfMove[indexPath.row]
    textImageName = textData.linkImage
    textName = textData.name
       
        self.performSegue(withIdentifier:"Description", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
      if let identifire = segue.identifier,
        identifire == "Description",
        let descriptionVC = segue.destination as? DescriptionController {
       
    // descriptionVC.textName = textName
     
    //descriptionVC.textImage = textImageName
        
        }
    }
    
    
}

extension UIImageView{
    
    func setImageFromURl(stringImageUrl urlSt: String){
        
        if let url = URL(string: urlSt) {
            
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
             let urlContents =  try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = urlContents {
                        self?.image = UIImage(data: imageData)
                    }
                }
               
        }
        }
    }
}

