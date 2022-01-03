//
//  LandingViewController.swift
//  Ajir App
//
//  Created by Ahlam Ahlam on 23/05/1443 AH.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var languageSegmentControl: UISegmentedControl!{
        didSet {
            if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
                switch lang {
                case "ar":
                    languageSegmentControl.selectedSegmentIndex = 0
                    UIView.appearance().semanticContentAttribute = .forceRightToLeft
                case "en":
                   languageSegmentControl.selectedSegmentIndex = 1
                    UIView.appearance().semanticContentAttribute = .forceLeftToRight
                default:
                    let localLang =  Locale.current.languageCode
                     if localLang == "ar" {
                         languageSegmentControl.selectedSegmentIndex = 0
                     }else {
                         languageSegmentControl.selectedSegmentIndex = 1
                     }
                }
            }else {
                let localLang =  Locale.current.languageCode
                 if localLang == "ar" {
                     languageSegmentControl.selectedSegmentIndex = 0
                 }else {
                    languageSegmentControl.selectedSegmentIndex = 1
                 }
            }
        }
    }
 
    @IBOutlet weak var welcomeLabel: UILabel!{
    
    didSet {

        welcomeLabel.text = "Welcome".localized
    }
}
    @IBOutlet weak var signupButton: UIButton!{
        didSet{
            signupButton.setTitle("Sign Up".localized, for: .normal)
        }
    }
    
    @IBOutlet weak var signInButton: UIButton!{
        didSet{
          signInButton.setTitle("Sign In".localized, for: .normal)
        }
    }

    
    @IBAction func languageChanged(_ sender: Any) {
        if let lang = (sender as AnyObject).titleForSegment(at:(sender as AnyObject).selectedSegmentIndex)?.lowercased() {
            UserDefaults.standard.set(lang, forKey: "currentLanguage")
            Bundle.setLanguage(lang)
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = storyboard.instantiateInitialViewController()
            }
        }
    }
}
extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
//

