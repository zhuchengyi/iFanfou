//
//  ZYTabBar.swift
//  GTMobile
//
//  Created by 张宇 on 16/1/20.
//  Copyright © 2016年 GT. All rights reserved.
//

import UIKit

protocol ZYTabBarDelegate: NSObjectProtocol
{
    func tabBarDidClickFromIndexToIndex(tabBar:ZYTabBar, oldIndex: Int, newIndex: Int)
}

class ZYTabBar: UIView {
    
    // 存放tabBarItem的数组
    var itemsArray:Array<ZYTabBarItem>? = []
    // 当前选中的tabBarItem
    var selTabBarItem: ZYTabBarItem?
    weak var delegate: ZYTabBarDelegate?
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = UIColor.whiteColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func addOneTabBarItem(icon:String!, selIcon:String!, title:String!){
        let tabBarItem = ZYTabBarItem()
        tabBarItem.setImage(UIImage(named: icon), forState: UIControlState.Normal)
        tabBarItem.setImage(UIImage(named: selIcon), forState: UIControlState.Selected)
        tabBarItem.setTitle(title, forState: UIControlState.Normal)
        tabBarItem.addTarget(self, action: "tabBarItemDidClick:", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(tabBarItem)
        itemsArray? += [tabBarItem]
        tabBarItem.tag = ((itemsArray?.count)! - 1)
        if tabBarItem.tag == 0 {
            tabBarItem.selected = true
            selTabBarItem = tabBarItem
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print(itemsArray?.count)
        if (itemsArray != nil) {
            let buttonY = CGFloat(0.0)
            let buttonW = frame.size.width/CGFloat((itemsArray?.count)!)
            let buttonH = frame.size.height
            for var i = 0; i < itemsArray?.count; i++
            {
                let buttonX = buttonW * CGFloat(i)
                let tabBarItem = itemsArray![i]
                print(tabBarItem.tag)
                tabBarItem.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
            }
        }
        //添加分割线
        let line = UIView()
        line.frame = CGRect(x: 0, y: 0, width: KScreenWidth, height: 0.5)
        line.backgroundColor = UIColor.lightGrayColor()
        line.alpha = 0.1
        addSubview(line)
    }
    
    func tabBarItemDidClick(tabBarItem: ZYTabBarItem){
        // 1.代理传值
        delegate?.tabBarDidClickFromIndexToIndex(self, oldIndex: selTabBarItem!.tag, newIndex: tabBarItem.tag)
        // 2.按钮状态切换
        selTabBarItem?.selected = false
        tabBarItem.selected = true
        selTabBarItem = tabBarItem
    }
}
