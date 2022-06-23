//
//  Extension.swift
//  Cheese
//
//  Created by 김유진 on 2022/06/22.
//

import UIKit

// MARK: - Shadow extension
extension CALayer {
    func applyShadow(color: CGColor = UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1).cgColor, alpha: Float = 0.1, x: CGFloat, y: CGFloat, blur: CGFloat, spread: CGFloat = 0){
        shadowColor = color
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
