//
//  Question01ViewController.swift
//  FBtest
//
//  Created by levantuan on 2018-07-24.
//  Copyright © 2018 robin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class Question01ViewController: UIViewController {

    @IBOutlet weak var timer_label: UILabel!
    
   
    @IBOutlet weak var question_Plate: UITextView!
    @IBOutlet weak var option_a: UILabel!
    @IBOutlet weak var option_B: UILabel!
    @IBOutlet weak var option_C: UILabel!
    @IBOutlet weak var option_D: UILabel!
    
    
    var ref:DatabaseReference!
    var count = 10
    var question = ""
    var index = 0;
    var questions: [String] = []
    var seconds = 10;
    
    var options_A:[Any] = []
    var options_B:[Any] = []
    var options_C:[Any] = []
    var options_D:[Any] = []
    var count_timer = 10;
    var timer_time = Timer()
    var previousNumber: Int?
    
    
    //var questions = Array<String>(repeating: 0, count: 10)
    var limit = 0;
    var number = 0;
    var a : [DataSnapshot] = []
    
    var option_list = [options]()                      // array of options for questions in options class
    
    @IBOutlet weak var question_plate: UITextView!
    
    let parentRef = Database.database().reference().child("questions")
    let option_ref = Database.database().reference().child("Answers")
    
    
    
    override func viewDidLoad()
    
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.ref = Database.database().reference()
        self.ref.child("status").setValue("open")
        
        //end
        
        // Firebase
       
            //end
     
        
        question_plate.text = ""
        
        var timer = Timer.scheduledTimer(timeInterval: 12.0, target: self, selector: #selector(Question01ViewController.update), userInfo: nil, repeats: true)
        print(">>>>>>>>>>>>>>>>>>>>>>",timer)
        
        
        pull_questions_from_DB()
    
      
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func  pull_questions_from_DB()
    {
        
        parentRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
           // print(snapshot)
           print("limit =", snapshot.childrenCount)
            
           for rest in snapshot.children.allObjects as! [DataSnapshot]
           {
            //print(self.index)
            //self.questions[self.index] = rest.value! as! String
            self.questions.append(rest.value! as! String)
            
           }
            
            
            self.limit = Int(snapshot.childrenCount);
        
        })
        
        
        
        option_ref.observeSingleEvent(of: .value, with: { (snapshot_option) in

            for option in (snapshot_option.children.allObjects as? [DataSnapshot])!
           // for option in (snapshot_option.children.allObjects as? [DataSnapshot])!
                
            {

                
                self.options_A.append(option.childSnapshot(forPath: "A").value!   )
                self.options_B.append(option.childSnapshot(forPath: "B").value! )
                self.options_C.append(option.childSnapshot(forPath: "C").value! )
                self.options_D.append(option.childSnapshot(forPath: "D").value! )

               
            }
            
        })
        

    
    }
   
    //countdownv
    func update()
    
    {
        
        count_timer = 10
        timer_time.invalidate()
        
        number = Int(arc4random_uniform(UInt32(limit)))
        
        self.ref.child("current").setValue(number + 1)
        
        
        
        // the below logic was used to prevent back-to-back repetition.
        if (previousNumber == number)
        {
            number = Int(arc4random_uniform(UInt32(limit)))
        }
        else
        {
            previousNumber = number
        }
        
        
        print(self.options_A[number])
        print(self.options_B[number])
        print(self.options_C[number])
        print(self.options_D[number])
        
        if(self.count > 0)
        {
            print("count = " , count)
            
            
            
            
            
            
            question_Plate.text = questions[number]
            option_a.text = self.options_A[number] as? String
            option_B.text = self.options_B[number] as? String
            option_C.text = self.options_C[number] as? String
            option_D.text = self.options_D[number] as? String
            
             timer_time = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(Question01ViewController.time_update), userInfo: nil, repeats: true)
            
            
            // clearing current question
            //self.ref.child("current").setValue("X")
            count = count - 1
            
            
            
 
        1000;
   
        }
        
        
        // game finished and moving to next screen
        
        if (self.count == 0)
        {
            // closing the game.
            self.ref.child("status").setValue("closed")
            
            let PlayersCV = self.storyboard?.instantiateViewController(withIdentifier: "leaderBoardScreen")
            self.navigationController?.pushViewController(PlayersCV!, animated: true)
        }
        
    }
    
    func time_update()
    {
        
        let minutes = String(self.count_timer / 60)
        let seconds = String(self.count_timer % 60)
        self.timer_label.text = minutes + ":" + seconds
        count_timer = count_timer - 1
        
        if(count_timer == 0)
        {
            count_timer = 10;
       
        }
      
    }
    
   
    
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


