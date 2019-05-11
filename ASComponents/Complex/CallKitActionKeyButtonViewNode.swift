//
//  CallKitActionKeyButtonViewNode.swift
//  ASComponents
//
//  Created by Majid Hatami Aghdam on 5/3/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import AsyncDisplayKit

public final class CallKitActionKeyButtonViewNode:ASDisplayNode {
    public final class CallKitButtonIconContainerNode:ASDisplayNode {
        var isSelected:Bool = false {
            didSet{ self.updateImage() }
        }
        
        public var isEnabled:Bool = true {
            didSet{ self.updateImage() }
        }
        
        let imageNode:ASImageNode = ASImageNode()

        var iconImage:UIImage?
        var iconImageSelected:UIImage?
        var iconImageDisabled:UIImage?
        
        public init(_ iconImage:UIImage?,
                    _ iconImageSelected:UIImage?,
                    _ iconImageDisabled:UIImage?) {
            self.iconImage = iconImage
            self.iconImageSelected = iconImageSelected
            self.iconImageDisabled = iconImageDisabled
            super.init()
            self.automaticallyManagesSubnodes = true
            
            self.imageNode.style.alignSelf = .center
            self.imageNode.image = iconImage
            self.imageNode.forceUpscaling = true
            self.imageNode.contentMode = .scaleAspectFit
            
            self.updateImage()
        }
        
        fileprivate func updateImage(){
            self.imageNode.image = self.isEnabled ? (self.isSelected ? (self.iconImageSelected ?? self.iconImage) : self.iconImage) :  (self.iconImageDisabled ?? self.iconImage)
        }
        
        public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
            let layout = ASStackLayoutSpec.vertical()
            layout.alignContent = .center
            layout.justifyContent = .center
            layout.children = [self.imageNode]
            return layout
        }
        
        func setValues(_ iconImage:UIImage?,
                       _ iconImageSelected:UIImage?,
                       _ iconImageDisabled:UIImage?) {
            self.iconImage = iconImage
            self.iconImageSelected = iconImageSelected
            self.iconImageDisabled = iconImageDisabled
            self.updateImage()
        }
    }
    
    
    public var onTouchInInside:((_ sender:CallKitActionKeyButtonViewNode) -> ())?
    public var onTouchUpInside:((_ sender:CallKitActionKeyButtonViewNode) -> ())?
    
    let iconContainerNode:CallKitButtonIconContainerNode
    let labelNode:ASTextNode2 = ASTextNode2()
    let normalBackgroundColor:UIColor = UIColor(white: 1, alpha: 0.2)
    let highlightBackgroundColor:UIColor = UIColor(white: 1, alpha: 0.5)
    let selectedBackgroundColor:UIColor = UIColor(white: 1, alpha: 1.0)
    
    var titleAttributedStringSelected:NSAttributedString?
    var titleAttributedStringDisabled:NSAttributedString?
    var titleAttributedString:NSAttributedString
    
    public init(_ iconImage:UIImage?,
                _ iconImageSelected:UIImage?,
                _ iconImageDisabled:UIImage?,
                _ titleAttributedString:NSAttributedString,
                _ titleAttributedStringSelected:NSAttributedString? = nil,
                _ titleAttributedStringDisabled:NSAttributedString? = nil) {
        self.titleAttributedString = titleAttributedString
        self.titleAttributedStringSelected = titleAttributedStringSelected
        self.titleAttributedStringDisabled = titleAttributedStringDisabled
        self.iconContainerNode = CallKitButtonIconContainerNode(iconImage, iconImageSelected, iconImageDisabled)
        super.init()
        self.automaticallyManagesSubnodes = true
        self.labelNode.attributedText = titleAttributedString
        self.iconContainerNode.backgroundColor = self.normalBackgroundColor
        
        self.updateText()
    }
    
    
    public func setValues(_ iconImage:UIImage?,
                _ iconImageSelected:UIImage?,
                _ iconImageDisabled:UIImage?,
                _ titleAttributedString:NSAttributedString,
                _ titleAttributedStringSelected:NSAttributedString? = nil,
                _ titleAttributedStringDisabled:NSAttributedString? = nil ){
        self.titleAttributedString = titleAttributedString
        self.titleAttributedStringSelected = titleAttributedStringSelected
        self.titleAttributedStringDisabled = titleAttributedStringDisabled
        
        self.iconContainerNode.setValues(iconImage, iconImageSelected, iconImageDisabled)
        self.updateText()
    }
    
    fileprivate func updateText(){
        self.labelNode.attributedText = self.isEnabled ? ( self.isSelected ? (self.titleAttributedStringSelected ?? self.titleAttributedString) : self.titleAttributedString ) :
            (self.titleAttributedStringDisabled ?? self.titleAttributedString )
    }
    
    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width:CGFloat = min(constrainedSize.max.width, constrainedSize.max.height)
        let verticalLayout = ASStackLayoutSpec.vertical()
        verticalLayout.justifyContent = .start
        verticalLayout.alignContent = .center
        self.labelNode.style.alignSelf = .center
        
        self.iconContainerNode.style.preferredSize = CGSize(width: width, height: width)
        self.iconContainerNode.cornerRadius = width/2
        
        verticalLayout.spacing = 6
        verticalLayout.children = [self.iconContainerNode, self.labelNode]
        
        return verticalLayout
    }
    
    public var isSelected:Bool = false {
        didSet {
            self.iconContainerNode.isSelected = self.isSelected
            if self.isEnabled {
                self.iconContainerNode.backgroundColor = self.iconContainerNode.isSelected ? self.selectedBackgroundColor : self.normalBackgroundColor
            }
            self.updateText()
        }
    }
    
    public var isEnabled:Bool =  true {
        didSet{
            self.iconContainerNode.isEnabled = self.isEnabled
            
            /// if Disabled, setbackground color
            if !self.isEnabled {
                self.iconContainerNode.backgroundColor = self.normalBackgroundColor
            }
            self.updateText()
        }
    }
    
    private var m_isHighlighted:Bool = false {
        didSet{
            SWKQueue.mainQueue().async { [weak self] in
                UIView.animate(withDuration: 0.3, animations: { [weak self] in
                    if !(self?.isSelected ?? false) {
                        if self?.m_isHighlighted ?? false {
                            self?.iconContainerNode.backgroundColor = self?.highlightBackgroundColor
                        }else{
                            self?.iconContainerNode.backgroundColor = self?.normalBackgroundColor
                        }
                    }
                })
            }
        }
    }
    
    private func isInsideSelf(touches:Set<UITouch>, event:UIEvent?) -> Bool{
        
        if let touch = touches.first {
            let location = touch.location(in: self.view)
            if self.bounds.contains(location) { return true }
        }
        return false
    }
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if !self.isEnabled { return }
        m_isHighlighted = true
        
        if self.isInsideSelf(touches: touches, event: event) {
            self.onTouchInInside?(self)
        }
        
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if !self.isEnabled { return }
        
        if self.isInsideSelf(touches: touches, event: event) {
            m_isHighlighted = true
        }else{
            m_isHighlighted = false
        }
        
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if !self.isEnabled { return }
        m_isHighlighted = false
        
        if self.isInsideSelf(touches: touches, event: event) {
            self.onTouchUpInside?( self )
        }
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        if !self.isEnabled { return }
        m_isHighlighted = false
    }
}



