//
//  ViewController.swift
//  Cheese
//
//  Created by 김유진 on 2022/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    private let cameraHeaderView = CameraHeaderView()
    private let cameraBottomView = CameraBottomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    private func setView(){
        view.backgroundColor = .white
        
        addView()
        addLocation()
    }
    
    private func addView(){
        [cameraBottomView, cameraHeaderView].forEach{ view.addSubview($0) }
    }
    
    private func addLocation(){
        cameraHeaderView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(view.frame.height/18.45)
            $0.left.right.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(12.49)
        }
        
        cameraBottomView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(9.49)
        }
    }
}

