//
//  GameViewController.swift
//  GameController
//
//  Created by Sze Zhien Lee on 05/07/2017.
//  Copyright © 2017 Sze Zhien Lee. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var deletebutton: UIButton!
    @IBOutlet weak var addupdatebutton: UIButton!
    @IBOutlet weak var titleTextView: UITextField!
    @IBOutlet weak var gameImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    var game : Game? = nil
    
    @IBAction func PhotoTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        gameImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera        
        present(imagePicker, animated: true, completion: nil)

    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        if game != nil {
            game!.title = titleTextView.text
            game!.image = UIImagePNGRepresentation(gameImageView.image!)! as NSData
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let game = Game(context: context)
            game.title = titleTextView.text
            game.image = UIImagePNGRepresentation(gameImageView.image!)! as NSData
               // the original text does not have ! asNSData
                    }
        
     
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
        navigationController?.popViewController(animated: true)
    }
    

    @IBAction func deleteTapped(_ sender: Any) {
       let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(game!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController?.popViewController(animated: true)

        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        // Do any additional setup after loading the view.
        
        if game != nil {
        gameImageView.image = UIImage(data: game!.image! as Data)
                titleTextView.text = game!.title
            //The video use titleTextField
            
            addupdatebutton.setTitle("Update", for: .normal)
        } else {
            deletebutton.isHidden = true
        }
    }
    
    
}
