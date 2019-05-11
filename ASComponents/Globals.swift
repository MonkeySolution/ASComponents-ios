//
//  Globals.swift
//  ASComponents
//
//  Created by Majid Hatami Aghdam on 4/15/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

internal let DeviceColorSpace:CGColorSpace = CGColorSpaceCreateDeviceRGB()
internal let ScreenDeviceScale:CGFloat = UIScreen.main.scale
internal let UIScreenPixel:CGFloat = 1.0 / ScreenDeviceScale



func LOGI(_ params:String="", function:NSString = #function, file:NSString = #file, line:Int = #line){
    print("🔵[\(file.lastPathComponent)][\(function) (l:\(line))]->\(params)");
}
func LOGD(_ params:String="", function:NSString = #function,  file:NSString = #file, line:Int = #line){
    print("✅[\(file.lastPathComponent)][\(function) (l:\(line))]->\(params)");
}

func LOGW(_ params:String="", file:NSString = #file, function:NSString = #function, line:Int = #line){
    print("⚠️[\(file.lastPathComponent)][\(function) (l:\(line))]->\(params)");
}
func LOGE(_ params:String?, file:NSString = #file, function:NSString = #function, line:Int = #line){
    print("⛔️[\(file.lastPathComponent)][\(function) (l:\(line))]->\(params ?? "")");
}
