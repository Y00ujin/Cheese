//
//  FilterHeaderView.swift
//  Cheese
//
//  Created by 김유진 on 2022/06/23.
//

import UIKit

class FilterHeaderView: UIView {
    // MARK: - Properties
    private let size = UIScreen.main.bounds

    private lazy var headerView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.applyShadow(x: 0, y: 8, blur: 15)
    }
        
    lazy var backButton = UIButton().then{
        $0.setImage(UIImage(named: "Cheese_BackButtonImage"), for: .normal)
    }
    
    lazy var filterSaveButton = UIButton().then{
        $0.setImage(UIImage(named: "Cheese_FilterSaveButtonImage"), for: .normal)
    }

    // MARK: - View LifeCycles
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
        self.addSubview(headerView)
        [backButton, filterSaveButton].forEach{ self.addSubview($0) }
    }
    
    // MARK: - addLocation Function
    private func addLocation(){
        headerView.snp.makeConstraints {
            $0.top.right.bottom.left.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(size.width/12.93)
            $0.width.equalTo(20)
            $0.height.equalTo(20)
        }
        
        filterSaveButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(size.width/12.93)
            $0.width.equalTo(20)
            $0.height.equalTo(20)
        }
    }
}
