//
//  GotInViewController.swift
//  FBtest
//
//  Created by levantuan on 2018-07-23.
//  Copyright © 2018 robin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class GotInViewController: UIViewController {
    var getPin = String()
    var getName = String()
    var ref:DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //firebase
        self.ref = Database.database().reference()
        //end
        
        print("The user name is : ",getName)
        UserDefaults.standard.set(getName, forKey: "user_name")
        
        RecordDatabaseChanged()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    
    {
        //display Players in central of navi
        self.navigationController!.setNavigationBarHidden(false, animated: true)
        self.title = "Name: \(getName)"
    

        
    }

    override func didReceiveMemoryWarning()
    
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func RecordDatabaseChanged()
    
    {
        // Firebase
        self.ref.child(getPin + "timer").observe(DataEventType.childChanged, with: {
            (snapshot) in
            
            let username = snapshot.value as! String
            
            print("\(username)")
            
            //Handling
            if (("\(username)") == "1"){
                print("it is exist")
                //Go to next creen using Storyboard ID
                
                print("moving to net screen")
                let QT01CV = self.storyboard?.instantiateViewController(withIdentifier: "QT01Screen")
                self.navigationController?.pushViewController(QT01CV!, animated: true)
            }
            
            
            else{
                
                return
            }//end
            
            
            
        })
    }//end func
    
   
   

}
