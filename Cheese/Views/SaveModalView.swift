//
//  SaveModalView.swift
//  Cheese
//
//  Created by 김유진 on 2022/06/23.
//

import UIKit

final class SaveModalView: UIView {

    // MARK: - Properties
    private let size = UIScreen.main.bounds

    private lazy var modalBackgroundView = UIView().then{
        $0.backgroundColor = UIColor.rgb(r: 250, g: 250, b: 250)
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.rgb(r: 218, g: 218, b: 218).cgColor
        $0.layer.cornerRadius = 10
    }
    
    private lazy var modalTextLabel = UILabel().then{
        $0.text = "필터가 저장되었습니다."
        $0.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 13)
        $0.textColor = UIColor.black
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
    
    // MARK: - Helpers
    private func setView(){
        addView()
        addLocation()
    }
    
    private func addView(){
        self.addSubview(modalBackgroundView)
        modalBackgroundView.addSubview(modalTextLabel)
    }
    
    private func addLocation(){
        modalBackgroundView.snp.makeConstraints {
            $0.width.equalToSuperview().dividedBy(1.42)
            $0.height.equalToSuperview().dividedBy(11.12)
            $0.center.equalToSuperview()
        }
        
        modalTextLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

}
