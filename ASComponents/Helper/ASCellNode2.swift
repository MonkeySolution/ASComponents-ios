//
//  ASCellNode2.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 3/30/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import AsyncDisplayKit

open class ASCellNode2: ASCellNode {

    public var tableViewCell:UITableViewCell?{
        var count:Int = 4
        var m_view:UIView? = self.view.superview
        while(  m_view != nil && count > 0) {
            if let m_m_view = m_view as? UITableViewCell {
                return m_m_view
            }
            m_view = m_view?.superview;
            count -= 1;
        }
        return nil
    }
    
    
    open  var viewBackgroundColor: UIColor? {
        get{
            return self.tableViewCell?.backgroundColor
        }
        set{
            self.tableViewCell?.backgroundColor =  newValue
        }
    }
    
    /*
    open override var backgroundColor: UIColor?{
        didSet{
            LOGD("didSet")
            SWKQueue.mainQueue().async {
                //self.viewBackgroundColor = self.backgroundColor
            }
        }
    }
    */
    
    /*
    public var accessoryView:UIView? {
        get{ return self.tableViewCell?.accessoryView }
        set{ self.tableViewCell?.accessoryView = newValue }
    }
    */
    
    public var selectedBackgroundViewColor:UIColor? {
        get { return self.tableViewCell?.selectedBackgroundView?.backgroundColor }
        set { self.tableViewCell?.selectedBackgroundView?.backgroundColor = newValue }
    }
    
    open override func didLoad() {
        super.didLoad()
        self.updateThemeAndStrings()
    }
    
    open func updateThemeAndStrings(){
        
    }
}
