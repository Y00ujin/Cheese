//
//  ViewController.swift
//  Cheese
//
//  Created by 김유진 on 2022/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    private let cameraHeaderView = CameraHeaderView()

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
        view.addSubview(cameraHeaderView)
    }
    
    private func addLocation(){
        cameraHeaderView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(view.frame.height/18.45)
            $0.left.right.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(12.49)
        }
    }
}

