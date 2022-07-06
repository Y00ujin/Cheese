//
//  SaveViewController.swift
//  Cheese
//
//  Created by 김유진 on 2022/07/06.
//

import UIKit
import Photos

final class SaveViewController: UIViewController {
    // MARK: - Properties
    private let size = UIScreen.main.bounds
    
    private lazy var headerView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.applyShadow(x: 0, y: 8, blur: 15)
    }

    private lazy var bottomView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.applyShadow(x: 0, y: -8, blur: 15)
    }
    
    private lazy var saveButton = UIButton().then{
        $0.setImage(UIImage(named: "Cheese_SaveButtonImage"), for: .normal)
        $0.addTarget(self, action: #selector(saveButtonClicked(sender:)), for: .touchUpInside)
    }
    
    private lazy var backButton = UIButton().then{
        $0.setImage(UIImage(named: "Cheese_BackButtonImage"), for: .normal)
        $0.addTarget(self, action: #selector(backButtonClicked(sender:)), for: .touchUpInside)
    }
    
    var pictureImageView = UIImageView().then{
        $0.backgroundColor = .systemPink
    }

    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
    }

    // MARK: - Helpers
    private func setView(){
        view.backgroundColor = .white
        
        addView()
        addLocation()
    }
    
    private func addView(){
        [pictureImageView, headerView, bottomView].forEach{ view.addSubview($0) }
        bottomView.addSubview(saveButton)
        headerView.addSubview(backButton)
    }
    
    private func addLocation(){
        headerView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(view.frame.height/18.45)
            $0.left.right.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(9.49)
        }
        
        backButton.snp.makeConstraints{
            $0.width.height.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(size.width/12.93)
        }
        
        bottomView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(4.5)
        }
        
        saveButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(size.height/15)
            $0.width.height.equalTo(55)
        }
        
        pictureImageView.snp.makeConstraints{
            $0.width.centerX.equalToSuperview()
            $0.bottom.equalTo(bottomView.snp.top)
            $0.top.equalTo(headerView.snp.bottom)
        }
    }
    
    // MARK: - Selectors
    @objc private func backButtonClicked(sender: UIButton){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func saveButtonClicked(sender: UIButton){
        PHPhotoLibrary.requestAuthorization( { status in
                switch status {
                case .authorized:
                    DispatchQueue.main.sync {
                        UIImageWriteToSavedPhotosAlbum(self.pictureImageView.image!, self, nil, nil)
                    }
                case .denied:
                    break
                case .restricted, .notDetermined:
                    break
                default:
                    break
                }
            })
        
        let alert = UIAlertController(title: "갤러리 저장 완료!", message: "사진이 갤러리에 저장되었습니다.", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.7) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
