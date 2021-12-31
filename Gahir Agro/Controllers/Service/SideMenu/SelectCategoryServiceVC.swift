//
//  SelectCategoryServiceVC.swift
//  Gahir Agro
//
//  Created by Dharmani Apps on 22/11/21.
//

import UIKit
import Foundation
import LGSideMenuController
import SDWebImage

class SelectCategoryServiceVC: UIViewController,LGSideMenuDelegate
{
    @IBOutlet weak var allCatgryCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var currentPage = 0
    var messgae = String()
    var page = 1
    var catArray = [CatgData]()
    var categoryArray = [CatgeoryData]()
    var lastPage = String()
    var catImages = ["TMCH","LEVALER SMALL","SPRAY PUMP2","REAPER SMALL","MUD LOADER","SUPER SEEDER","SYS TILE2"]
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startTimer()
        configreUI()
    }
    
    func configreUI(){
        allCatgryCollectionView.delegate = self
        allCatgryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        self.catArray.append(CatgData(name: "Harvester", image: "TMCH"))
        self.catArray.append(CatgData(name: "Leveller", image: "LEVALER SMALL"))
        self.catArray.append(CatgData(name: "Spray Pump", image: "SPRAY PUMP2"))
        self.catArray.append(CatgData(name: "Straw Reaper", image: "REAPER SMALL"))
        self.catArray.append(CatgData(name: "Mud Loader", image: "MUD LOADER"))
        self.catArray.append(CatgData(name: "Super Seeder", image: "SUPER SEEDER"))
        
        self.categoryArray.append(CatgeoryData(image: "HARVESTER"))
        self.categoryArray.append(CatgeoryData(image: "LEVALER"))
        self.categoryArray.append(CatgeoryData(image: "Reaper"))
        self.categoryArray.append(CatgeoryData(image: "SELF COMBINE"))
        self.categoryArray.append(CatgeoryData(image: "SPRAY PUMP"))
        self.categoryArray.append(CatgeoryData(image: "SUPER SEADER"))
    }
    
    func applyShadowOnView(_ view: UIView) {
        view.layer.cornerRadius = 5
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
    }

    func startTimer() {

        let timer =  Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }

    @objc func scrollAutomatically(_ timer1: Timer) {

        if let coll = categoryCollectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)! < catImages.count - 1){
                    let indexPath1: IndexPath?
                
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)

                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }

            }
        }
    }
    
    func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
    @IBAction func menuBtn(_ sender: UIButton) {
        sideMenuController?.showLeftViewAnimated()
    }
    
    @IBAction func searchBtn(_ sender: UIButton) {
        
    }
    

}
extension SelectCategoryServiceVC : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            self.pageControl.numberOfPages = categoryArray.count
            return categoryArray.count
        }else{
            return catArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCollectionCell", for: indexPath) as! categoryCollectionCell
           // cell.categryImg.sd_setShowActivityIndicatorView(true)
//            if #available(iOS 13.0, *) {
//                cell.categryImg.sd_setIndicatorStyle(.large)
//        }else {
//            // Fallback on earlier versions
//        }
//        cell.categryImg.sd_setImage(with: URL(string: catArray[indexPath.item].image), placeholderImage: UIImage(named: ""), options: SDWebImageOptions.continueInBackground, completed: nil)
            cell.categryImg?.image = UIImage(named: categoryArray[indexPath.item].image)
        applyShadowOnView(cell.contentView)
        self.pageControl.numberOfPages = categoryArray.count
        return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subCategoryCollectionCell", for: indexPath) as! subCategoryCollectionCell
//            cell.subCatImage.sd_setShowActivityIndicatorView(true)
            if #available(iOS 13.0, *) {
//                cell.subCatImage.sd_setIndicatorStyle(.large)
            } else {
                // Fallback on earlier versions
            }
            cell.categoryView.backgroundColor = getRandomColor()
            applyShadowOnView(cell.contentView)
            cell.subLabel.text = catArray[indexPath.item].name
            cell.subCatImage.image = UIImage(named: catArray[indexPath.item].image)
            return cell
        }

}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == categoryCollectionView {
            return 0.0
        }else {
            return 15.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == categoryCollectionView{
            return 0.0
        }else{
            return 15.0
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let pageWidth = scrollView.frame.width
        self.currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        self.pageControl.currentPage = self.currentPage
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == categoryCollectionView{
            let cellWidth : CGFloat = collectionView.frame.width*4/4
            
            let numberOfCells = floor(collectionView.frame.width / cellWidth)
            let edgeInsets = (collectionView.frame.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)
            
            return UIEdgeInsets(top: 0, left: edgeInsets, bottom: 0, right: edgeInsets)
        }else{
            let cellWidth : CGFloat = collectionView.frame.width*4/9 + 5
            
            let numberOfCells = floor(collectionView.frame.width / cellWidth)
            let edgeInsets = (collectionView.frame.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)
            
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView{
            return CGSize(width: collectionView.frame.width*4/4, height: collectionView.frame.height)
        }else{
            
            let noOfCellsInRow = 2
            
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
            
            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
            
            return CGSize(width: size, height: size)
        }
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if indexPath.item == 0 {
//            let story = UIStoryboard(name: "Service", bundle: nil)
//            let rootViewController:UIViewController = story.instantiateViewController(withIdentifier: "CustomerVC")
//            self.navigationController?.pushViewController(rootViewController, animated: true)
//        }else {
//            let story = UIStoryboard(name: "Service", bundle: nil)
//            let rootViewController:UIViewController = story.instantiateViewController(withIdentifier: "RegisterProductVC")
//            self.navigationController?.pushViewController(rootViewController, animated: true)
//            
//        }
//    }

}

struct CatgData {
    
    var name : String
    var image : String
 
    init(name: String, image: String) {
        self.name = name
        self.image = image
      
    }
}

struct CatgeoryData {
    
    var image : String
 
    init( image: String) {
        self.image = image
      
    }
}

