//
//  UIProgressViewNode.swift
//  GixUI
//
//  Created by Majid Hatami Aghdam on 4/6/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import Foundation
import AsyncDisplayKit

public final class ASProgressViewNode:ASDisplayNode2 {
    public var progressView: UIProgressView { return view as! UIProgressView }
    public override init() {
        super.init()
        setViewBlock { () -> UIView in
            return UIProgressView()
        }
    }
    
    public var progress:Float{
        get{
            assert(Thread.isMainThread, "Getter must be called from the Main UI Thread only.")
            return self.progressView.progress
        }
        set{
            SWKQueue.mainQueue().async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.progressView.progress = newValue
            }
        }
    }
    
    public override var tintColor:UIColor?{
        get{
            assert(Thread.isMainThread, "Getter must be called from the Main UI Thread only.")
            return self.progressView.tintColor
        }
        set{
            SWKQueue.mainQueue().async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.progressView.tintColor = newValue
            }
        }
    }
    
    public var trackTintColor:UIColor?{
        get{
            assert(Thread.isMainThread, "Getter must be called from the Main UI Thread only.")
            return self.progressView.trackTintColor
        }
        set{
            SWKQueue.mainQueue().async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.progressView.trackTintColor = newValue
            }
        }
    }
    
    public var progressTintColor:UIColor?{
        get{
            assert(Thread.isMainThread, "Getter must be called from the Main UI Thread only.")
            return self.progressView.progressTintColor
        }
        set{
            SWKQueue.mainQueue().async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.progressView.progressTintColor = newValue
            }
        }
    }
    
    public var progressViewStyle:UIProgressView.Style{
        get{
            assert(Thread.isMainThread, "Getter must be called from the Main UI Thread only.")
            return self.progressView.progressViewStyle
        }
        set{
            SWKQueue.mainQueue().async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.progressView.progressViewStyle = newValue
            }
        }
    }
}
