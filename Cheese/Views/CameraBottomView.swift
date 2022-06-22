//
//  CameraBottomView.swift
//  Cheese
//
//  Created by 김유진 on 2022/06/22.
//

import UIKit

final class CameraBottomView: UIView {

    // MARK: - Properties
    private let size = UIScreen.main.bounds

    private lazy var bottomView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.applyShadow(x: 0, y: -8, blur: 15)
    }
    
    private lazy var cameraButton = UIButton().then{
        $0.setImage(UIImage(named: "Cheese_CameraButtonImage"), for: .normal)
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
        bottomView.addSubview(cameraButton)
    }
    
    // MARK: - addLocation Function
    private func addLocation(){
        bottomView.snp.makeConstraints {
            $0.top.right.bottom.left.equalToSuperview()
        }
        
        cameraButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(size.height/40)
            $0.width.height.equalTo(55)
        }
    }
}
