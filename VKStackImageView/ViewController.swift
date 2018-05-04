//
//  ViewController.swift
//  VKStackImageView
//
//  Created by Vamshi Krishna on 20/04/18.
//  Copyright © 2018 Vamshi Krishna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var vkView : VKStackImageView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        vkView = VKStackImageView(imageNamesArray: ["dhoni.jpg","yuvi.jpg","shikhar.jpg","kohli.jpg"])
        view.addSubview(vkView!)
    }

    
    @IBAction func buttonTapped(_ sender: Any) {
        vkView?.toggleGallery()
    }
    

}

