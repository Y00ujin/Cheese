//
//  Extension.swift
//  Cheese
//
//  Created by 김유진 on 2022/06/22.
//

import UIKit

// MARK: - Shadow extension
extension CALayer {
    func applyShadow(alpha: Float = 0.1, x: CGFloat, y: CGFloat, blur: CGFloat, spread: CGFloat = 0){
        shadowColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1).cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur/UIScreen.main.scale
        masksToBounds = false
    
        if spread == 0 {
            shadowPath = nil
        }else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
