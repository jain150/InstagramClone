//
//  CaptureViewController.swift
//  Instagram
//
//  Created by Arnav Jain on 3/20/17.
//  Copyright © 2017 Arnav Jain. All rights reserved.
//

import UIKit
import Parse

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate {
    
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()


        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.barTintColor = UIColor(red:83/255, green: 127/255 , blue: 164/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func onClickToCam(_ sender: Any) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
//    func resize(_ image: UIImage, newSize: CGSize) -> UIImage {
//        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
//        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
//        resizeImageView.image = image
//        
//        UIGraphicsBeginImageContext(resizeImageView.frame.size)
//        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return newImage!
//    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        if(editedImage != nil) {
            print("Image selected!")
            selectedImage.image = editedImage
            
        }
        else {
            print("Image couldn't be selected..")
        }
        
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onClickCamRoll(_ sender: Any) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func onPostClicked(_ sender: Any) {
        
        if(selectedImage.image == nil) {
            
            //Show Alert
            let alert = UIAlertController(title: "Add an Image", message: "Cannot post without adding an image", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        
        }
        
        if (captionField.text == "") {
            
            //Show Alert
            let alert = UIAlertController(title: "Add a caption", message: "Cannot post without adding a caption", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        //Sending to Parse
        Post.postUserImage(image: selectedImage.image, withCaption: captionField.text) { (success: Bool, error: Error?) in
            if success {
                print("Posted to Parse!")
            }
            else {
                print(error?.localizedDescription)
            }
        }
        
        //Routing to Home
        self.performSegue(withIdentifier: "postSegue", sender: nil)
        
        
            
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
