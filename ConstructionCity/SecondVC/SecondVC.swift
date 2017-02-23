//
//  SecondVC.swift
//  ConstructionCity
//
//  Created by Apple on 17/01/17.
//  Copyright © 2017 ZetrixWeb. All rights reserved.
//

import UIKit

class SecondVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var lblDescription : UILabel!
    @IBOutlet weak var lblLeadtime    : UILabel!
    @IBOutlet weak var lblOrigin      : UILabel!
    @IBOutlet weak var lblFinish      : UILabel!
    @IBOutlet weak var lblSerialNo    : UILabel!
    @IBOutlet weak var collViewSecond2: UICollectionView!
    @IBOutlet weak var pageCntroller  : UIPageControl!
    @IBOutlet weak var collViewSecond : UICollectionView!
    
    var arrCollviewData = NSArray()
    var arrdata         = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // set Number of Pages
        pageCntroller.numberOfPages = arrCollviewData.count

        // Set Serial No
        if let serialNo = (arrdata[0] as! NSDictionary).value(forKey: "item_serial_no") {
            lblSerialNo.text  = String(describing: serialNo)
        }
        else{
           lblSerialNo.text  = "none"
        }
        // Set Finsh
        if let finish = (arrdata[0] as! NSDictionary).value(forKey: "item_finish") {
            lblFinish.text  = String(describing: finish)
        }else{
            lblFinish.text  = "none"
        }
        // Set Origin
        if let origin = (arrdata[0] as! NSDictionary).value(forKey: "item_place_of_origin") {
            lblOrigin.text  = String(describing: origin)
        }else{
            lblOrigin.text  = "none"
        }
        // Set Time
        if let time = (arrdata[0] as! NSDictionary).value(forKey: "item_lead_time") {
            lblLeadtime.text  = String(describing: time)
        }else{
           lblLeadtime.text  = "none"
        }
        // Set Description
        if let des = (arrdata[0] as! NSDictionary).value(forKey: "item_extra_description") {
            lblDescription.text  = String(describing: des)
        }else{
           lblDescription.text  = "none"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Scroll View Delegates
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // set Cuurent Page
        let pagewidth = collViewSecond.frame.size.width
        let currentPage = collViewSecond.contentOffset.x / pagewidth
        pageCntroller.currentPage = Int(currentPage)
    }
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(collectionView == collViewSecond){
          return arrCollviewData.count
        }
        else{
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == collViewSecond){
            
            let cell = collViewSecond.dequeueReusableCell(withReuseIdentifier: "SecondCCC1", for: indexPath) as! SecondCCC1
            let strURL = ((arrCollviewData[indexPath.row] as! NSDictionary).value(forKey: "secure_url") as! String?)!
   
            // Set image
            let url = URL(string: strURL)
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            cell.imgViewMain.image = UIImage(data: data!)
            return cell
        }
        else{
            let cell = collViewSecond2.dequeueReusableCell(withReuseIdentifier: "SecondCCC2", for: indexPath) as! SecondCCC2
            cell.imgViewMain.layer.cornerRadius = 50
            cell.imgViewMain.clipsToBounds = true
            return cell
        }   
    }

    
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == collViewSecond){
            
            return CGSize(width: self.collViewSecond.frame.size.width, height: self.collViewSecond.frame.size.height)
        }
        else{
            return CGSize(width:116, height: 136)
        }
    }

    @IBAction func btnBackClicked(_ sender: Any) {
        
       _ = self.navigationController?.popViewController(animated: true)
    }

}
