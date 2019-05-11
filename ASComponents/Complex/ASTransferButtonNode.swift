//
//  ASTransferButtonNode.swift
//  ASComponents
//
//  Created by Majid Hatami Aghdam on 4/17/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Lottie

open class ASTransferButtonNode: ASControlNode {
    let imageNode:ASImageNode = ASImageNode()
    let preparingLottieViewNode:ASLottieAnimationViewNode = ASLottieAnimationViewNode(named: "transfer_button_prepairing_day", bundle: Bundle(for: ASTransferButtonNode.self))
    let transferingLottieViewNode:ASLottieAnimationViewNode = ASLottieAnimationViewNode(named: "transfer_button_transfering_day", bundle: Bundle(for: ASTransferButtonNode.self))
    public enum TransfeRState {
        case None
        case Preparing
        case Transfering
    }
    
    public var transferState:TransfeRState = TransfeRState.None {
        didSet{
            if oldValue == self.transferState { return }
            SWKQueue.mainQueue().async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.transitionLayout(withAnimation: false, shouldMeasureAsync: false, measurementCompletion: nil)
            }
            
            if self.transferState != .Transfering {
                self.transferingLottieViewNode.currentTime = 0
            }
        }
    }
    
    public override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.imageNode.contentMode = .scaleAspectFit
        self.imageNode.forceUpscaling = true
        self.imageNode.image = UIImage(named: "cloud_download_button_icon", in: Bundle(for: ASTransferButtonNode.self), compatibleWith: nil)
        self.preparingLottieViewNode.play()
        self.transferingLottieViewNode.loopMode = .playOnce
        self.transferingLottieViewNode.stop()
        self.transferingLottieViewNode.currentFrame = 0
        self.transferingLottieViewNode.currentProgress = 0
    }
    
    private var m_progress:CGFloat = 0 {
        didSet{
            SWKQueue.mainQueue().async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.transferingLottieViewNode.lottieAnimationView.play(fromProgress: oldValue, toProgress: strongSelf.m_progress )
            }
        }
    }
    public var progress:CGFloat {
        set{
            var m_newValue:CGFloat = newValue
            if m_newValue > 1 {
                m_newValue = 1
            } else if m_newValue < 0 {
                m_newValue = 0
            }
            /// Also Set transfer animation frame
            if m_progress != m_newValue {
                m_progress = m_newValue
            }
        }
        get{
            return m_progress
        }
    }
    
    open override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let layout = ASStackLayoutSpec.horizontal()
        layout.justifyContent = .center
        switch transferState {
        case .None:
            self.imageNode.style.alignSelf = .center
            layout.child = self.imageNode
            break
        case .Preparing:
            self.preparingLottieViewNode.style.alignSelf = .center
            self.preparingLottieViewNode.style.preferredSize = constrainedSize.max
            layout.child = self.preparingLottieViewNode
            break
        case .Transfering:
            self.transferingLottieViewNode.style.alignSelf = .center
            self.transferingLottieViewNode.style.preferredSize = constrainedSize.max
            layout.child = self.transferingLottieViewNode
            break
        }
        
        return layout
    }
    
}
