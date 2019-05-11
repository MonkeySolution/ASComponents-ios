//
//  CallKitRecordButtonViewNode.swift
//  ASComponents
//
//  Created by Majid Hatami Aghdam on 5/3/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Lottie


open class CallKitRecordButtonViewNode:ASDisplayNode {
    let labelNode:ASTextNode2 = ASTextNode2()
    let recordAnimationSelectedLottieViewNode:ASLottieAnimationViewNode = ASLottieAnimationViewNode(named: "call_kit_record_btn_selected", bundle: Bundle(for: ASTransferButtonNode.self))
    let recordAnimationLottieViewNode:ASLottieAnimationViewNode = ASLottieAnimationViewNode(named: "call_kit_record_btn_normal", bundle: Bundle(for: ASTransferButtonNode.self))
    
    open var onTouchInInside:((_ sender:CallKitRecordButtonViewNode) -> ())?
    open var onTouchUpInside:((_ sender:CallKitRecordButtonViewNode) -> ())?
    
    
    let normalBackgroundColor:UIColor = UIColor(white: 1, alpha: 0.2)
    let highlightBackgroundColor:UIColor = UIColor(white: 1, alpha: 0.5)
    let selectedBackgroundColor:UIColor = UIColor(white: 1, alpha: 1.0)
    
    let titleAttributedStringSelected:NSAttributedString?
    let titleAttributedStringDisabled:NSAttributedString?
    let titleAttributedString:NSAttributedString
    
    public init( _ titleAttributedString:NSAttributedString,
                 _ titleAttributedStringSelected:NSAttributedString? = nil,
                 _ titleAttributedStringDisabled:NSAttributedString? = nil) {
        self.titleAttributedString = titleAttributedString
        self.titleAttributedStringSelected = titleAttributedStringSelected
        self.titleAttributedStringDisabled = titleAttributedStringDisabled
        
        super.init()
        self.automaticallyManagesSubnodes = true
        self.labelNode.attributedText = titleAttributedString
    }
    
    
    
    open override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width:CGFloat = min(constrainedSize.max.width, constrainedSize.max.height)
        let verticalLayout = ASStackLayoutSpec.vertical()
        verticalLayout.justifyContent = .start
        verticalLayout.alignContent = .center
        self.labelNode.style.alignSelf = .center
        
        
        verticalLayout.spacing = 6
        if self.isSelected {
            self.recordAnimationSelectedLottieViewNode.style.preferredSize = CGSize(width: width, height: width)
            verticalLayout.children = [self.recordAnimationSelectedLottieViewNode, self.labelNode]
        }else{
            self.recordAnimationLottieViewNode.style.preferredSize = CGSize(width: width, height: width)
            verticalLayout.children = [self.recordAnimationLottieViewNode, self.labelNode]
        }
        return verticalLayout
    }
    
    public var isSelected:Bool = false {
        didSet {
            if self.isEnabled {
                if self.isSelected {
                    self.recordAnimationSelectedLottieViewNode.play()
                }else{
                    self.recordAnimationSelectedLottieViewNode.stop()
                }
                self.labelNode.attributedText = !self.isSelected ? self.titleAttributedString : (self.titleAttributedStringSelected ?? self.titleAttributedString )
                self.setNeedsLayout()
            }
        }
    }
    
    public var isEnabled:Bool =  true {
        didSet{
            self.recordAnimationLottieViewNode.alpha = self.isEnabled ? 0.6 : 1
            self.recordAnimationSelectedLottieViewNode.alpha = self.isEnabled ? 0.6 : 1
            self.labelNode.attributedText = self.isEnabled ? self.titleAttributedString : (self.titleAttributedStringDisabled ?? self.titleAttributedString )
        }
    }
    
    private var m_isHighlighted:Bool = false {
        didSet{
            self.recordAnimationLottieViewNode.alpha = self.m_isHighlighted ? 0.6 : 1
            self.recordAnimationSelectedLottieViewNode.alpha = self.m_isHighlighted ? 0.6 : 1
        }
    }
    
    private func isInsideSelf(touches:Set<UITouch>, event:UIEvent?) -> Bool{
        
        if let touch = touches.first {
            let location = touch.location(in: self.view)
            if self.bounds.contains(location) { return true }
        }
        return false
    }
    
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if !self.isEnabled { return }
        m_isHighlighted = true
        
        if self.isInsideSelf(touches: touches, event: event) {
            self.onTouchInInside?(self)
        }
        
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if !self.isEnabled { return }
        
        if self.isInsideSelf(touches: touches, event: event) {
            m_isHighlighted = true
        }else{
            m_isHighlighted = false
        }
        
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if !self.isEnabled { return }
        m_isHighlighted = false
        
        if self.isInsideSelf(touches: touches, event: event) {
            self.onTouchUpInside?( self )
        }
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        if !self.isEnabled { return }
        m_isHighlighted = false
    }
}




