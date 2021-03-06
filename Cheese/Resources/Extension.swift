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

// MARK: - UIColor rgb extension
extension UIColor{
    static func rgb(r: CGFloat ,g: CGFloat,b:CGFloat) -> UIColor{
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
let size = UIScreen.main.bounds

// MARK: - UIView animation extension
extension UIView{
    

    
    static func downAnimation(modal: UIView){
        print("down")

        UIView.animate(withDuration: 1,
                      delay: 0,
                      options: .curveEaseInOut,
                      animations: { () -> Void in
                       modal.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
       },
                      completion: { (didFinish) -> Void in
       })
    }
}

