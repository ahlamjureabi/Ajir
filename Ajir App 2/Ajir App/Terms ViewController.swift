//
//  Terms ViewController.swift
//  Ajir App
//
//  Created by Ahlam Ahlam on 23/05/1443 AH.
//

import UIKit
//import Firebase

class Terms_ViewController: UIViewController {
    @IBOutlet weak var textViewTerms: UIButton!
    
    @IBOutlet weak var checkBox: UIButton!
    
     var flag = false
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func checkBoxButton(_ sender: UIButton) {
        
        if (flag == false)
        {
            sender.setBackgroundImage((UIImage(named:"checkbox")), for: UIControl.State.normal)
            flag = true
        }
        else
        {
            sender.setBackgroundImage((UIImage(named:"uncheckbox")), for: UIControl.State.normal)
            flag = false
        }
       
        
    }
   
    
    
}

