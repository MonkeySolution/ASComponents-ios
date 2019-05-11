//
//  LottieAnimationViewNode.swift
//  ASComponents
//
//  Created by Majid Hatami Aghdam on 3/14/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Lottie

public final class ASLottieAnimationViewNode: ASDisplayNode {
    public var lottieAnimationView: AnimationView { return view as! AnimationView }
    
    
    public init( named:String, bundle:Bundle? = nil ) {
        super.init()
        setViewBlock { () -> UIView in
            if let m_bundle = bundle {
                return AnimationView(name: named, bundle: m_bundle)
            }else{
                return AnimationView(name: named)
            }
        }
        self.contentMode = .scaleAspectFit
        //self.backgroundBehavior = .pauseAndRestore
        self.loopMode = .loop
    }
    
    /*
    public override func didEnterVisibleState() {
        super.didEnterVisibleState()
        SWKQueue.mainQueue().async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.lottieAnimationView.play()
        }
    }
    
    public override func didExitVisibleState() {
        super.didExitVisibleState()
        SWKQueue.mainQueue().async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.lottieAnimationView.stop()
        }
        
    }
    */
    
    public var currentTime:TimeInterval {
        get{
            assert(Thread.isMainThread, "This method must be called on MainThread only")
            return self.lottieAnimationView.currentTime
        }
        set{
            SWKQueue.mainQueue().async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.lottieAnimationView.currentTime = newValue
            }
        }
    }
    
    public var currentFrame:AnimationFrameTime {
        get{
            assert(Thread.isMainThread, "This method must be called on MainThread only")
            return self.lottieAnimationView.currentFrame
        }
        set{
            SWKQueue.mainQueue().async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.lottieAnimationView.currentFrame = newValue
            }
        }
    }
    
    public var currentProgress:AnimationProgressTime {
        get{
            assert(Thread.isMainThread, "This method must be called on MainThread only")
            return self.lottieAnimationView.currentProgress
        }
        set{
            SWKQueue.mainQueue().async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.lottieAnimationView.currentProgress = newValue
            }
        }
    }
 
    public var backgroundBehavior:LottieBackgroundBehavior {
        get{
            assert(Thread.isMainThread, "This method must be called on MainThread only")
            return self.lottieAnimationView.backgroundBehavior
        }
        set{
            SWKQueue.mainQueue().async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.lottieAnimationView.backgroundBehavior = newValue
            }
        }
    }
    
    public override var contentMode: UIView.ContentMode {
        get{ assert(Thread.isMainThread, "This method must be called on MainThread only")
            return self.lottieAnimationView.contentMode
        }
        set{
            SWKQueue.mainQueue().async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.lottieAnimationView.contentMode = newValue
            }
        }
    }
 
    public var loopMode:LottieLoopMode {
        get{
            assert(Thread.isMainThread, "This method must be called on MainThread only")
            return self.lottieAnimationView.loopMode
        }
        set{
            SWKQueue.mainQueue().async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.lottieAnimationView.loopMode = newValue
            }
        }
    }
    
    public var animationSpeed:CGFloat {
        get{
            assert(Thread.isMainThread, "This method must be called on MainThread only")
            return self.lottieAnimationView.animationSpeed
        }
        set{
            SWKQueue.mainQueue().async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.lottieAnimationView.animationSpeed = newValue
            }
        }
    }
    
    public func play(){
        SWKQueue.mainQueue().async {
            self.lottieAnimationView.play()
        }
    }
    
    public func stop(){
        SWKQueue.mainQueue().async {
            self.lottieAnimationView.stop()
        }
    }
}
