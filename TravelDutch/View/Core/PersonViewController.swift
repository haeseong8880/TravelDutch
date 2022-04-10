//
//  PersonViewController.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/09.
//

import UIKit

class PersonViewController: UIViewController {
    
    // MARK: - Properties
    private let travelLabel = UILabel().then {
        $0.text = "함께 여행 갈 멤버를 등록해주세요 💁‍♂️"
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.sizeThatFits(CGSize(width: 100, height: 100))
    }
    
    private let travelMemberTextField = UITextField().then {
        $0.placeholder = "같이 여행 할 멤버를 입력해주세요"
        $0.borderStyle = .roundedRect
        $0.font = .systemFont(ofSize: 24, weight: .light)
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
        self.navigationItem.title = "여행 멤버"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
   }
    
    // MARK: - layout
    private func layout() {
        [ travelLabel, travelMemberTextField ].forEach { view.addSubview($0) }
        
        travelLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }
        
        travelMemberTextField.snp.makeConstraints {
            $0.top.equalTo(travelLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }
    }
}
