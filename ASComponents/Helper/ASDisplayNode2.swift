//
//  ASDisplayNode2.swift
//  ASComponents
//
//  Created by Majid Hatami Aghdam on 4/15/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit

import UIKit
import AsyncDisplayKit

open class ASDisplayNode2: ASDisplayNode {
    
    open override func animateLayoutTransition(_ context: ASContextTransitioning) {
        /// Due to a bug, sometimes transitions happens on a node which is not loaded. This is the method to prevent assertion on not loaded nodes.
        if !self.isNodeLoaded {
            LOGE("ASDisplayNode2 failed. Node is not loaded.")
            return
        }
        super.animateLayoutTransition(context)
    }
    
}
