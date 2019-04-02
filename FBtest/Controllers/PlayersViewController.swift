//
//  PlayersViewController.swift
//  FBtest
//
//  Created by levantuan on 2018-07-20.
//  Copyright © 2018 robin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class PlayersViewController: UIViewController {

    @IBOutlet weak var playertxt: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var confirm: UIButton!
    
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //firebase
        self.ref = Database.database().reference()
        //end
        
        //UI nonsense Setting for button
        //- this is for pin number txt
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.blue.cgColor
        //- this is for pin player name txt
        playertxt.layer.cornerRadius = 5
        playertxt.layer.borderWidth = 1
        playertxt.layer.borderColor = UIColor.blue.cgColor
        //- this is for confirm button
        confirm.layer.cornerRadius = 5
        confirm.layer.borderWidth = 1
        confirm.layer.borderColor = UIColor.green.cgColor

        // --- END UINONSENSE -----
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //segue handling(checking)
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        //check if fileds are empty
        if ((textView.text!.isEmpty) || (playertxt.text!.isEmpty)){
            
            let alert = UIAlertController(title: "Sorry", message: "The field is blank", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        return false
            
        }
        else {
            //firebase
            print("Confirm clicked")
        self.ref.child(self.textView.text!).childByAutoId().setValue(playertxt.text!)
            //end
            return true
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("yes, i am preparing for segue now")
        
        
        // Passing data using segue
        let dest = segue.destination as! GotInViewController
        dest.getName = self.playertxt.text!
        dest.getPin = self.textView.text!
        print(textView.text!)
        //end

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
