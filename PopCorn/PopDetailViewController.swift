//
//  PopDetailViewController.swift
//  HelloProject
//
//  Created by 間瀬真 on 2019/10/11.
//  Copyright © 2019 dev.service.pop. All rights reserved.
//

import UIKit

class PopDetailViewController: UIViewController {

    @IBOutlet weak var buttonShopName: UIButton!
    @IBOutlet weak var buttonUsePop: UIButton!
    @IBOutlet weak var labelPopTitle: UILabel!
    @IBOutlet weak var labelPopContents: UILabel!
    @IBOutlet weak var imagePop: UIImageView!
    @IBOutlet weak var buttonBack: UIButton!
    
    //var selPop = pop(popId:"",shopId:"",shopName:"",popTitle:"",popContents:"")
    var popId = ""
    var shopId = ""
    var shopName = ""
    var popTitle = ""
    var popContents = ""
    //var expire:Date
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonShopName.setTitle(shopName, for: .normal)
        labelPopTitle.text = popTitle
        labelPopContents.text = popContents
        
        settingStyle()
    }
    

    @IBAction func showShopInfo(_ sender: Any) {
    }
    
    @IBAction func backPopList(_ sender: Any) {
        
        performSegue(withIdentifier: "backTopopList",sender: nil)
    }
    @IBAction func showModalUsePop(_ sender: Any) {
        
        performSegue(withIdentifier: "popDetailToUseModal",sender: nil)
    }
    
    func settingStyle(){
        view.backgroundColor = UIColor(hex: "F5F7F7")
        labelPopTitle.textColor =  UIColor(hex: "080808")
        labelPopContents.textColor = UIColor(hex: "080808")
        
        buttonUsePop.backgroundColor = UIColor(hex: "92C1F0")
        buttonUsePop.setTitleColor(UIColor(hex: "080808"),for: .normal)
        buttonUsePop.layer.cornerRadius = 5.0
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
