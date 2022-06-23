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
    }
    private let filterBottomView = FilterBottomView()

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
        [filterHeaderView, filterBottomView].forEach{ view.addSubview($0) }
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
    }
    
    // MARK: - Targets
    @objc private func backButtonClicked(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
