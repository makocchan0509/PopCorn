//
//  PopListViewController.swift
//  HelloProject
//
//  Created by 間瀬真 on 2019/10/07.
//  Copyright © 2019 dev.service.pop. All rights reserved.
//

import UIKit

class PopListViewController: UIViewController,UICollectionViewDataSource,
UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var labelLogo: UILabel!
    
    @IBOutlet weak var labelFixtext: UILabel!
    @IBOutlet weak var labelDescConf: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    struct pop{
        let popId:String
        let shopId:String
        let shopName:String
        let popTitle:String
        let popContents:String
        //let expire:Date
    }
    
    var pops = [pop]()
    
    func setUpData(){
        
            //Dummy pops
        pops.append(pop(popId:"p1",shopId:"s0001",shopName:"居酒屋 喜太郎",popTitle:"生ビール一杯無料",popContents:"初回注文の生ビールが無料になります。お1人様1注文"))
        pops.append(pop(popId:"p2",shopId:"s0002",shopName:"ピッツァリアBorcano",popTitle:"アンティパスト20%OFF",popContents:"アンティパスト全品20%OFF!"))
        pops.append(pop(popId:"p3",shopId:"s0003",shopName:"鮮魚わだち",popTitle:"しらすかけ放題",popContents:"出汁巻き卵を注文いただくとしらすかけ放題です。しかも700円！"))
        pops.append(pop(popId:"p4",shopId:"s0004",shopName:"巌流島 宮本武蔵",popTitle:"先着10組限定 会計時10%OFF",popContents:"来店時先着10組様限定で会計時10%になります"))
        pops.append(pop(popId:"p5",shopId:"s0005",shopName:"スペインの闘牛士",popTitle:"牛一頭プレゼント",popContents:"牛一頭プレゼントします"))
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create dummy data.
        setUpData();
        settingStyle();
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = UIColor(hex: "F5F7F7")
        // レイアウトを調整
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //layout.itemSize = CGSize(width:355,height:145)
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: CGRect(x: 9, y: 140, width: 355, height: 600), collectionViewLayout: layout)
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pops.count;
        //return 100;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let popCell:UICollectionViewCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "popCell",
                                               for: indexPath)
        
        //imageViewインスタンスの生成
        //let imageView = popCell.contentView.viewWithTag(1) as! UIImageView

        //Labelインスタンスの生成
        let labelShopName = popCell.contentView.viewWithTag(2) as! UILabel
        labelShopName.text = pops[indexPath.row].shopName
//        print("pops[\(indexPath.row)].shopName >-- \(pops[indexPath.row].shopName)")
        labelShopName.textColor = UIColor(hex: "080808")

        let labelTitle = popCell.contentView.viewWithTag(3) as! UILabel
        labelTitle.text = pops[indexPath.row].popTitle
//        print("pops[\(indexPath.row)].popTitle >-- \(pops[indexPath.row].shopName)")
        labelTitle.textColor = UIColor(hex: "080808")
        
        //CollectionStyle
        popCell.backgroundColor = UIColor(hex: "DEEAF7")
        
        return popCell;
    }
    
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize{
    
        let cellWidth = 356
        let cellHeight = 144
        
//        print("cellWidth >-- \(cellWidth)")
//        print("cellHeight >-- \(cellHeight)")
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
       // Cell が選択された場合
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        performSegue(withIdentifier: "popListTodetail",sender: indexPath.row)
       
    }
    
       // Segue 準備
       override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
            var selectCell: Int!
            selectCell = (sender as! Int)
            // 選択されたクーポン情報を取得
            let popDetailVC: PopDetailViewController = (segue.destination as? PopDetailViewController)!
        
            popDetailVC.popId = pops[selectCell].popId
            popDetailVC.shopId = pops[selectCell].shopId
            popDetailVC.shopName = pops[selectCell].shopName
            popDetailVC.popTitle = pops[selectCell].popTitle
            popDetailVC.popContents = pops[selectCell].popContents
            
       }
    
    func settingStyle(){
        //view
        view.backgroundColor = UIColor(hex: "F5F7F7")
        labelLogo.textColor = UIColor(hex: "080808")
        labelFixtext.textColor = UIColor(hex: "080808")
        labelDescConf.textColor = UIColor(hex: "080808")
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
