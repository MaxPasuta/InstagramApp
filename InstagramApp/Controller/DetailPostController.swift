//
//  DetailPostController.swift
//  InstagramApp
//
//  Created by Максим Пасюта on 29.03.2022.
//

import UIKit

class DetailPostController: UIViewController {

    var name = ""
    var image = UIImage()
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = name
        imageView.image = image
        
    }
    
}
