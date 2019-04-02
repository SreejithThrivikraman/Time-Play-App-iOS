//
//  WaitViewController.swift
//  FBtest
//
//  Created by levantuan on 2018-07-23.
//  Copyright © 2018 robin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class WaitViewController: UIViewController {
    
    var count = 10
    
    var getPin = String()
    var ref:DatabaseReference!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var textList: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //firebase
        self.ref = Database.database().reference()
        RecordDatabaseChanged()
        
        //end
        
        //countdown
        var timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(WaitViewController.update), userInfo: nil, repeats: true)
        
        
    }
    
    func RecordDatabaseChanged(){
            // Firebase
        self.ref.child("\(getPin)").observe(DataEventType.childAdded, with: {
            (snapshot) in

            
            //what you should do when something get added
            let getPlayers = snapshot.value as! String
            self.textList.text.append("\(getPlayers)")
            self.textList.text.append("\n")
            self.textList.text.append("\n")
            //end
            
            
            //UI Nonsense
            // -- Everytime values added (Animation: Automatically scroll down)
            let bottom = self.textList.contentSize.height - self.textList.bounds.size.height
            self.textList.setContentOffset(CGPoint(x: -1, y: bottom), animated: true)
            //end
        })
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.setNavigationBarHidden(false, animated: true)
        self.title = "PIN: \(getPin)"
        
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
    
    //countdown
    func update() {
    
            if(self.count > 0){
                let minutes = String(self.count / 60)
                let seconds = String(self.count % 60)
                self.countLabel.text = minutes + ":" + seconds
                count = count - 1
               
                
                if(self.count == 1)
                
                {
                    self.ref.child(getPin + "timer").child("time").setValue("1")
                    //Go to next creen using Storyboard ID
                    let PlayersCV = self.storyboard?.instantiateViewController(withIdentifier: "question01Screen")
                    self.navigationController?.pushViewController(PlayersCV!, animated: true)
                    
                }
                
            }
            1000;
        
    }
    

}
