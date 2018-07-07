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
    
    enum Result <T> {
        
        case Success(T)
        case Error(String)
        
    }
    
    
    func getRequest(apiToContact: String,
                    complition:@escaping (Result<[Moves]>)->Void) {
        
    Alamofire.request(apiToContact, method: .get).responseJSON { response in
        
    guard response.result.isSuccess else {
  
    return complition(.Error("Error request \(String(describing: response.result.error))"))
    
    }

    guard let arrayOfItems = response.result.value else {
        
    return complition(.Error("Can't get array of data"))
       
    }
        
    let json = JSON(arrayOfItems)
            
    let topMovieDataArray = json["feed"]["results"].arrayValue
    
    var arrayMoves = [Moves]()
        
    for item in topMovieDataArray {
        
    let move = Moves(json: item )
    
    arrayMoves.append(move)
        
        }
        
        DispatchQueue.main.async {
            complition(.Success(arrayMoves))
        }
        
        }
        }
    
    }

