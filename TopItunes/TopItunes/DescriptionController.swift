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
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var textName = ""
   
    
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil {
                setImage()
            }
        }
    }
   
    
    private var image: UIImage? {
        get {
            return filmImage.image
        }
        set {
            filmImage?.image = newValue
            spinner?.stopAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
       setupView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if filmImage.image == nil {
         
            setImage()
            
        }
       
    }

    @IBAction func buyMove(_ sender: UIButton) {
        self.showAlertWith(title: "Oops!", message:"this service is not available in the demo version", titleForAction:"Ok" )

    }
    
    func setupView() {
   
     filmName.text = textName
     
    }
    
   
    
    
    
    func setImage () {
        
        if let url = imageURL {
          
           spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    if let imageData = urlContents,
                        url == self?.imageURL {
                        print(url)
                        self?.image = UIImage(data: imageData)
                        
                    }
                }
            }
        }
    }
}
    

