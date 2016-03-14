//
//  UIMediaViewController.swift
//  TRSMobile
//
//  Created by tung on 16/2/18.
//  Copyright © 2016年 trs. All rights reserved.
//

import UIKit

class UIMediaViewController: BaseViewController,BaseTableViewDelegate {
    
    var gWMPlayer = WMPlayer()
    
    var gViewContent = BaseTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavBarButton(NAV.LEFT, string:"")
        setNavBarButton(NAV.RIGHT, string:"")
        setNavTitle("视听")
        
        //gViewContent.gTableUrl = KURLAppMedia
        gViewContent.delegate = self;
        gViewContent.gTableCellName = "UIMediaCellView"
        gViewContent.view.frame = CGRectMake(0,0,KScreenWidth,KScreenHeight)
        self.view .addSubview(gViewContent.view)
        addChildViewController(gViewContent)
    }
    
    func tableViewHttpLoadSuccess(tableView:UITableView!,json:AnyObject!)-> [AnyObject]{
       return json["videoList"] as! [AnyObject]
    }
    

    func tableViewDidSelectRowAtIndexPath(tableView: UITableView!,indexPath: NSIndexPath!,dict:AnyObject!){
        let controller = VMDetailViewController()
        controller.URLString = dict["mp4_url"] as? String
        controller.title = dict["title"] as? String
        pushViewController(controller,animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
