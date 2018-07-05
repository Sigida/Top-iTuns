//
//  Moves.swift
//  TopItunes
//
//  Created by Admin on 05.07.2018.
//  Copyright © 2018 roshy. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Moves {
    
    let name: String
    let linkImage: String
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.linkImage = json["artworkUrl100"].stringValue
    }
}
