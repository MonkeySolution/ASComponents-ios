//
//  ASBarButtonItemNode.swift
//  ASComponents
//
//  Created by Majid Hatami Aghdam on 5/5/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import AsyncDisplayKit

/*
public final class ASBarButtonItemNode: ASDisplayNode {
    public var switchView: UIBarButtonItem { return view as! UIBarButtonItem }
    public override init() {
        super.init()
        setViewBlock { () -> UIView in
            return UIBarButtonItem.init(image: <#T##UIImage?#>, style: <#T##UIBarButtonItem.Style#>, target: <#T##Any?#>, action: <#T##Selector?#>)
        }
    }
    
    public func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        SWKQueue.mainQueue().async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.switchView.addTarget(target, action: action, for: controlEvents)
        }
    }
    
    public var onTintColor:UIColor? {
        get {
            assert(Thread.isMainThread, "Getter must be called from the Main UI Thread only.")
            return self.switchView.onTintColor
        }
        set{
            SWKQueue.mainQueue().async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.switchView.onTintColor = newValue
            }
        }
    }
    
    public var thumbTintColor:UIColor? {
        get{
            assert(Thread.isMainThread, "Getter must be called from the Main UI Thread only.")
            return self.switchView.thumbTintColor
        }
        set{
            SWKQueue.mainQueue().async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.switchView.thumbTintColor = newValue
            }
        }
    }
    
    public var isOn:Bool {
        get {
            assert(Thread.isMainThread, "Getter must be called from the Main UI Thread only.")
            return self.switchView.isOn
        }
        set{
            SWKQueue.mainQueue().async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.switchView.isOn = newValue
            }
        }
    }
}

 */
