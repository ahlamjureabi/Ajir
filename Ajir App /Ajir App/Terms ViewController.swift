//
//  Terms ViewController.swift
//  Ajir App
//
//  Created by Ahlam jur on 23/05/1443 AH.
//

import UIKit
import Firebase

class Terms_ViewController: UIViewController {
    var selectdata:[User] = []
    var selectDataPost:[Post] = []
        @IBOutlet weak var checkBox: UIButton!
         var flag = false
    
    
    
    
    
    
    
    @IBOutlet weak var termsLabel: UILabel! {
        
        didSet {

            termsLabel.text = "1- Not to use our Services if you are not legally qualified to complete this Agreement. For example, that you are under 18 years of age or that you are temporarily or permanently restricted from using the Application.2 - Not to manipulate the prices of the rental goods and cause harm to other users.3 - Not to publish false, inaccurate, misleading, deceptive, defamatory, or defamatory advertisements or comments.4 - Not to be exposed to international policies or sovereigns, or esteemed personalities, or any discussions that are not related to legitimate buying and selling in the Ajeer application.".localized
        }
    }
    
    
    @IBOutlet weak var termsAndConditions: UILabel!{
        didSet {

           termsAndConditions.text = "Terms and Conditions".localized
        }
    }
    
    
    @IBOutlet weak var nextButtonTranslate: UIButton!{
    
        didSet{
           nextButtonTranslate.setTitle("Next".localized, for: .normal)
        }
    }
    
@IBOutlet weak var cancelButtonTranslate: UIButton!{
    didSet{
       cancelButtonTranslate.setTitle("Cancel".localized, for: .normal)
    }
}

    
    
    @IBOutlet weak var agreeCondition: UILabel! {
        didSet {

           agreeCondition.text = "Agree to the terms".localized
        }
    }
    

        override func viewDidLoad() {
            super.viewDidLoad()
            nextButtonTranslate.addTarget(self, action: #selector(tapOnButton), for: .touchUpInside)
            
            
            view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))


        }
        
        @objc func tapOnButton(){
            let story = UIStoryboard(name: "Main", bundle: nil)
            let controller = story.instantiateViewController(withIdentifier: "HomeNavigationController") as! UINavigationController
            self.present(controller, animated: true, completion: nil)
        }
    @IBAction func checkBoxButton(_ sender: UIButton) {

        if (flag == false)
        {
            sender.setBackgroundImage((UIImage(named: "checkbox")), for: UIControl.State.normal)
            flag = true
        }
        else
            
        {
            sender.setBackgroundImage((UIImage(named:"uncheckbox")), for: UIControl.State.normal)
            flag = false
        }
        
    }
   
    
    @IBAction func nextButton(_ sender: Any) {
        
//        if let lang = (sender as AnyObject).titleForSegment(at:(sender as AnyObject).selectedSegmentIndex)?.lowercased() {
//            UserDefaults.standard.set(lang, forKey: "currentLanguage")
//            Bundle.setLanguage(lang)
//            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//               let sceneDelegate = windowScene.delegate as? SceneDelegate {
//                sceneDelegate.window?.rootViewController = storyboard.instantiateInitialViewController()
//            }
//        }
        
    
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNavigationController") as? UINavigationController {
            vc.modalPresentationStyle = .fullScreen
           
            self.present(vc, animated: true, completion: nil)
            
        }
            
        
        
        
        
        
        
        
        
        
    
    
}

}
