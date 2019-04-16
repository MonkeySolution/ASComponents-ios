//
//  ASActivityIndicatorViewNode.swift
//  ASComponents
//
//  Created by Majid Hatami Aghdam on 4/15/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import AsyncDisplayKit

public final class ASActivityIndicatorViewNode: ASDisplayNode2 {
    
    var activityIndicatorView:UIActivityIndicatorView { return view as! UIActivityIndicatorView }
    
    public override init() {
        super.init()
        setViewBlock { () -> UIView in
            return UIActivityIndicatorView()
        }
        self.activityIndicatorView.startAnimating()
    }
    
    public func startAnimating(){
        SWKQueue.mainQueue().async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.activityIndicatorView.startAnimating()
        }
    }
    
    public func stopAnimating(){
        SWKQueue.mainQueue().async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.activityIndicatorView.stopAnimating()
        }
    }
    
    public var color: UIColor?{
        get{
            assert(Thread.isMainThread, "This method must be called on MainThread only")
            return self.activityIndicatorView.color
        }
        set{
            SWKQueue.mainQueue().async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.activityIndicatorView.color =  newValue
            }
        }
    }
    
    public override var tintColor: UIColor?{
        get{
            assert(Thread.isMainThread, "This method must be called on MainThread only")
            return self.activityIndicatorView.tintColor
        }
        set{
            SWKQueue.mainQueue().async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.activityIndicatorView.tintColor =  newValue
            }
        }
    }
    
    public override var backgroundColor: UIColor? {
        get{
            assert(Thread.isMainThread, "This method must be called on MainThread only")
            return self.activityIndicatorView.backgroundColor
        }
        set{
            SWKQueue.mainQueue().async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.activityIndicatorView.backgroundColor =  newValue
            }
        }
    }
}
