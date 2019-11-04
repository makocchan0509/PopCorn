//
//  loginViewController.swift
//  HelloProject
//
//  Created by 間瀬真 on 2019/10/04.
//  Copyright © 2019 dev.service.pop. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var textFlogin: UITextField!
    @IBOutlet weak var textFpass: UITextField!
    @IBOutlet weak var btnExeLogin: UIButton!
    
    @IBOutlet weak var labelExpl: UILabel!
    @IBOutlet weak var labelId: UILabel!
    @IBOutlet weak var labelPass: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFlogin.delegate = self
        textFpass.delegate = self
        
        settingStyle()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func execLogin(_ sender: Any) {
        //let inputId:String = textFlogin.text!
        //let inputPass:String = textFpass.text!
        
        //本来はログインAPI呼び出し
        self.performSegue(withIdentifier: "loginTotab", sender: nil)
        
    }
    
    // setting UI style.
    func settingStyle(){
        
        //view
        view.backgroundColor = UIColor(hex: "F5F7F7")
        
        //label
        labelExpl.textColor = UIColor(hex: "080808")
        labelId.textColor=UIColor(hex: "080808")
        labelPass.textColor=UIColor(hex: "080808")
        
        //textField
        textFlogin.textColor = UIColor(hex: "080808")
        textFpass.textColor = UIColor(hex: "080808")
        textFpass.isSecureTextEntry = true
        
        //button
        btnExeLogin.backgroundColor = UIColor(hex: "92C1F0")
        btnExeLogin.setTitleColor(UIColor(hex: "080808"),for: .normal)
        btnExeLogin.layer.cornerRadius = 5.0

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField.tag {
        case 0:
            // タグが0ならsecondTextFieldにフォーカスを当てる
            textFpass.becomeFirstResponder()
            break
        case 1:
            // タグが1ならキーボードを閉じる
            textFpass.resignFirstResponder()
            break
        default:
            break
        }
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
