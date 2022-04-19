//
//  TravelMapViewController.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/09.
//

import UIKit
import MapKit
import WebKit

class TravelMapViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: - Properties
    private var mapView: MKMapView = MKMapView()
    private let kakaoMapRepository = KakaoMapRepository()
    var destinationText: String?
    
    private let destLabel = UILabel().then {
        $0.text = "목적지 ➡"
        $0.font = .systemFont(ofSize: 22, weight: .semibold)
    }
    
    private let destinationLabel = UILabel().then {
        $0.text = ""
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 18, weight: .light)
    }
    
    private let destinationSearchButton = UIButton().then {
        $0.setTitle("주소 검색", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
        $0.isHidden = true
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(openKakaoPost), for: .touchUpInside)
    }
    
    private let copyButtton = UIButton().then {
        $0.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        $0.addTarget(self, action: #selector(copyClipboard), for: .touchUpInside)
    }
    
    // MARK: - Action
    @objc private func copyClipboard() {
        UIPasteboard.general.string = self.destinationLabel.text
        self.showToast(message: "주소 저장이 완료 되었습니다." )
    }
    
    @objc private func openKakaoPost() {
        let kakaoZipCodeVC = KakaoZipCodeVC()
        kakaoZipCodeVC.delegate = self
        
        self.present(kakaoZipCodeVC, animated: true)
    }
    
    private func showToast(message : String, font: UIFont = UIFont.systemFont(ofSize: 20.0)) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width / 2 - 150, y: self.view.frame.size.height - 150, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0,
                       delay: 1,
                       options: .curveEaseOut,
                       animations: { toastLabel.alpha = 0.0 },
                       completion: { (isCompleted) in toastLabel.removeFromSuperview()})
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstDataLoad()
        configure()
        layout()
    }
    
    // MARK: - configure
    private func configure() {
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "여행 📍"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func firstDataLoad() {
        let firstCoreData: [Destination] = DestinationManager.shared.getDestination()
        DispatchQueue.main.async {
            if firstCoreData.isEmpty {
                self.copyButtton.isHidden = true
                self.destinationLabel.isHidden = true
                self.destinationSearchButton.isHidden = false
            } else {
                self.copyButtton.isHidden = false
                self.destinationLabel.isHidden = false
                self.destinationSearchButton.isHidden = true
                self.destinationLabel.text = firstCoreData.first?.destination_ko
                self.setAnnotation(latitudeValue: firstCoreData.first!.latitude, longitudeValue: firstCoreData.first!.longitude, delta: 0.005, title: "목적지", subtitle: "목적지")
            }
        }
    }
    
    // MARK: - layout
    private func layout() {
        [ destLabel, destinationLabel, destinationSearchButton, copyButtton, mapView ].forEach { view.addSubview($0) }
        
        destLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(20)
            $0.width.equalTo(100)
        }
        
        destinationLabel.snp.makeConstraints {
            $0.top.equalTo(destLabel.snp.top)
            $0.leading.equalTo(destLabel.snp.trailing)
            $0.trailing.equalToSuperview().inset(30)
        }
        
        destinationSearchButton.snp.makeConstraints {
            $0.top.equalTo(destinationLabel.snp.top).inset(-8)
            $0.leading.equalTo(destLabel.snp.trailing).offset(50)
            $0.width.equalTo(150)
        }
        
        copyButtton.snp.makeConstraints {
            $0.top.equalTo(destLabel.snp.top)
            $0.leading.equalTo(destinationLabel.snp.trailing)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(destLabel.snp.bottom).offset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(5)
        }
    }
}

extension TravelMapViewController: sendDataDelegate {
    func sendData(address: String) {
        kakaoMapRepository.fetchKaKaoApi(of: address) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(result):
                guard let latitude = Double(result.documents.first!.y), let longitude = Double(result.documents.first!.x) else { return }
                self.setAnnotation(latitudeValue: latitude, longitudeValue: longitude, delta: 0.005, title: "목적지", subtitle: "목적지")
                DestinationManager.shared.saveDestination(destination_ko: address, latitude: latitude, longitude: longitude) { result in
                    if result {
                        DispatchQueue.main.async {
                            self.copyButtton.isHidden = false
                            self.destinationLabel.isHidden = false
                            self.destinationSearchButton.isHidden = true
                            self.destinationLabel.text = address
                        }
                    }
                }
                
            case let .failure(error):
                debugPrint("Error : \(error)")
            }
        }
    }
    
    // 위도와 경도, 스팬(영역 폭)을 입력받아 지도에 표시
    func goLocation(latitudeValue: CLLocationDegrees,
                    longtudeValue: CLLocationDegrees,
                    delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longtudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        mapView.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    // 특정 위도와 경도에 핀 설치하고 핀에 타이틀과 서브 타이틀의 문자열 표시
    func setAnnotation(latitudeValue: CLLocationDegrees,
                       longitudeValue: CLLocationDegrees,
                       delta span :Double,
                       title strTitle: String,
                       subtitle strSubTitle:String){
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longtudeValue: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubTitle
        mapView.addAnnotation(annotation)
    }
}
