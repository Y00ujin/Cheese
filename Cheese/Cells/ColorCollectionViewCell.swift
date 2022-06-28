//
//  ColorCollectionViewCell.swift
//  Cheese
//
//  Created by 김유진 on 2022/06/23.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let reuseId = "\(ColorCollectionViewCell.self)"
    
    private let size = UIScreen.main.bounds
    
    lazy var cellBackgroundView = UIView().then{
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
    
    // MARK: - Helpers
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
            cellBackgroundView.layer.cornerRadius = size.width/12.5/2
        }
    }
}
