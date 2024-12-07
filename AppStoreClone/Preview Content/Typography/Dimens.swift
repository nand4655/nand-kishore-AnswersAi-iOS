//
//
// Dimens.swift
// AppStoreClone
//
// Created by Nand on 07/12/24
//

import Foundation
import UIKit

class Dimens {
    // MARK: - Screen
    static let w: CGFloat = UIScreen.main.bounds.width
    static let h: CGFloat = UIScreen.main.bounds.width
    
    // MARK: - Paddings
    static let unit0: CGFloat = 0
    static let unit6: CGFloat = 6
    static let unit12: CGFloat = 12
    static let unit16: CGFloat = 16
    static let unit24: CGFloat = 24
    static let unit28: CGFloat = 28
    static let unit32: CGFloat = 32
    
    // MARK: - Card
    static let cardHeight: CGFloat = 205
    static let cardImageHeight: CGFloat = 92
    static let cardForegroundHeight: CGFloat = 98
    
    // MARK: - CornerRadius
    struct CornerRadius {
        static let unit6: CGFloat = 6
        static let unit12: CGFloat = 12
        static let unit16: CGFloat = 16
        static let unit24: CGFloat = 24
        static let unit28: CGFloat = 28
    }
    
    // MARK: - Shadow
    struct Shadow {
        static let unit6: CGFloat = 6
        static let unit12: CGFloat = 12
        static let unit16: CGFloat = 16
        static let unit24: CGFloat = 24
    }
    
    // MARK: - CardDetail
    static let cardDetailImageHeight: CGFloat = 450
    static let cardDetailHeaderHeight: CGFloat = 288
    static let cardGradientHeight: CGFloat = 400
    static let cardGradientFillHeight: CGFloat = 100
    static let sameImageHeight: CGFloat = 140
    
    struct Size {
        static let unit12: CGFloat = 12
        static let unit16: CGFloat = 18
        static let unit20: CGFloat = 20
        static let unit24: CGFloat = 24
        static let unit28: CGFloat = 28
        static let unit32: CGFloat = 32
        static let unit40: CGFloat = 40
        static let unit56: CGFloat = 56
    }
    
    // MARK: - Other
    static let purchaseOverlayOffset: CGFloat = 590
}
