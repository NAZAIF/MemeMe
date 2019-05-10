//
//  MemeViewController.swift
//  MemeMe
//
//  Created by Moideen Nazaif VM on 28/04/19.
//  Copyright © 2019 Moideen Nazaif VM. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)

        setupTextFields(topTextField)
        setupTextFields(bottomTextField)
        
        subscribeToKeyboardNotifications()
    }
    
    func setupTextFields(_ textField: UITextField) {
        textField.defaultTextAttributes = memeTextAttributedString
        textField.textAlignment = .center
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unsubscribeToKeyboardNotification()
    }
    @IBAction func pickAnImage(_ sender: Any) {
        setUpPickerController(withSource: .photoLibrary)
    }
    
    func setUpPickerController(withSource imageSource: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = imageSource
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickFromCamera(_ sender: Any) {
        setUpPickerController(withSource: .camera)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = pickedImage
            imagePickerView.contentMode = .scaleAspectFit
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    let memeTextAttributedString : [NSAttributedString.Key : Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -5
    ]
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if topTextField.text == "" {
            topTextField.text = "TOP"
        }
        if bottomTextField.text == "" {
            bottomTextField.text = "BOTTOM"
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.text = (textField.text! as NSString).replacingCharacters(in: range, with: string.uppercased())

        return false
    }
    
    @objc func keyboardWillShow(_ notification:Notification){
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func generateMemedImage() -> UIImage {
        
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        
        return memedImage
    }
    
    func save() {
        _ = Memes.Meme(
            topText:self.topTextField.text!,
            bottomText: self.bottomTextField.text!,
            originalImage: self.imagePickerView.image!,
            memedImage: generateMemedImage())
    }
    
    @IBAction func Share(_ sender: Any) {
        let sharedImage = generateMemedImage()
        let activityController = UIActivityViewController(activityItems:    [sharedImage], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
        
        activityController.completionWithItemsHandler = { (activity, success, items, error) in
        self.save()
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        imagePickerView.image = nil
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        shareButton.isEnabled = false
    }
    
}

