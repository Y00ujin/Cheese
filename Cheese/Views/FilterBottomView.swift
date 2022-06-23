//
//  FilterBottomView.swift
//  Cheese
//
//  Created by 김유진 on 2022/06/23.
//

import UIKit

class FilterBottomView: UIView {

    // MARK: - Properties
    private let size = UIScreen.main.bounds

    private lazy var bottomView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.applyShadow(x: 0, y: -8, blur: 15)
    }
    
    // MARK: - LifeCycles
    override init(frame: CGRect){
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setView()
    }
    
    // MARK: - setView Function
    private func setView(){
        addView()
        addLocation()
    }
    
    // MARK: - addView Function
    private func addView(){
        self.addSubview(bottomView)
    }
    
    // MARK: - addLocation Function
    private func addLocation(){
        bottomView.snp.makeConstraints {
            $0.top.right.bottom.left.equalToSuperview()
        }
    }
}
