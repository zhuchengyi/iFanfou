//
//  BaseTableViewDelegate.swift
//  GTMobile
//
//  Created by tung on 16/1/12.
//  Copyright © 2016年 GT. All rights reserved.
//
import UIKit

@objc protocol BaseTableViewDelegate{
    
    optional func tableViewDidScroll(tableView:UITableView!)
    
    optional func tableViewHttpLoadSuccess(tableView:UITableView!,json:AnyObject!)-> [AnyObject]
    
    optional func tableViewNumberOfSections(tableView: UITableView!)-> Int
    
    optional func tableViewNumberOfRowsInSection(tableView: UITableView!,section: Int)-> Int
    
    optional func tableViewHeightForRowAtIndexPath(tableView: UITableView!,indexPath: NSIndexPath!,dict:AnyObject!)-> CGFloat
    
    optional func tableViewCellForRowAtIndexPath(tableView: UITableView!,indexPath: NSIndexPath!,dict:AnyObject!) -> UITableViewCell!
    
    optional func tableViewDidSelectRowAtIndexPath(tableView: UITableView!,indexPath: NSIndexPath!,dict:AnyObject!)
}
