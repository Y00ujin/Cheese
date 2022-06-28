//
//  CameraViewController.swift
//  Cheese
//
//  Created by 김유진 on 2022/06/22.
//

import UIKit

final class CameraViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var cameraHeaderView = CameraHeaderView().then{
        $0.filterButton.addTarget(self, action: #selector(filterButtonClicked(sender:)), for: .touchUpInside)
    }
    
    private lazy var cameraBottomView = CameraBottomView()
    
    private lazy var filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then{
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 20
        $0.collectionViewLayout = layout
        $0.showsHorizontalScrollIndicator = false
        $0.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.reuseId)
        $0.register(FilterAddCollectionViewCell.self, forCellWithReuseIdentifier: FilterAddCollectionViewCell.reuseId)
        $0.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
        $0.isHidden = true
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
        addDelegate()
    }
    
    private func addDelegate(){
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
    }
    
    private func addView(){
        [filterCollectionView, cameraBottomView, cameraHeaderView].forEach{ view.addSubview($0) }
    }
    
    private func addLocation(){
        filterCollectionView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(3.15)
            $0.bottom.equalTo(cameraBottomView.snp.top)
        }
        
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
    
    // MARK: - Selectors
    @objc func filterButtonClicked(sender: UIButton){
        if cameraHeaderView.filterButtonClicked {
            filterCollectionView.isHidden = true
        }else{
            filterCollectionView.isHidden = false
            UIView.upAnimation(modal: filterCollectionView)
        }
        cameraHeaderView.filterButtonClicked = !(cameraHeaderView.filterButtonClicked)
    }
}

extension CameraViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 21
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterAddCollectionViewCell.reuseId, for: indexPath) as! FilterAddCollectionViewCell
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.reuseId, for: indexPath) as! FilterCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = FilterWayChooseViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        cameraHeaderView.filterButtonClicked = !(cameraHeaderView.filterButtonClicked)
        filterCollectionView.isHidden = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/5.35, height: self.view.frame.width/5.35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: self.view.frame.width/12, left: self.view.frame.width/10, bottom: self.view.frame.width/12, right: self.view.frame.width/10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 26
    }
}
