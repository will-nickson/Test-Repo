//
//  LoginViewController.swift
//  SwiftFirestorePhotoAlbum
//
//  Created by Will Nickson on 12/07/2019.
//  Copyright © 2019 Alex Akrimpai. All rights reserved.
//

import UIKit
import FirebaseUI


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
    
        @IBAction func loginTapped(_ sender: Any) {
            
//        Get the default auth UI object
        
         let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil else {
            
//            Log the error
            
            return
            
        }
        
//        Set ourselves as the delegate
        
        authUI?.delegate = self
        
        authUI?.providers = [FUIEmailAuth()]
        
//        Get a reference to the auth UI view controller

        let authViewController = authUI!.authViewController()
        
//        Show it
        
        present(authViewController, animated: true, completion: nil)
        
    }


}


extension ViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?){
        
//        Check if there was an Error
        
        guard error == nil else {
            
//            Log the error
            
            return
            
        }
        
//        Access the user auth ID??
//        authDataResult?.user.uid
        
        performSegue(withIdentifier: "goHome", sender: self)
        
    }
    
}
