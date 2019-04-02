//
//  game_completed.swift
//  FBtest
//
//  Created by Sreejith Thrivikraman on 2018-08-02.
//  Copyright © 2018 robin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class game_completed: UIViewController {
    
    
    var ref:DatabaseReference!

    let Ref = Database.database().reference().child("LeaderBoard")
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func remove_data(_ sender: Any)
    {
        var userName = UserDefaults.standard.string(forKey: "user_name")
        Ref.child(userName!).removeValue();
    }
    
}
