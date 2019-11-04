//
//  ViewController.swift
//  HelloProject
//
//  Created by 間瀬真 on 2019/09/19.
//  Copyright © 2019 間瀬真. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var testTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingStyle()
        // Do any additional setup after loading the view.
    }

    @IBAction func testButton(_ sender: Any) {
//        let inputText:String = testTextField.text!
//        testLabel.text = inputText
//        print(inputText)
        self.performSegue(withIdentifier: "topTologin", sender: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toSecond" {
//            let nextVC = segue.destination as! SecondViewController
//
//        }
//    }
    
    // setting UI color.
    func settingStyle(){
        
        //view
        view.backgroundColor = UIColor(hex: "F5F7F7")
        
        //label
        labelTitle.textColor = UIColor(hex: "080808")
        
        //button
        startButton.backgroundColor = UIColor(hex: "92C1F0")
        startButton.setTitleColor(UIColor(hex: "080808"),for: .normal)
        //startButton.titleColor(UIColor(hex: "080808"),for: .normal)
        startButton.layer.cornerRadius = 5.0
    }
}
