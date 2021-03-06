//
//  ViewController.swift
//  MemeMe
//
//  Created by Yuan Gao on 6/7/22.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {

    @IBOutlet weak var Toolbar: UIToolbar!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var imagePickView: UIImageView!
    @IBOutlet weak var TopTextField: UITextField!
    @IBOutlet weak var BottomTextField: UITextField!
    @IBOutlet weak var activity: UIButton!
    @IBOutlet weak var cancel: UIButton!
    
    /*
    struct Meme{
        let topText:String?
        let bottomText:String?
        let originalImage: UIImage?
        let memedImage: UIImage?
    }
    */
    let memeTextAttributes: [NSAttributedString.Key:Any] = [
        NSAttributedString.Key.strokeColor:UIColor.black,
        NSAttributedString.Key.foregroundColor:UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 60)!,
        NSAttributedString.Key.strokeWidth: -4
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toolbarSetup(isHidden: true)
        print("I am here")
        subscribeToKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        toolbarSetup(isHidden: false)
        unsubscribeFromKeyboardNotifications()
    }
    func toolbarSetup(isHidden:Bool){
        self.tabBarController?.tabBar.isHidden = isHidden
        self.navigationController?.navigationBar.isHidden = isHidden
    }
    func setupTextField(textFeild:UITextField){
        textFeild.delegate = self
        textFeild.defaultTextAttributes = memeTextAttributes
        textFeild.adjustsFontSizeToFitWidth = true
        textFeild.textAlignment = .center
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        setupTextField(textFeild: self.TopTextField)
        setupTextField(textFeild: self.BottomTextField)
        activity.isEnabled = false
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            imagePickView.image = image
        }
        
        print("image is selected")
        dismiss(animated: true)
        activity.isEnabled = true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    func setupImagePicker(imagPicker: UIImagePickerController, source:UIImagePickerController.SourceType){
        imagPicker.delegate = self
        imagPicker.sourceType = source
    }
    @IBAction func PickAnImage(_ sender: Any) {
        pickImage(dataSource: .photoLibrary)
    }
    @IBAction func PIckAnImageFromCameral(_ sender: Any) {

        pickImage(dataSource: .camera)
        
    }
    
    func pickImage(dataSource: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        setupImagePicker(imagPicker: imagePicker, source: dataSource)
        present(imagePicker,animated: true,completion: nil)
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if BottomTextField.isFirstResponder{
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if BottomTextField.isFirstResponder{
            view.frame.origin.y = CGFloat(0)
            
        }
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    
    func generateMemedImage() -> UIImage {

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return memedImage
    }
    
    func IsToolBarHidden(IsHidden: Bool){
        Toolbar.isHidden = IsHidden
        activity.isHidden = IsHidden
        cancel.isHidden = IsHidden
    }

    func save() {
        // Create the meme
        let meme = Meme(topText: TopTextField.text!, bottomText: BottomTextField.text!, originalImage: imagePickView.image!, memedImage: generateMemedImage())
        // Add it to the memes array in the Application Delegation
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        print("Meme appended")
        print(appDelegate.memes.count)
    }
    
    @IBAction func UIActivity(_ sender: Any) {
        IsToolBarHidden(IsHidden: true)
        let meme = Meme(topText: TopTextField.text, bottomText: BottomTextField.text, originalImage: imagePickView.image, memedImage: generateMemedImage())
        let image = meme.memedImage
        let controller = UIActivityViewController(activityItems: [image as Any], applicationActivities: nil)
        present(controller,animated: true,completion: nil)
        //self.save()
        
        controller.completionWithItemsHandler={_,complete,_,_ in
            if complete == true{
                self.save()
            }
            
            self.IsToolBarHidden(IsHidden: false)
        }
        
        
    }
    
    @IBAction func pressCancel(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}

