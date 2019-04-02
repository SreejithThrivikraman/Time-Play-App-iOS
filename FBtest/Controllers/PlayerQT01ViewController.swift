//
//  PlayerQT01ViewController.swift
//  FBtest
//
//  Created by levantuan on 2018-07-24.
//  Copyright © 2018 robin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase



class PlayerQT01ViewController: UIViewController,saved_data

{
    var count = 12
    
    
    @IBOutlet weak var Abtn: UIButton!
    
    @IBOutlet weak var Bbtn: UIButton!
    
    @IBOutlet weak var Cbtn: UIButton!
    
    
    @IBOutlet weak var Dbtn: UIButton!
    func didFetchData(data: [String])
    {
        
        print("did called")
        
      
            correct_answer_array = data;
        print(correct_answer_array.count)
        
    }
    

    
    @IBOutlet weak var current_question: UILabel!
    @IBOutlet weak var lblQuestion: UILabel!

    
    
    var ref:DatabaseReference!
    var correct_answer_array = [String]()
    var temp = 20
    var current_question_no = ""
    var array_info  = 0
    var array_info_constant:NSNumber = 1
    var correct_ans = ""
    var player_score = 0;
  
    
    let correct_ans_ref = Database.database().reference().child("Answers")
    let current_question_ref = Database.database().reference().child("current")
    let game_status = Database.database().reference().child("status")
    
    var game_status_func = Timer()
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        Abtn.isHidden = true
        Bbtn.isHidden = true
        Cbtn.isHidden = true
        Dbtn.isHidden = true
     
        
        
    
        // Do any additional setup after loading the view.
        
        //firebase
         self.ref = Database.database().reference()
       
