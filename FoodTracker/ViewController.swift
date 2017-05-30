//
//  ViewController.swift
//  FoodTracker
//
//  Created by Jacqueline on 30.05.17.
//  Copyright © 2017 Jacky's Code Factory. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    //Mark: Properties
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //handle the text field's user input through delegate callbacks
        nameTextField.delegate = self
    }
    
    
    //Mark: UITextFieldDelegate
    //Mark: Actions
    
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        
        mealNameLabel.text = "Default Text"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //hides the keyboard
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text
    }
    
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //hide the keyboard
        nameTextField.resignFirstResponder()
        
        //UIImagePickerController is a view Controller that lets a user pick media from their photo library
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present (imagePickerController, animated: true, completion: nil)
    }
    
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //dismiss the picker if the user canceled
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //the info dictionary may ontain multiple representations of the image. You want to use the original
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as?
            UIImage else{
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        //set photoImageView to display the selected image
        photoImageView.image = selectedImage
        
        //dismiss the picker
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
}

