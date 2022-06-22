//
//  CameraHeaderView.swift
//  Cheese
//
//  Created by 김유진 on 2022/06/22.
//

import UIKit
import SnapKit
import Then

final class CameraHeaderView: UIView {
    
    private lazy var headerView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.applyShadow(x: 0, y: 8, blur: 15)
    }

    override init(frame: CGRect){
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setView()
    }
    
    private func setView(){
        
        addView()
        addLocation()
    }
    
    private func addView(){
        self.addSubview(headerView)
    }
    
    private func addLocation(){
        headerView.snp.makeConstraints {
            $0.top.right.bottom.left.equalToSuperview()
        }
    }
}
