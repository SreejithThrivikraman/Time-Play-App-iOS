//
//  leaderBoard.swift
//  FBtest
//
//  Created by Sreejith Thrivikraman on 2018-08-01.
//  Copyright © 2018 robin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class leaderBoard: UIViewController {
    
    
    @IBOutlet weak var board: UITextView!
    
    let score_ref = Database.database().reference().child("LeaderBoard")

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        board.text = ""

        // Do any additional setup after loading the view.
        
         score_ref.observeSingleEvent(of: .value, with: { (snapshot_option) in
            
            for option in (snapshot_option.children.allObjects as? [DataSnapshot])!
                // for option in (snapshot_option.children.allObjects as? [DataSnapshot])!
                
            {
                var name  = option.key;
                var score:String = option.value as! String;
                
                if(name == "Player_Name")
                {
                    self.board.text = "Pooling results...."
                }
                else
                {
                    self.board.text = name + " : " + score + "\n"
                }
                
                
                
                
            }
            
        })
        
        
        
    }

    override func didReceiveMemoryWarning()
    {
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

}
