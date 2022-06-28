//
//  FilterWriteViewController.swift
//  Cheese
//
//  Created by 김유진 on 2022/06/23.
//

import UIKit

class FilterWriteViewController: UIViewController {
    
    // MARK: - Properties
    private let filterHeaderView = FilterHeaderView().then{
        $0.backButton.addTarget(self, action: #selector(backButtonClicked(sender:)), for: .touchUpInside)
        $0.filterSaveButton.addTarget(self, action: #selector(filterSaveButtonClicked(sender:)), for: .touchUpInside)
    }
    
    private let filterBottomView = FilterBottomView()
    
    private let inputTextField = UITextField().then{
        $0.placeholder = "글씨를 입력해주세요."
        $0.backgroundColor = UIColor.rgb(r: 245, g: 245, b: 245)
        $0.textAlignment = .center
        $0.layer.cornerRadius = 10
        $0.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 13)
    }
    
    private var textLabel = UILabel().then{
        $0.text = ""
        $0.isHidden = true
        $0.textColor = UIColor.black
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 13)
    }
    
    private let createTextButton = UIButton().then{
        $0.setTitle("글씨 생성하기", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 11)
        $0.layer.cornerRadius = 10
        $0.setTitleColor(UIColor.rgb(r: 50, g: 50, b: 50), for: .normal)
        $0.backgroundColor = UIColor(red: 238/255, green: 207/255, blue: 98/255, alpha: 1)
        $0.addTarget(self, action: #selector(createTextButtonClicked(sender:)), for: .touchUpInside)
    }
    
    private let upSizeButton = UIButton().then{
        $0.setTitle("T", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        $0.addTarget(self, action: #selector(upSizeButtonClicked(sender:)), for: .touchUpInside)
    }
    
    private let downSizeButton = UIButton().then{
        $0.setTitle("T", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 11)
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        $0.addTarget(self, action: #selector(downSizeButtonClicked(sender:)), for: .touchUpInside)
    }

    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
    }
    
    // MARK: - setView Function
    private func setView(){
        view.backgroundColor = .white
        
        addView()
        addLocation()
    }
    
    // MARK: - addView Function
    private func addView(){
        [filterHeaderView, filterBottomView, inputTextField, createTextButton, textLabel, upSizeButton, downSizeButton].forEach{ view.addSubview($0) }
        
        [upSizeButton, downSizeButton].forEach{ filterBottomView.addSubview($0) }
    }
    
    // MARK: - addLocation()
    private func addLocation(){
        filterHeaderView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(view.frame.height/18.45)
            $0.left.right.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(12.49)
        }
        
        filterBottomView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(12.49)
        }
        
        inputTextField.snp.makeConstraints {
            $0.width.equalToSuperview().dividedBy(1.4)
            $0.center.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(10)
        }
        
        createTextButton.snp.makeConstraints{
            $0.top.equalTo(inputTextField.snp.bottom).offset(view.frame.height/120)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(inputTextField).dividedBy(2.4)
            $0.width.equalTo(inputTextField).dividedBy(2.5)
        }
        
        textLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
        upSizeButton.snp.makeConstraints{
            $0.height.equalTo(createTextButton)
            $0.width.equalTo(createTextButton.snp.height)
            $0.centerY.equalTo(filterBottomView)
            $0.left.equalToSuperview().offset(self.view.frame.width/1.9)
        }
        
        downSizeButton.snp.makeConstraints{
            $0.height.width.equalTo(upSizeButton)
            $0.centerY.equalTo(filterBottomView)
            $0.right.equalToSuperview().offset(-self.view.frame.width/1.9)
        }
    }
    
    // MARK: - Targets
    @objc private func backButtonClicked(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func filterSaveButtonClicked(sender: UIButton){
        let alert = UIAlertController(title: "저장 완료!", message: "필터가 저장되었습니다.", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.7) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc private func createTextButtonClicked(sender: UIButton){
        [createTextButton, inputTextField].forEach{ $0.isHidden = true }
        
        textLabel.text = inputTextField.text
        textLabel.isHidden = false
    }
    
    @objc private func upSizeButtonClicked(sender: UIButton){
        textLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
    }
    
    @objc private func downSizeButtonClicked(sender: UIButton){
        textLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
    }
}
