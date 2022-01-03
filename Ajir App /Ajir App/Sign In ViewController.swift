//
//  Sign In ViewController.swift
//  Ajir App
//
//  Created by Ahlam Ahlam on 23/05/1443 AH.
//

import UIKit
import Firebase
class Sign_In_ViewController: UIViewController {

    var activityIndicator = UIActivityIndicatorView()
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var emailLabelSinIn: UILabel!{
        
        didSet {

           emailLabelSinIn.text = "E-mail".localized
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var passwordlabelSinin: UILabel!{
        
        didSet {

            passwordlabelSinin.text = "Password".localized
        }
    }
    
    @IBOutlet weak var creataAccountButton: UIButton!{
        
        didSet{
            creataAccountButton.setTitle("Create an account".localized, for: .normal)
        }
    }
    
   
    @IBOutlet weak var sininButtonpage: UIButton! {
        didSet{
           sininButtonpage.setTitle("Sig in".localized, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func handleLogin(_ sender: Any) {
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let _ = authResult {
                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNavigationController") as? UINavigationController {
                        vc.modalPresentationStyle = .fullScreen
                        Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            }
        }
    }

    
}

