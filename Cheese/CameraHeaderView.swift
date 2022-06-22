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
    
    private let size = UIScreen.main.bounds
    
    private lazy var headerView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.applyShadow(x: 0, y: 8, blur: 15)
    }
    
    private lazy var filterButton = UIButton().then{
        $0.setImage(UIImage(named: "Cheese_FilterListImage"), for: .normal)
    }
    
    private lazy var changeCameraButton = UIButton().then{
        $0.setImage(UIImage(named: "Cheese_ChangeCameraDirectionImage"), for: .normal)
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
        [filterButton, changeCameraButton].forEach{ self.addSubview($0) }
    }
    
    private func addLocation(){
        headerView.snp.makeConstraints {
            $0.top.right.bottom.left.equalToSuperview()
        }
        
        filterButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(size.width/12.93)
            $0.width.equalTo(20)
            $0.height.equalTo(13)
        }
        
        changeCameraButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(size.width/12.93)
            $0.width.equalTo(20)
            $0.height.equalTo(20)
        }
    }
}
