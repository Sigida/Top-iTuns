//
//  ServerManager.swift
//  TopItunes
//
//  Created by Admin on 06.07.2018.
//  Copyright © 2018 roshy. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class ServerManager {
    
static let sharedInstance = ServerManager()
 
   var arrayMoves = [Moves]()
    
    func getRequest(apiToContact: String, complition:@escaping ()->Void) {
        
    Alamofire.request(apiToContact, method: .get).responseJSON { response in
    guard response.result.isSuccess else {
    print("Error request \(String(describing: response.result.error))")
    return
    
    }

    if  let arrayOfItems = response.result.value {
    let json = JSON(arrayOfItems)
    let topMovieDataArray = json["feed"]["results"].arrayValue
        
    for item in topMovieDataArray {
    let move = Moves(json: item )
        
    self.arrayMoves.append(move)
    
    complition()
        
    }
        }
        }
    
    }
    }
