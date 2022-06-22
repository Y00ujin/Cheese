//
//  FilterCollectionViewCell.swift
//  Cheese
//
//  Created by 김유진 on 2022/06/22.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let reuseId = "\(FilterCollectionViewCell.self)"
    
    private let size = UIScreen.main.bounds
    
    private lazy var cellBackgroundView = UIView().then{
        $0.backgroundColor = .white
    }
    
    // MARK: - LifeCycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    private func setView(){
        addView()
        addLocation()
    }
    
    private func addView(){
        self.addSubview(cellBackgroundView)
    }
    
    private func addLocation(){
        cellBackgroundView.snp.makeConstraints{
            $0.width.height.equalToSuperview()
            cellBackgroundView.layer.cornerRadius = size.width/5.35/2
        }
    }
}
