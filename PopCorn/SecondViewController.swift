//
//  SecondViewController.swift
//  HelloProject
//
//  Created by 間瀬真 on 2019/09/20.
//  Copyright © 2019 間瀬真. All rights reserved.
//

import UIKit
import CoreLocation
import NCMB

class SecondViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var presentLocationLabel: UILabel!
    @IBOutlet weak var presentLocationLabel2: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var getPresentLabelButton: UIButton!
    @IBOutlet weak var stopPresentLocationButton: UIButton!
    @IBOutlet weak var backScreenButton: UIButton!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var contentText: UITextField!
    
    
    var pageText:String = "Present location"
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondLabel.text = pageText
    }
    @IBAction func backScreenAction(_ sender: Any) {
        self.performSegue(withIdentifier: "toBackFirst", sender: nil)
    }
    
    //get present location action.
    @IBAction func getPresentLocation(_ sender: Any) {
        setUpLocationManager()
    }
    
    @IBAction func stopLocationManager(_ sender: Any) {
        locationManager.stopUpdatingLocation()
        presentLocationLabel.text = ""
        presentLocationLabel2.text = ""
    }
    
    //setup location manager.
    func setUpLocationManager(){
        
        print("called setUp location manger")
        locationManager = CLLocationManager()
        guard let locationManager = locationManager else { return }
        locationManager.requestWhenInUseAuthorization()
        
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse {
            print("status == .authorizedWhenInUse")
            locationManager.distanceFilter = 10
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }else{
            print("status != .authorizedWhenInUse")
        }
    }
    
    //present location getter
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        
        print("latitude: \(latitude!)\nlongitude: \(longitude!)")
        presentLocationLabel.text = "latitude: \(latitude!)"
        presentLocationLabel2.text = "longitude: \(longitude!)"
    }

    @IBAction func pushNotification(_ sender: Any) {
        let title:String = titleText.text!
        let contents:String = contentText.text!
        
        let push = NCMBPush()
        
        let data_iOS = ["contentAvailable" : false, "badgeIncrementFlag" : false, "sound" : "default"] as [String : Any]
        push.setData(data_iOS)
        push.setPushToIOS(true)
        push.setTitle(title)
        push.setMessage(contents)
        push.setImmediateDeliveryFlag(true) // 即時配信
        push.sendInBackground { (error) in
            if error != nil {
                // プッシュ通知登録に失敗した場合の処理
                print("NG:\(error)")
            } else {
                // プッシュ通知登録に成功した場合の処理
                print("OK")
            }
        }
        
        func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            
            print("received push notice")
            // MARK: アプリが起動しているときに実行される処理を追記する場所

        }
        
    }
    
}
