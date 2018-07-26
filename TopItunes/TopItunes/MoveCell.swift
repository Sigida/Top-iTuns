//
//  MoveCell.swift
//  TopItunes
//
//  Created by Admin on 05.07.2018.
//  Copyright © 2018 roshy. All rights reserved.
//

import UIKit

class MoveCell: UICollectionViewCell {
    
    @IBOutlet weak var moveImage: UIImageView!
    @IBOutlet weak var moveName: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var imageURL: URL? {
        didSet {
            moveImage?.image = nil
            setImage()
        }
    }
        
    func setImage () {
        if let url = imageURL {
            spinner?.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = urlContents,
                        url == self?.imageURL {
                        self?.moveImage?.image = UIImage(data: imageData)
                    }
                    self?.spinner?.stopAnimating()
                }
            }
        }
    }
    
}


