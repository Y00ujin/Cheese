//
//  FilterDrawViewController.swift
//  Cheese
//
//  Created by 김유진 on 2022/06/23.
//

import UIKit

class FilterDrawViewController: UIViewController {
    
    // MARK: - Properties
    private let size = UIScreen.main.bounds
    
    private let filterHeaderView = FilterHeaderView().then{
        $0.backButton.addTarget(self, action: #selector(backButtonClicked(sender:)), for: .touchUpInside)
    }
    
    private let filterBottomView = FilterBottomView()
    
    private let colorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then{
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 13
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
        $0.showsHorizontalScrollIndicator = false
        $0.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: ColorCollectionViewCell.reuseId)
    }
    
    private let colorArray = [UIColor.rgb(r: 237, g: 177, b: 177),UIColor.rgb(r: 237, g: 206, b: 177),UIColor.rgb(r: 237, g: 231, b: 177),UIColor.rgb(r: 225, g: 237, b: 177),UIColor.rgb(r: 178, g: 237, b: 177),UIColor.rgb(r: 177, g: 237, b: 177),UIColor.rgb(r: 177, g: 222, b: 237),UIColor.rgb(r: 177, g: 187, b: 237),UIColor.rgb(r: 218, g: 177, b: 237)]

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
        addDelegate()
    }
    
    // MARK: - addDelegate Function
    private func addDelegate(){
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
    }
    
    // MARK: - addView Function
    private func addView(){
        [filterHeaderView, filterBottomView].forEach{ view.addSubview($0) }
        
        filterBottomView.addSubview(colorCollectionView)
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
        
        colorCollectionView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(size.height/80)
            $0.left.equalToSuperview().offset(size.width/17.85)
            $0.right.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
    
    // MARK: - Targets
    @objc private func backButtonClicked(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

extension FilterDrawViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.reuseId, for: indexPath) as! ColorCollectionViewCell
        cell.cellBackgroundView.backgroundColor = colorArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("클릭")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/12.5, height: self.view.frame.width/12.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: size.width/17.85)
    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 26
//    }
}
