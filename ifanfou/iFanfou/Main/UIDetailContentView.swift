//
//  UIDetailContentView.swift
//  GTMobile
//
//  Created by tung on 16/3/2.
//  Copyright © 2016年 GT. All rights reserved.
//

import UIKit

class UIDetailContentView: BaseView {

    override func initCellView() {
        let view = FanFouCellView.viewWithXib() as! FanFouCellView
        view.gDict = gDict
        self.addSubview(view)
        view.frame = CGRectMake(0, 0, KScreenWidth,0)
        view.h = view.contentView.autoHeight()+5
        view.frame = CGRectMake(0, 0, KScreenWidth, view.h)
        self.frame = CGRectMake(0, 0, KScreenWidth, view.h)
        let image  =  gDict.valueForKeyPath("photo.largeurl")
        if  (image !== nil) {
           let imageView  = UIImageView()
            imageView.kf_setImageWithURL(NSURL(string: image as! String)!, placeholderImage: nil, optionsInfo: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
                if (image?.size.width <= KScreenWidth){
                    imageView.frame = CGRectMake(0, view.h+2, (image?.size.width)!, (image?.size.height)!)
                }else{
                    imageView.frame = CGRectMake(0, view.h+2, KScreenWidth, (image?.size.height)!*KScreenWidth/(image?.size.width)!)
                }
            })
            self.addSubview(imageView)
            self.frame = CGRectMake(0, 0, KScreenWidth, view.h + imageView.h)
        }
    }
    
    
}
