//
//  FilterAddCollectionViewCell.swift
//  Cheese
//
//  Created by 김유진 on 2022/06/23.
//

import UIKit

class FilterAddCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let reuseId = "\(FilterAddCollectionViewCell.self)"
    
    private let size = UIScreen.main.bounds
    
    private lazy var cellBackgroundView = UIView().then{
        $0.backgroundColor = UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 0.7)
    }
    
    private lazy var filterAddImageView = UIImageView().then{
        $0.image = UIImage(named: "Cheese_FilterAddImage")
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
        cellBackgroundView.addSubview(filterAddImageView)
    }
    
    private func addLocation(){
        cellBackgroundView.snp.makeConstraints{
            $0.width.height.equalToSuperview()
            cellBackgroundView.layer.cornerRadius = size.width/5.35/2
        }
        
        filterAddImageView.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.width.height.equalToSuperview().dividedBy(4)
        }
    }
}
