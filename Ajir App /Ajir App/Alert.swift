//
//  Alert.swift
//  Ajir App
//
//  Created by Ahlam Ahlam on 29/05/1443 AH.
//

import Foundation
import UIKit
struct Alert{

    static func showAlert(strTitle: String, strMessage: String, viewController: UIViewController) {
        let myAlert = UIAlertController(title: strTitle, message: strMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        myAlert.addAction(okAction)
        viewController.present(myAlert, animated: true, completion: nil)
    }
}