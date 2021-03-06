//
//  BaseActionManager.swift
//  GTMobile
//
//  Created by tung on 16/1/19.
//  Copyright © 2016年 GT. All rights reserved.
//

import UIKit
import JavaScriptCore

class BaseActionManager: JSContext {
    override init(){
        super.init()
        
        
        self.exceptionHandler = { context, exception in
            print("JS Error: \(exception)")
        }
    }
    
    override init(virtualMachine: JSVirtualMachine!) {
        super.init(virtualMachine:virtualMachine)
    }

}
