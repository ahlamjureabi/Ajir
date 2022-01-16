//
//  Sign Up ViewController.swift
//  Ajir App
//
//  Created by Ahlam Ahlam on 23/05/1443 AH.
//

import UIKit
import Firebase
class Sign_Up_ViewController: UIViewController {
    var selectdata:[User] = []
    var selectDataPost:[Post] = []
    let imagePickerController = UIImagePickerController()
    var activityIndicator = UIActivityIndicatorView()
    @IBOutlet weak var userImageView: UIImageView! {
        didSet {
            userImageView.layer.borderColor = UIColor.systemGreen.cgColor
            userImageView.layer.borderWidth = 3.0
            userImageView.layer.cornerRadius = userImageView.bounds.height / 2
            userImageView.layer.masksToBounds = true
            userImageView.isUserInteractionEnabled = true
            let tabGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
            userImageView.addGestureRecognizer(tabGesture)
        }
    }
    
    
    @IBOutlet weak var eyeOne: UIButton!
    
    
    @IBOutlet weak var eyeTwo: UIButton!
    
    
    
//    @IBOutlet weak var eyeOne: UITextField!
//
//    @IBOutlet weak var eyeTwo: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var usernamelabel: UILabel!{
    didSet {

        usernamelabel.text = "username".localized
    }
}
    @IBOutlet weak var emailLabel: UILabel!{
        
        didSet {

           emailLabel.text = "E-mail".localized
        }
    }
    @IBOutlet weak var passwordLabel: UILabel!{
        
        didSet {

           passwordLabel.text = "Password".localized
        }
    }
    @IBOutlet weak var confremPasswordLabel: UILabel!{
        didSet {

            confremPasswordLabel.text = "Confrem Password".localized
        }
    }
    @IBOutlet weak var sinupButton: UIButton! {
        didSet{
            sinupButton.setTitle("Sign Up".localized, for: .normal)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))

        passwordTextField.rightView = eyeOne
        passwordTextField.rightViewMode = .whileEditing
       
        confirmPasswordTextField.rightView = eyeTwo
        confirmPasswordTextField.rightViewMode = .whileEditing
//        youView.layer.masksToBounds = false
//       youView.layer.shadowOffset = CGSize(width: -3, height: 3)
//        youView.layer.shadowRadius = 2.5
//        youView.layer.shadowOpacity = 3.5
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changePasswordVisibility(_ sender: AnyObject){
        passwordTextField.isSecureTextEntry.toggle()
        if  passwordTextField.isSecureTextEntry {
            if let image = UIImage(systemName: "eye.fill") {
                sender.setImage(image, for: .normal)
            }
        } else {
            if let image = UIImage(systemName: "eye.slash.fill") {
                sender.setImage(image, for: .normal)
            }
        }
    }
    @IBAction func eyePasswordConfrem(_ sender: AnyObject) {
        confirmPasswordTextField.isSecureTextEntry.toggle()
        if  confirmPasswordTextField.isSecureTextEntry {
            if let image = UIImage(systemName: "eye.fill") {
                sender.setImage(image, for: .normal)
            }
        } else {
            if let image = UIImage(systemName: "eye.slash.fill") {
                sender.setImage(image, for: .normal)
            }
        }
    }
    
    @IBAction func handleRegister(_ sender: UIButton) {

        
        if let image = userImageView.image,
           let imageData = image.jpegData(compressionQuality: 0.75),
           let name = nameTextField.text,
           let email = emailTextField.text,
           let password = passwordTextField.text,
           let confirmPassword = confirmPasswordTextField.text,
           password == confirmPassword {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    Alert.showAlert(strTitle: "Error", strMessage: error.localizedDescription, viewController: self)
                  Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                    print("Registration Auth Error",error.localizedDescription)
                }
                if let authResult = authResult {
                    let storageRef = Storage.storage().reference(withPath: "users/\(authResult.user.uid)")
                    let uploadMeta = StorageMetadata.init()
                    uploadMeta.contentType = "image/jpeg"
                    storageRef.putData(imageData, metadata: uploadMeta) { storageMeta, error in
                        if let error = error {
                      Alert.showAlert(strTitle: "Error", strMessage: error.localizedDescription, viewController: self)
                        Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                            print("Registration Storage Error",error.localizedDescription)
                        }
                        storageRef.downloadURL { url, error in
                            if let error = error {
                                Alert.showAlert(strTitle: "Error", strMessage: error.localizedDescription, viewController: self)
                                  Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                                print("Registration Storage Download Url Error",error.localizedDescription)
                            }
                            if let url = url {
                                print("URL",url.absoluteString)
                                let db = Firestore.firestore()
                                let userData: [String:String] = [
                                    "id":authResult.user.uid,
                                    "name":name,
                                    "email":email,
                                    "imageUrl":url.absoluteString
                                ]
                                db.collection("users").document(authResult.user.uid).setData(userData) { error in
                                    if let error = error {
                                        print("Registration Database error",error.localizedDescription)
                                    }else {
                                        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "goTo") as? UINavigationController {
                                            vc.modalPresentationStyle = .fullScreen
                                            Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                                            self.present(vc, animated: true, completion: nil)
                    
                                            
                               
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
//        if nameTextField.isAccessibilityElement == true
//            {
//            handleRegister()
//
//            }
        
        
    }
    
}



extension Sign_Up_ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @objc func selectImage() {
        showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "choose Profile Picture", message: "where do you want to pick your image from?", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { Action in
            self.getImage(from: .camera)
        }
        let galaryAction = UIAlertAction(title: "photo Album", style: .default) { Action in
            self.getImage(from: .photoLibrary)
        }
        let dismissAction = UIAlertAction(title: "Cancle", style: .destructive) { Action in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cameraAction)
        alert.addAction(galaryAction)
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
    }
    func getImage( from sourceType: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return}
        userImageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
