//
//  ModalUsePopViewController.swift
//  HelloProject
//
//  Created by 間瀬真 on 2019/10/13.
//  Copyright © 2019 dev.service.pop. All rights reserved.
//

import UIKit

class ModalUsePopViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var viewPopModal: UIView!
    @IBOutlet weak var labelModalTitle: UILabel!
    @IBOutlet weak var textPopCode: UITextField!
    @IBOutlet weak var buttonUsePop: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    
    var activityIndicatorView = UIActivityIndicatorView()
    
    var labelComp = UILabel(frame: CGRect(x: 185, y: 430, width: 0, height: 0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textPopCode.delegate = self
        settingStyle()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func usePop(_ sender: Any) {
        
        buttonUsePop.isHidden = true
        buttonCancel.isHidden = true
        activityIndicatorView.startAnimating()

        DispatchQueue.global(qos: .default).async {
            // 非同期処理などを実行
            Thread.sleep(forTimeInterval: 3)
            
            // 非同期処理などが終了したらメインスレッドでアニメーション終了
            DispatchQueue.main.sync {
                // アニメーション終了
                self.activityIndicatorView.stopAnimating()
                //完了Labelの表示
                self.view.addSubview(self.labelComp)
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    @IBAction func closeModal(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    func settingStyle(){
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        viewPopModal.backgroundColor = UIColor(hex: "dcdcdc")
        viewPopModal.layer.cornerRadius = 5.0
        
        textPopCode.delegate = self
        textPopCode.textColor = UIColor(hex: "080808")
        textPopCode.backgroundColor = UIColor(hex: "F5F7F7")
        
        activityIndicatorView.center = view.center
        activityIndicatorView.style = UIActivityIndicatorView.Style.large
        activityIndicatorView.color = .blue
        view.addSubview(activityIndicatorView)
        
        labelModalTitle.textColor =  UIColor(hex: "080808")

        labelComp.text = "完了"
        labelComp.font = UIFont.systemFont(ofSize: 25)
        labelComp.textColor = UIColor.black
        labelComp.sizeToFit()
        
        buttonUsePop.backgroundColor = UIColor(hex: "92C1F0")
        buttonUsePop.setTitleColor(UIColor(hex: "080808"),for: .normal)
        buttonUsePop.layer.cornerRadius = 5.0
        
        buttonCancel.backgroundColor = UIColor(hex: "C0C0C0")
        buttonCancel.setTitleColor(UIColor(hex: "080808"),for: .normal)
        buttonCancel.layer.cornerRadius = 5.0
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textPopCode.resignFirstResponder()
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
