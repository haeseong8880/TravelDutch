//
//  MettingViewController.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/09.
//

import UIKit
import Then
import SnapKit

class MettingViewController: UIViewController {
    
    // MARK: - Properties
    
    private let mettingTableView = MettingTableView()
    
    private let meetingTitleLabel = UILabel().then {
        $0.text = "⚡️"
        $0.font = .systemFont(ofSize: 20, weight: .regular)
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layout()
    }
    
    // MARK: - configure
    private func configure() {
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "여행 지역"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - layout
    private func layout() {
        [ meetingTitleLabel, mettingTableView ].forEach { view.addSubview($0) }

        meetingTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalToSuperview().offset(20)
        }
        
        mettingTableView.snp.makeConstraints {
            $0.top.equalTo(meetingTitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().offset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
}
