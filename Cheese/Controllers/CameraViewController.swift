//
//  CameraViewController.swift
//  Cheese
//
//  Created by 김유진 on 2022/06/22.
//

import UIKit
import AVFoundation

final class CameraViewController: UIViewController {
    
    // MARK: - Properties
    private let size = UIScreen.main.bounds

    private lazy var cameraHeaderView = CameraHeaderView().then{
        $0.filterButton.addTarget(self, action: #selector(filterButtonClicked(sender:)), for: .touchUpInside)
    }
    
    private lazy var cameraBottomView = CameraBottomView().then{
        $0.cameraButton.addTarget(self, action: #selector(cameraButtonClicked(sender:)), for: .touchUpInside)
    }
    
    private lazy var filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then{
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 20
        $0.collectionViewLayout = layout
        $0.showsHorizontalScrollIndicator = false
        $0.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.reuseId)
        $0.register(FilterAddCollectionViewCell.self, forCellWithReuseIdentifier: FilterAddCollectionViewCell.reuseId)
        $0.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
    }
    
    private lazy var cameraView = UIView()
    private var captureSession: AVCaptureSession!
    private var stillImageOutput: AVCapturePhotoOutput!
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
            else {
                print("Unable to access back camera!")
                return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            
            stillImageOutput = AVCapturePhotoOutput()

            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
    }
    
    func setupLivePreview() {
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer.videoGravity = .resizeAspect
        videoPreviewLayer.connection?.videoOrientation = .portrait
        cameraView.layer.addSublayer(videoPreviewLayer)
        
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.cameraView.bounds
            }
        }
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
        [cameraView, filterCollectionView, cameraBottomView, cameraHeaderView].forEach{ view.addSubview($0) }
    }
    
    private func addLocation(){
        filterCollectionView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(3.15)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        cameraHeaderView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(view.frame.height/18.45)
            $0.left.right.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(9.49)
        }
        
        cameraBottomView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(4.5)
        }
        
        cameraView.snp.makeConstraints{
            $0.width.centerX.equalToSuperview()
            $0.top.equalTo(cameraHeaderView.snp.bottom)
            $0.bottom.equalTo(cameraBottomView.snp.top)
        }
    }
    
    // MARK: - Animation
    private func upAnimation(){
        filterCollectionView.snp.remakeConstraints{
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(3.15)
            $0.bottom.equalTo(cameraBottomView.snp.top)
        }
    }
    
    private func downAnimation(){
        filterCollectionView.snp.remakeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(3.15)
            $0.top.equalTo(view.snp.bottom)
        }
    }
    
    private func startAnimation(){
        UIView.animate(
          withDuration: 0.4,
          animations: view.layoutIfNeeded
        )
    }
    
    // MARK: - Selectors
    @objc func filterButtonClicked(sender: UIButton){
        if cameraHeaderView.filterButtonClicked {
            print("down")
            downAnimation()
        }else{
            print("up")
            upAnimation()
        }
        startAnimation()
        cameraHeaderView.filterButtonClicked = !(cameraHeaderView.filterButtonClicked)
    }
    
    @objc func cameraButtonClicked(sender: UIButton){
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
                stillImageOutput.capturePhoto(with: settings, delegate: self)
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

extension CameraViewController: AVCapturePhotoCaptureDelegate{
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        let vc = SaveViewController()
        let image = UIImage(data: imageData)
        vc.pictureImageView.image = image
        navigationController?.pushViewController(vc, animated: true)
    }
}
