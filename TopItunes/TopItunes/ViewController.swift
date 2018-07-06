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
    

    
    @IBOutlet weak var topMovesCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
      //request
        
        let apiToContact = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/10/explicit.json"
        
        Alamofire.request(apiToContact, method: .get).responseJSON { response in
            guard response.result.isSuccess else {
                print("Error request \(String(describing: response.result.error))")
                
                return
            }
            if  let arrayOfItems = response.result.value {
                let json = JSON(arrayOfItems)
                let topMovieDataArray = json["feed"]["results"].arrayValue
                //print(topMovieDataArray)
                
                for item in topMovieDataArray {
                    let move = Moves(json: item )
                    self.listOfMove.append(move)
                    
                }
            }
            DispatchQueue.main.async {
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
       //cell.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        //cell.moveName.text = "New Move"
         let textData = listOfMove[indexPath.row]
        cell.moveName.text = textData.name
        cell.moveImage.setImageFromURl(stringImageUrl: textData.linkImage)
        return cell
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

