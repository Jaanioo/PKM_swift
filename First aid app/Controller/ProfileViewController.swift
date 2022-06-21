//
//  ProfileViewController.swift
//  First aid app
//
//  Created by Jan Paleń on 20/05/2022.
//

import UIKit
import FirebaseStorage
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var testsResultsButton: UIButton!
    
    private let storage = Storage.storage().reference()
    let userEmail = Auth.auth().currentUser?.email
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadingProfileImage()
        loadingNickName()
        setPopupButton()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
        profileImageView.clipsToBounds = true
        
        
    }
    
    func setPopupButton() {
        
        let optionPortionClosure = {(action: UIAction) in
            print(action.title)
            if action.title == "Ciśnienie krwi" {
                self.performSegue(withIdentifier: "PressureSegue2", sender: self)
            } else if action.title == "Cukier" {
                self.performSegue(withIdentifier: "SugarSegue2", sender: self)
            }
        }
        
        testsResultsButton.menu = UIMenu(children : [
            UIAction(title: "Ciśnienie krwi", state: .off, handler: optionPortionClosure),
            UIAction(title: "Cukier", handler: optionPortionClosure)])
        
        testsResultsButton.showsMenuAsPrimaryAction = true
        testsResultsButton.changesSelectionAsPrimaryAction = true
        testsResultsButton.setTitleColor(UIColor.clear, for: .normal)
        
    }
    
    //MARK: - loading image
    func loadingProfileImage() {
        
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
              let url =  URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.profileImageView.image = image
            }
        }
        task.resume()
        print(urlString)
    }
    
    //MARK: - loading nickname
    func loadingNickName() {
        
        profileNameLabel.text = userEmail
    }
    
    //MARK: - buttons
    
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        try! Auth.auth().signOut()

        let viewControllers: [UIViewController] = self.navigationController!.viewControllers ;
        for aViewController in viewControllers {
            if(aViewController is ViewController){
               self.navigationController!.popToViewController(aViewController, animated: true);
            }
        }
    }
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers ;
        for aViewController in viewControllers {
            if(aViewController is LoggedMainViewController){
               self.navigationController!.popToViewController(aViewController, animated: true);
            }
        }
    }
    
    @IBAction func changeImageButtonPressed(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
        
        print("UZYTKOWNIK TO \(String(describing: Auth.auth().currentUser?.email))")
    }
    
    @IBAction func changingPasswordButtonPressed(_ sender: UIButton) {
        
        UIView.transition(with: changePasswordView, duration: 0.5,
          options: [.transitionFlipFromBottom],
          animations: {
            self.changePasswordView.alpha = 1
            self.changePasswordView.isHidden = false
          })
    }
    
    @IBAction func changePasswordButtonPressed(_ sender: UIButton) {
        
        if newPasswordTextField.text != "" {
            
        Auth.auth().currentUser?.updatePassword(to: newPasswordTextField.text!) { error in
            if let e = error {
                
                let alert = UIAlertController(title: "Błąd", message: "Wstąpił błąd w zmianie hasła", preferredStyle: .alert)
                print("Błąd: \(e.localizedDescription)")
                alert.addAction(UIAlertAction(title: "Zamknij", style: .default, handler: nil))
            } else {
                
                UIView.transition(with: self.changePasswordView, duration: 0.5,
                  options: [.transitionFlipFromTop],
                  animations: {
                    self.changePasswordView.alpha = 0
                    self.changePasswordView.isHidden = true
                  })
            }
        }} else {
            //do nothing
        }
    }
    
    @IBAction func closeChangingPasswordPressed(_ sender: UIButton) {
        
        UIView.transition(with: self.changePasswordView, duration: 0.5,
          options: [.transitionFlipFromTop],
          animations: {
            self.changePasswordView.alpha = 0
            self.changePasswordView.isHidden = true
          })
    }
}

//MARK: - extension image picker
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        guard let imageData = image.pngData() else {
            return
        }
        
        storage.child("profile image/currenct image.png").putData(imageData, metadata: nil) { _, error in
            guard error == nil else {
                print("Failed to upload image.")
                return
            }
            self.storage.child("profile image/current image.png").downloadURL { url, error in
                guard let url = url, error == nil else {
                    return
                }
                let urlString = url.absoluteString
                
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
                
                print("Download URL: \(urlString)")
                UserDefaults.standard.set(urlString, forKey: "url")
            }
            
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
