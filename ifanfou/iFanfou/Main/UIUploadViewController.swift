//
//  UIUploadViewController.swift
//  GTMobile
//
//  Created by tung on 16/2/25.
//  Copyright © 2016年 GT. All rights reserved.
//

import UIKit
import PhotosUI

class UIUploadViewController: BaseViewController {
    
    var actionSheet:ZLPhotoActionSheet?
    
    internal var repostStatusId:String = ""
    
    internal var repostStatusString:String = ""
    
    var gViewPhoto: UIImageView = UIImageView ()
    
    @IBOutlet weak var gViewText: UITextView!
    @IBOutlet weak var gViewTextContent: UIView!
    @IBOutlet weak var gViewImageBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        setNavBarButton(NAV.LEFT, string:"取消")
        setNavBarButton(NAV.RIGHT, string:"发送")
        setNavTitle("饭一下")
        
        actionSheet = ZLPhotoActionSheet()
        actionSheet!.maxSelectCount = 1
        actionSheet!.maxPreviewCount = 20
        
        //self.automaticallyAdjustsScrollViewInsets = false
        gViewTextContent.layer.borderColor = UIColor.lightGrayColor().CGColor
        gViewTextContent.layer.cornerRadius = 5
        gViewTextContent.layer.borderWidth = 0.5
        
        if !repostStatusId.isEmpty{
            gViewText.text = repostStatusString
            gViewText.selectedRange=NSMakeRange(0,0) ;   //起始位置
        }
        gViewText.becomeFirstResponder()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        gViewText.resignFirstResponder()
        self.view.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func photoClick(sender: AnyObject) {
        weak var weakSelf = self
        actionSheet?.showWithSender(self, animate: true, completion: { (selectPhotos) -> Void in
            if selectPhotos.isEmpty {
                weakSelf?.gViewPhoto.image = nil
                weakSelf?.gViewImageBtn.setBackgroundImage(UIImage(named: "add_p.png"), forState: UIControlState.Normal)
            }else{
                weakSelf?.gViewPhoto.image = selectPhotos.first as? UIImage
                weakSelf?.gViewImageBtn.setBackgroundImage(selectPhotos.first as? UIImage, forState: UIControlState.Normal)
            }
        })
    }
    
    
    override func rightButtonTouch(){
        if let image = gViewPhoto.image {
            let text = gViewText.text
            HttpUpload(KURLAppUpLoadWithImage, parameter: ["photo":image,"status":text])
        }
        else if let text = gViewText.text {
           HttpUpload(KURLAppUpLoad, parameter: ["status":text])
        }
    }
    
    override func httpRequestSsuccess(url: String,data:NSDictionary,status:HTTPStatus){
        if let img = data["id"]{
            tprint(img)
            let alertView = UIAlertView()
            alertView.title = "系统提示"
            alertView.message = "发布成功"
            alertView.addButtonWithTitle("确定")
            alertView.cancelButtonIndex=0
            alertView.show()
            navigationController?.popViewControllerAnimated(true)
        }
        if  let error = data["error"]{
            tprint(error)
            let alertView = UIAlertView()
            alertView.title = "系统提示"
            alertView.message = error as? String
            alertView.addButtonWithTitle("确定")
            alertView.cancelButtonIndex=0
            alertView.show()
        }
    }

}