        //countdown
        var timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(Question01ViewController.update), userInfo: nil, repeats: true)
        
        // downloading correct answers
        download_correct_answers()
        
       //
        
        
        
       game_status_func = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(PlayerQT01ViewController.RecordDatabaseChanged), userInfo: nil, repeats: true)
        
       
    }

    override func didReceiveMemoryWarning()
    
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // function to download the correct answers.
    func download_correct_answers( )
   
    {
        
        
        correct_ans_ref.observeSingleEvent(of: .value, with: { (snapshot_correct) in
            
            
            for c_answer in (snapshot_correct.children.allObjects as? [DataSnapshot])!
               
                
            {
            
                self.correct_answer_array.append(c_answer.childSnapshot(forPath: "correct").value! as! String)
         
            }
            
            
            
        })
        
        
        current_question_ref.observe(.value, with:{
            (snapshot_current) in


//            //what you should do when something get added
//           //print(snapshot_current.value! as! NSNumber)
//            //var right_value: NSNumber = snapshot_current.value! + 1
//            self.array_info = ((snapshot_current.value!)  as! NSNumber).intValue
//            self.array_info = self.array_info - 1
//            self.current_question_no = "\((snapshot_current.value!) as! NSNumber)"
//
//           // print("database data = ",snapshot_current.value)
//            self.current_question.text  = self.current_question_no as? String
        
           
            
            self.array_info = ((snapshot_current.value!)  as! NSNumber).intValue
            self.array_info = self.array_info - 1
            
            //self.current_question_no = "\((snapshot_current.value!) as! NSNumber)"
            
            // print("database data = ",snapshot_current.value)
            //self.current_question.text  = self.current_question_no as? String
            
            self.correct_ans = self.correct_answer_array[self.array_info as! Int]
            
//            print("Question no = ", self.array_info + 1)
//            print("the real answer = ", self.correct_ans)
            print("question no:",snapshot_current.value!)
            
            


        })
        
        
        
      
    
    }
    func update() {
        
        if(self.count > 0){
//            let minutes = String(self.count / 60)
//            let seconds = String(self.count % 60)
//            self.timeLabel.text = minutes + ":" + seconds
            count = count - 1
            //if do not picks answer will disapear
            if(count == 2){
                Abtn.isHidden = true
                Bbtn.isHidden = true
                Cbtn.isHidden = true
                Dbtn.isHidden = true
            }
            if(count == 1){
                Abtn.isHidden = false
                Bbtn.isHidden = false
                Cbtn.isHidden = false
                Dbtn.isHidden = false
                Abtn.isUserInteractionEnabled = true
                Bbtn.isUserInteractionEnabled = true
                Cbtn.isUserInteractionEnabled = true
                Dbtn.isUserInteractionEnabled = true
//
               
            }
            if(count == 0)
            {
                count = 12;
                
            }

                
            }
        1000;
    }
    
    // check game status
    func RecordDatabaseChanged()
    
    {
        game_status.observe(.value, with:{
            (snapshot_status) in
        
            var status = ""
            status = ((snapshot_status.value!)  as! String)
            
            if(status == "closed")
            {
                self.game_status_func.invalidate()
                
                // code to insert child to FB.
                var getName = UserDefaults.standard.string(forKey: "user_name")
                self.ref.child("LeaderBoard").child(getName!).setValue("\(self.player_score)")
                
                
                
               
                
                let PlayersCV = self.storyboard?.instantiateViewController(withIdentifier: "game_complete")
                self.navigationController?.pushViewController(PlayersCV!, animated: true)
            }
            else
            {
                self.game_status_func.invalidate()
            }
            
            
            
            
        })
   
    }
    
    
    func display()
    {
//        print("display : ",self.correct_answer_array)
//        print("data",current_question_no)
//
//        print("real array number = ",array_info as! Int)
//        print("correct answer = ",correct_answer_array[array_info as! Int])
        
    }
    
    // when option A is pressed
    @IBAction func option_A_isPressed(_ sender: Any)
    {
//        current_question_ref.observe(.value, with:{
//            (snapshot_current) in
//
//
//            //what you should do when something get added
//            //print(snapshot_current.value! as! NSNumber)
//            //var right_value: NSNumber = snapshot_current.value! + 1
//            self.array_info = ((snapshot_current.value!)  as! NSNumber).intValue
//            self.array_info = self.array_info - 1
//            self.current_question_no = "\((snapshot_current.value!) as! NSNumber)"
//
//            // print("database data = ",snapshot_current.value)
//            self.current_question.text  = self.current_question_no as? String
//
//
//
//
//
//        })
            print("A is pressed")
            //validate_answer()
            print("check ans A = ",self.correct_ans )
            if(self.correct_ans == "A")
            {
                print("Correct Answer !!!")
                self.player_score = self.player_score  + 1
                current_question.text = "\(self.player_score)"
            }
            else {
                print("Wrong !!!")
            }
        
       
        Bbtn.isHidden = true
        Cbtn.isHidden = true
        Dbtn.isHidden = true
        Abtn.isUserInteractionEnabled = false
        
        
        
        
        
        
    }
    
    // when option B is pressed
    @IBAction func option_B_isPressed(_ sender: Any)
    {
//        current_question_ref.observe(.value, with:{
//            (snapshot_current) in
//
//
//            //what you should do when something get added
//            //print(snapshot_current.value! as! NSNumber)
//            //var right_value: NSNumber = snapshot_current.value! + 1
//            self.array_info = ((snapshot_current.value!)  as! NSNumber).intValue
//            self.array_info = self.array_info - 1
//            self.current_question_no = "\((snapshot_current.value!) as! NSNumber)"
//
//            // print("database data = ",snapshot_current.value)
//            self.current_question.text  = self.current_question_no as? String
//
//
//
//
//
//        })

            print("B is pressed")
           // validate_answer()
            print("check ans B = ",self.correct_ans )
            if(self.correct_ans == "B")
            {
                print("Correct Answer !!!")
                self.player_score = self.player_score  + 1
                current_question.text = "\(self.player_score)"
                Bbtn.isHidden = true
            }
            else
            {
                print("Wrong !!!")
            }
        
        
        Dbtn.isHidden = true
        Abtn.isHidden = true
        Cbtn.isHidden = true
        
        Bbtn.isUserInteractionEnabled = false
        
      
    }
    
    // when option C is pressed
    @IBAction func option_C_isPressed(_ sender: Any)
    {
//        current_question_ref.observe(.value, with:{
//            (snapshot_current) in
//
//
//            //what you should do when something get added
//            //print(snapshot_current.value! as! NSNumber)
//            //var right_value: NSNumber = snapshot_current.value! + 1
//            self.array_info = ((snapshot_current.value!)  as! NSNumber).intValue
//            self.array_info = self.array_info - 1
//            self.current_question_no = "\((snapshot_current.value!) as! NSNumber)"
//
//            // print("database data = ",snapshot_current.value)
//            self.current_question.text  = self.current_question_no as? String
//
//
//
//
//
//        })
            print("C is pressed")
            //validate_answer()
        print("check ans C = ",self.correct_ans )
        if(self.correct_ans == "C")
        {
            print("Correct Answer !!!")
            self.player_score = self.player_score  + 1
            current_question.text = "\(self.player_score)"
            Cbtn.isHidden = true
        }
        else {
            print("Wrong !!!")
        }
        Bbtn.isHidden = true
        Dbtn.isHidden = true
        Abtn.isHidden = true
        Cbtn.isUserInteractionEnabled = false
        
        
        
    }
    
    // when option D is pressed
    @IBAction func option_D_isPressed(_ sender: Any)
    {
//        current_question_ref.observe(.value, with:{
//            (snapshot_current) in
//
//
//            //what you should do when something get added
//            //print(snapshot_current.value! as! NSNumber)
//            //var right_value: NSNumber = snapshot_current.value! + 1
//            self.array_info = ((snapshot_current.value!)  as! NSNumber).intValue
//            self.array_info = self.array_info - 1
//            self.current_question_no = "\((snapshot_current.value!) as! NSNumber)"
//
//            // print("database data = ",snapshot_current.value)
//            self.current_question.text  = self.current_question_no as? String
//
//
//
//
//
//        })
        
            print("D is pressed")
            print("check ans D = ",self.correct_ans )
            if(self.correct_ans == "D")
                {
                    print("Correct Answer !!!")
                    self.player_score = self.player_score  + 1
                    current_question.text = "\(self.player_score)"
                    Dbtn.isHidden = true
                }
            else {
                    print("Wrong !!!")
                 }
        Bbtn.isHidden = true
        Abtn.isHidden = true
        Cbtn.isHidden = true
        Dbtn.isUserInteractionEnabled = false
        
            //validate_answer()
    }
    
    
    
    func validate_answer() -> String
    {
        
        
        current_question_ref.observe(.value, with:{
            (snapshot_current) in
            
            
            
            self.array_info = ((snapshot_current.value!)  as! NSNumber).intValue
            self.array_info = self.array_info - 1
            
            //self.current_question_no = "\((snapshot_current.value!) as! NSNumber)"
            
            // print("database data = ",snapshot_current.value)
            //self.current_question.text  = self.current_question_no as? String
            
            self.correct_ans = self.correct_answer_array[self.array_info as! Int]
            
            print("Question no = ", self.array_info + 1)
            print("the real answer = ", self.correct_ans)
        
       })
        
    return (correct_ans)
        
    
    
    
   }
}
