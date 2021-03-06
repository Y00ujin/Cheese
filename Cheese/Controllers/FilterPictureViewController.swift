//
//  FilterPictureViewController.swift
//  Cheese
//
//  Created by 김유진 on 2022/06/23.
//

import UIKit

class FilterPictureViewController: UIViewController {

    // MARK: - Properties
    private lazy var filterHeaderView = FilterHeaderView().then{
        $0.backButton.addTarget(self, action: #selector(backButtonClicked(sender:)), for: .touchUpInside)
        $0.filterSaveButton.addTarget(self, action: #selector(filterSaveButtonClicked(sender:)), for: .touchUpInside)
    }
    private lazy var filterBottomView = FilterBottomView()

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
        [filterHeaderView, filterBottomView].forEach{ view.addSubview($0) }
    }
    
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
    
    // MARK: - Selectors
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
}
