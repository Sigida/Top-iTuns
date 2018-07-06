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
        ServerManager.sharedInstance.getRequest(apiToContact: apiToContact) {
            DispatchQueue.main.async {
                self.listOfMove = ServerManager.sharedInstance.arrayMoves
                self.topMovesCollection.reloadData()
            }
        }
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
  
       //self.performSegue(withIdentifier:"Description", sender: self)
     
     //  let textData = listOfMove[indexPath.row]
    //textImageName = textData.linkImage
    //textName = textData.name
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
      if let identifire = segue.identifier,
        identifire == "Description",
        let descriptionVC = segue.destination as? DescriptionController {
        
      //descriptionVC.textName = textName
      //descriptionVC.textImage = textImageName
        
        }
    }
    
    
}

extension UIImageView{
    
    func setImageFromURl(stringImageUrl url: String){
        
        if let url = NSURL(string: url) {
            if let data = NSData(contentsOf: url as URL) {
                self.image = UIImage(data: data as Data)
            }
        }
    }
}

