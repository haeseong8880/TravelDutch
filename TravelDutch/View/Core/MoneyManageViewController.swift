//
//  MoneyManageViewController.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/11.
//

import UIKit

class MoneyManageViewcontroller: UIViewController {
    
    // MARK: - Properties
    private var total: Int = 0
    
    private let noticeLabel = UILabel().then {
        $0.text = "총 금액 ➡️ "
        $0.font = .systemFont(ofSize: 22, weight: .bold)
    }
    
    private let totalLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 22, weight: .bold)
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        layout()
        // 임시 텍스트
        totalLabel.text = "40000원"
    }
    
    // MARK: - configure
    private func configure() {
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "돈 관리 💵"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    // MARK: - Layout
    private func layout() {
        [ noticeLabel, totalLabel ].forEach { view.addSubview($0) }
        
        noticeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(120)
        }
        
        totalLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.equalTo(noticeLabel.snp.trailing).inset(10)
        }
    }
}
