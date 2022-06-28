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
    
    private lazy var drawCanvasImageView = UIImageView()
    
    private var lastPoint: CGPoint!
    
    private lazy var lineSize: CGFloat = 5
    
    private lazy var lineColor = UIColor.black.cgColor
    
    private lazy var filterBottomView = FilterBottomView()
    
    private lazy var filterHeaderView = FilterHeaderView().then{
        $0.backButton.addTarget(self, action: #selector(backButtonClicked(sender:)), for: .touchUpInside)
        $0.filterSaveButton.addTarget(self, action: #selector(filterSaveButtonClicked(sender:)), for: .touchUpInside)
    }
    
    private lazy var colorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then{
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 13
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
        $0.showsHorizontalScrollIndicator = false
        $0.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: ColorCollectionViewCell.reuseId)
    }
    
    private lazy var colorArray = [UIColor.rgb(r: 237, g: 177, b: 177),UIColor.rgb(r: 237, g: 206, b: 177),UIColor.rgb(r: 237, g: 231, b: 177),UIColor.rgb(r: 225, g: 237, b: 177),UIColor.rgb(r: 178, g: 237, b: 177),UIColor.rgb(r: 177, g: 237, b: 177),UIColor.rgb(r: 177, g: 222, b: 237),UIColor.rgb(r: 177, g: 187, b: 237),UIColor.rgb(r: 218, g: 177, b: 237)]

    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 현재 발생한 터치 이벤트를 가지고 옴
        let touch = touches.first! as UITouch
        // 터치된 위치를 lastPoint에 할당
        lastPoint = touch.location(in: drawCanvasImageView)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 그림을 그리기 위한 콘텍스트 생성
        UIGraphicsBeginImageContext(drawCanvasImageView.frame.size)
        // 선 색상을 설정
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        // 선 끝 모양을 라운드로 설정
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        // 선 두께를 설정
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        
        // 현재 발생한 터치 이벤트를 가지고 옴
        let touch = touches.first! as UITouch
        // 터치된 좌표를 currPoint로 가지고 옴
        let currPoint = touch.location(in: drawCanvasImageView)
        
        // 현재 imgView에 있는 전체 이미지를 imgView의 크기로 그림
        drawCanvasImageView.image?.draw(in: CGRect(x: 0, y: 0, width: drawCanvasImageView.frame.size.width, height: drawCanvasImageView.frame.size.height))
        
        // lastPoint 위치로 시작 위치를 이동
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        // lastPoint에서 currPoint까지 선을 추가
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currPoint.x, y: currPoint.y))
        // 추가한 선을 콘텍스트에 그림
        UIGraphicsGetCurrentContext()?.strokePath()
        
        // 현재 콘텍스트에 그려진 이미지를 가지고 와서 이미지 뷰에 할당
        drawCanvasImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        // 그림 그리기를 끝냄
        UIGraphicsEndImageContext()
        
        // 현재 터치된 위치를 lastPoint라는 변수에 할당
        lastPoint = currPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(drawCanvasImageView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        
        let touch = touches.first! as UITouch
        let currPoint = touch.location(in: drawCanvasImageView)
        
        drawCanvasImageView.image?.draw(in: CGRect(x: 0, y: 0, width: drawCanvasImageView.frame.size.width, height: drawCanvasImageView.frame.size.height))
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currPoint.x, y: currPoint.y))
        UIGraphicsGetCurrentContext()?.strokePath()
        
        drawCanvasImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    // MARK: - Helpers
    private func setView(){
        view.backgroundColor = .white
        
        addView()
        addLocation()
        addDelegate()
    }
    
    private func addDelegate(){
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
    }
    
    private func addView(){
        [filterHeaderView, filterBottomView, drawCanvasImageView].forEach{ view.addSubview($0) }
        
        filterBottomView.addSubview(colorCollectionView)
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
        
        colorCollectionView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(size.height/80)
            $0.left.equalToSuperview().offset(size.width/17.85)
            $0.right.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        drawCanvasImageView.snp.makeConstraints{
            $0.top.equalTo(filterHeaderView.snp.bottom)
            $0.bottom.equalTo(filterBottomView.snp.top)
            $0.width.equalToSuperview()
            
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
        lineColor = colorArray[indexPath.row].cgColor
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
