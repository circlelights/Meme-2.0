//
//  ViewController.swift
//  Meme 1.0
//
//  Created by Developer2017 on 1/17/17.
//  Copyright © 2017 Developer2017. All rights reserved.
//

import UIKit



class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var bottom: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var top: UITextField!
    let imagePicker = UIImagePickerController()
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -2.0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField(textField: top)
        configureTextField(textField: bottom)
        top.text = "TOP"
        bottom.text = "BOTTOM"
    }
    
    func configureTextField(textField: UITextField) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.delegate = self
        textField.textAlignment = .center
    }
    

    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable( .camera)
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.subscribeToKeyboardNotifications()
    }
    
    func presentImagePickerWith(sourceType: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    //Connect this to the ALBUM button
    @IBAction func pickAnImage(_ sender: Any) {
        presentImagePickerWith(sourceType: .photoLibrary)
    }
    
    //Connect this to the CAMERA button
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        presentImagePickerWith(sourceType: .camera)
    }
    
    //Cancel Button
    @IBAction func cancelMeme(_ sender: Any) {
        bottom.text = "BOTTOM"
        top.text = "TOP"
        imagePickerView.image = nil
    }
    
    
    //Two Delegate Methods for UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            imagePickerView.contentMode = UIViewContentMode.scaleAspectFit
        dismiss(animated: true, completion: nil)
    }
    }
    
    
    func generateMemedImage() -> UIImage {

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return memeImage
    }
    
    func saveMeme(memedImage: UIImage) {
        // Create the meme
        _ = Meme(topString: top.text!, bottomString: bottom.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
    }
    
    @IBAction func shareMemeButtonPressed(sender: UIBarButtonItem) {
        
        let memedImage = self.generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
        activityViewController.completionWithItemsHandler = { (_, successful, _, _) in
            if successful {
                self.saveMeme(memedImage: memedImage)
            }
        }
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.frame.origin.y = 0
        return true
    }
    
    //Move the view so that the textfield is not obscured
    func keyboardWillShow(_ notification:Notification) {
        if bottom.isEditing == true {
            self.view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }   else {
            self.view.frame.origin.y = 0
        }
    }
    
    func keyboardWillHide(_ notification:Notification) {
        self.view.frame.origin.y = 0
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }

    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }

}

