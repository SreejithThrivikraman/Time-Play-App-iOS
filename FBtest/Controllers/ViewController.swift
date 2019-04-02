//
//  ViewController.swift
//  FBtest
//
//  Created by robin on 2018-07-19.
//  Copyright © 2018 robin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewplay: UIButton!
    @IBOutlet weak var players: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //UI nonsense Setting for button
        //- this is for Players button
        players.layer.cornerRadius = 7
        players.layer.borderWidth = 1.5
        players.layer.borderColor = UIColor.blue.cgColor
        //- this is for Viewplay button
        viewplay.layer.cornerRadius = 7
        viewplay.layer.borderWidth = 1.5
        viewplay.layer.borderColor = UIColor.blue.cgColor
        // --- END UINONSENSE -----
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Players Click button
    @IBAction func PlayersAction(_ sender: UIButton) {
        //Go to next creen using Storyboard ID
        let PlayersCV = self.storyboard?.instantiateViewController(withIdentifier: "PlayersScreen")
        self.navigationController?.pushViewController(PlayersCV!, animated: true)
    }
    //ViewPlay Click button
    @IBAction func ViewPlayAction(_ sender: UIButton) {
        //Go to next creen using Storyboard ID
        let ViewCV = self.storyboard?.instantiateViewController(withIdentifier: "ViewPlayScreen")
        self.navigationController?.pushViewController(ViewCV!, animated: true)
    
        
    }
    
}

