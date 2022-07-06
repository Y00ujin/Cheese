//
//  FilterWayChooseViewController.swift
//  Cheese
//
//  Created by 김유진 on 2022/06/23.
//

import UIKit

final class FilterWayChooseViewController: UIViewController{
    
    // MARK: - Properties
    private let size = UIScreen.main.bounds
    
    private lazy var cheeseTitleLabel = UILabel().then{
        $0.text = "Cheese"
        $0.textColor = UIColor(red: 238/255, green: 207/255, blue: 98/255, alpha: 1)
        $0.font = UIFont(name: "AmericanTypewriter-Bold", size: 35)
    }
    
    private lazy var cheeseSubTitleLabel = UILabel().then{
        $0.text = "필터 생성 방법을 선택해주세요."
        $0.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 17)
        $0.textColor = UIColor.black
    }
    
    private lazy var drawFilterButton = UIButton().then{
        $0.backgroundColor = .white
        $0.layer.applyShadow(color: UIColor.black.cgColor, x: 0, y: 4, blur: 20)
        $0.setTitle("그림으로 필터만들기", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 14)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(drawFilterButtonClicked(sender:)), for: .touchUpInside)
    }
    
    private lazy var writeFilterButton = UIButton().then{
        $0.backgroundColor = .white
        $0.layer.applyShadow(color: UIColor.black.cgColor, x: 0, y: 4, blur: 20)
        $0.setTitle("글로 필터만들기", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 14)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(writeFilterButtonClicked(sender:)), for: .touchUpInside)
    }
    
    private lazy var pictureFilterButton = UIButton().then{
        $0.backgroundColor = .white
        $0.layer.applyShadow(color: UIColor.black.cgColor, x: 0, y: 4, blur: 20)
        $0.setTitle("사진으로 필터만들기", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 14)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(pictureFilterButtonClicked(sender:)), for: .touchUpInside)
    }
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
    }
    
    // MARK: - Helpers
    private func setView(){
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        
        addView()
        addLocation()
    }
    
    private func addView(){
        [cheeseSubTitleLabel, cheeseTitleLabel, drawFilterButton, writeFilterButton, pictureFilterButton].forEach{ view.addSubview($0) }
    }
    
    private func addLocation(){
        cheeseTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(size.height/6.45)
            $0.left.equalToSuperview().offset(size.width/9.37)
        }
        
        cheeseSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(cheeseTitleLabel.snp.bottom).offset(size.height/150)
            $0.left.equalTo(cheeseTitleLabel.snp.left)
        }
        
        drawFilterButton.snp.makeConstraints {
            $0.top.equalTo(cheeseSubTitleLabel.snp.bottom).offset(size.height/20)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(1.3)
            $0.height.equalToSuperview().dividedBy(7)
        }
        
        writeFilterButton.snp.makeConstraints {
            $0.top.equalTo(drawFilterButton.snp.bottom).offset(size.height/40)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(1.3)
            $0.height.equalToSuperview().dividedBy(7)
        }
        
        pictureFilterButton.snp.makeConstraints {
            $0.top.equalTo(writeFilterButton.snp.bottom).offset(size.height/40)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(1.3)
            $0.height.equalToSuperview().dividedBy(7)
        }
    }
    
    // MARK: - Selectors
    @objc func drawFilterButtonClicked(sender: UIButton){
        let vc = FilterDrawViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func writeFilterButtonClicked(sender: UIButton){
        let vc = FilterWriteViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pictureFilterButtonClicked(sender: UIButton){
        let vc = FilterPictureViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
