//
//  ViewPlayViewController.swift
//  FBtest
//
//  Created by levantuan on 2018-07-20.
//  Copyright © 2018 robin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewPlayViewController: UIViewController {

    @IBOutlet weak var confirm: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //firebase
        self.ref = Database.database().reference()
        //end

        //UI nonsense Setting for button
        //- this is for Players button
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.blue.cgColor
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
        if (textView.text!.isEmpty){
            
            let alert = UIAlertController(title: "Sorry", message: "The field is blank", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return false
            
        }
        else {
            //firebase
            self.ref.child("pin_number").child(textView.text!).setValue(textView.text!)
            
            self.ref.child(textView.text! + "timer").child("time").setValue("10")
            //end
            
            
            return true
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("yes, i am preparing for segue now")
     
            
        // Passing data using segue
        let dest = segue.destination as! WaitViewController
        dest.getPin = textView.text!
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
