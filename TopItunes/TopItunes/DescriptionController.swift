//
//  DescriptionController.swift
//  TopItunes
//
//  Created by Admin on 06.07.2018.
//  Copyright © 2018 roshy. All rights reserved.
//

import UIKit

class DescriptionController: UIViewController {

    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var filmName: UILabel!
    
    var textName = ""
    var textImage = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func closeWindow(_ sender: UIButton) {
        dismiss(animated: true) {
            
        }
    }
    
    func setupView() {
      //filmImage.setImageFromURl(stringImageUrl: textImage)
       // print (textName)
        //filmName.text = textName
        
    }
    
}
