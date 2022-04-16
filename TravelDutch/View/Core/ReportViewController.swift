//
//  PayViewController.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/09.
//

import Foundation
import UIKit

class ReportViewController: UIViewController {
    
    // MARK: - Properties
    var moneyManage: [MoneyManageEntity] = []
    
    private let totalTypeLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24)
    }
    
    private let payLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configure()
        layout()
        presentCircleView()
    }
    
    // MARK: - Configure
    private func configure() {
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "레포트 📊"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        totalTypeLabel.text = "교통" + "에 가장 많은 소비를 하였습니다."
        payLabel.text = "총 지출 금액의 " + "59.3" + "%를 차지합니다."

        self.totalTypeLabel.attributedText = textChangeConfigure(label: totalTypeLabel, item: "교통")
        self.payLabel.attributedText = textChangeConfigure(label: payLabel, item: "59.3")
    }
    
    private func textChangeConfigure(label: UILabel, item: String) -> NSMutableAttributedString {
        guard let text = label.text else { return NSMutableAttributedString() }
        let attributeString = NSMutableAttributedString(string: text)
        let font = UIFont.systemFont(ofSize: 32, weight: .bold)
        attributeString.addAttribute(.foregroundColor, value: UIColor.blue, range: (text as NSString).range(of: item))
        attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: item))
        return attributeString
    }
    
    // MARK: - Layout
    private func layout() {
        [ totalTypeLabel, payLabel ].forEach{ view.addSubview($0) }
        
        totalTypeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.centerX.equalToSuperview()
        }
        
        payLabel.snp.makeConstraints {
            $0.top.equalTo(totalTypeLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func presentCircleView() {
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        let pieChartView = PieChartView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        pieChartView.center = self.view.center
        
        pieChartView.slices = [Slice(percent: 0.4, color: UIColor.systemOrange, text: "가"),
                               Slice(percent: 0.3, color: UIColor.systemTeal, text: "나"),
                               Slice(percent: 0.1, color: UIColor.systemRed, text: "다"),
                               Slice(percent: 0.1, color: UIColor.systemIndigo, text: "라"),
                               Slice(percent: 0.05, color: UIColor.systemBlue, text: "다"),
                               Slice(percent: 0.04, color: UIColor.systemCyan, text: "다"),
                               Slice(percent: 0.01, color: UIColor.systemPink, text: "다")
                               ]
        
        self.view.addSubview(pieChartView)
        pieChartView.animateChart()
    }
}
