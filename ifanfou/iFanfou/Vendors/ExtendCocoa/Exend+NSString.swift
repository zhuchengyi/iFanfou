//
//  Exend+NSString.swift
//  GTMobile
//
//  Created by tung on 16/2/24.
//  Copyright © 2016年 GT. All rights reserved.
//

import Foundation

extension NSString{
    class func getSource(obj:String)->String{
        let source = obj
        // <a href="sinaweibo://customweibosource" rel="nofollow">iPhone 5siPhone 5s</a>
        var textRegex :NSRegularExpression?
        
        if textRegex == nil {
            do {
                try textRegex = NSRegularExpression(pattern: "(?<=>).+(?=<)", options: NSRegularExpressionOptions.AllowCommentsAndWhitespace)
            }catch{}
        }
        
        var lText :String?
        let textResult = textRegex!.firstMatchInString(source , options: NSMatchingOptions.init(rawValue: 0), range: NSMakeRange(0, source.startIndex.distanceTo(source.endIndex)))
        if  textResult != nil && textResult?.range.location != NSNotFound
        {
            let textRange = Range(start: source.startIndex.advancedBy(textResult!.range.location), end: source.startIndex.advancedBy(textResult!.range.location + textResult!.range.length))
            lText = source.substringWithRange(textRange)
        }
        if lText==nil {lText = "网页"}
        return lText!
    }
    
    class func getText(obj:AnyObject)->String{
        var source = obj.valueForKeyPath("text") as! String
        var textRegex :NSRegularExpression?
        if  textRegex == nil {
            do {
                try textRegex = NSRegularExpression(pattern: "<a[^>]+>([^<]+)</a>", options: NSRegularExpressionOptions.AllowCommentsAndWhitespace)
            }catch{}
        }
        
        var lArray:[String]=[]
        textRegex?.enumerateMatchesInString(source, options: NSMatchingOptions.init(rawValue: 0), range: NSMakeRange(0,source.startIndex.distanceTo(source.endIndex))) {
            textResult, flags, stop in
            let textRange = Range(start: source.startIndex.advancedBy(textResult!.range.location), end: source.startIndex.advancedBy(textResult!.range.location + textResult!.range.length))
            let tempText = source.substringWithRange(textRange)
            lArray.append(tempText);
        }
        
        for item in lArray {
            let temp = getSource(item)
            source = source.stringByReplacingOccurrencesOfString(item, withString: temp)
        }
        
        return source
    }
}

extension NSObject {
    // create a static method to get a swift class for a string name
    class func ClassFromString(className: String) -> AnyClass! {
        // get the project name
        if  let appName: String? = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String? {
            // generate the full name of your class (take a look into your "YourProject-swift.h" file)
            let classStringName = appName! + "." + className
            // return the class!
            let name = NSClassFromString(classStringName)
            return name
        }
        return nil;
    }
}