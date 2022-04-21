//
//  PersonViewController.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/09.
//

import UIKit

class PersonViewController: UIViewController {
    
    // MARK: - Properties
    private let personTableView = PersonTableView()
    
    private let travelLabel = UILabel().then {
        $0.text = "여행 갈 멤버를 등록해주세요 💁‍♂️"
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.sizeThatFits(CGSize(width: 100, height: 100))
    }
    
    private let noticeLabel = UILabel().then {
        $0.text = "💡 수정을 원할 시 옆으로 슬라이드 해주세요"
        $0.font = .systemFont(ofSize: 15, weight: .light)
    }
    
    private let memberTextField = UITextField().then {
        $0.placeholder = "멤버 입력"
        $0.borderStyle = .roundedRect
        $0.font = .systemFont(ofSize: 24, weight: .light)
        $0.layer.borderWidth = 0.3
        $0.layer.cornerRadius = 5
        if UITraitCollection.current.userInterfaceStyle == .dark { $0.layer.borderColor = UIColor.white.cgColor }
    }
    
    private let moneyTextField = UITextField().then {
        $0.placeholder = "금액 입력"
        $0.borderStyle = .roundedRect
        $0.keyboardType = .numberPad
        $0.font = .systemFont(ofSize: 24, weight: .light)
        $0.layer.borderWidth = 0.3
        $0.layer.cornerRadius = 5
        if UITraitCollection.current.userInterfaceStyle == .dark { $0.layer.borderColor = UIColor.white.cgColor }
    }
    
    private let memberAddButton = UIButton().then {
        $0.setTitle("등록", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor.systemBlue
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(memberAddAction), for: .touchUpInside)
    }
    
    @objc private func memberAddAction() {
        self.view.endEditing(true)
        // 나중에 필터링 필요
        
        guard let name = memberTextField.text else { return }
        guard let money = moneyTextField.text else { return }
        if name.isEmpty || money.isEmpty {
            return alert()
        }else {
            MemberMoneyManager.shared.saveMemberMoney(memberName: name, getMoney: Int64(money)!) { [weak self] result in
                guard let self = self else { return }
                self.personTableView.tableReload(member: MemberEntity(name: name, money: money + "원"))
                self.memberTextField.text = nil
                self.moneyTextField.text = nil
            }
        }
    }
    
    func alert() {
        let alert = UIAlertController(title: "멤버 또는 금액을 입력해주세요.",message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstCoreData: [MembersMoney] = MemberMoneyManager.shared.getMemberMoney()
        if !firstCoreData.isEmpty {
            firstCoreData.forEach { result in
                print("Object id => \(result.objectID.entity)")
                self.personTableView.tableReload(member: MemberEntity(name: result.memberName!, money: String(result.getMoney) + "원"))
            }
        }
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
        [ travelLabel, noticeLabel, memberTextField, moneyTextField, memberAddButton, personTableView ].forEach { view.addSubview($0) }
        
        travelLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }
        
        noticeLabel.snp.makeConstraints {
            $0.top.equalTo(travelLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }
        
        memberTextField.snp.makeConstraints {
            $0.top.equalTo(noticeLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(150)
        }
        
        moneyTextField.snp.makeConstraints {
            $0.top.equalTo(noticeLabel.snp.bottom).offset(5)
            $0.leading.equalTo(memberTextField.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(200)
        }
        
        memberAddButton.snp.makeConstraints {
            $0.top.equalTo(moneyTextField.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(100)
            $0.trailing.equalToSuperview().inset(100)
            $0.height.equalTo(40)
        }
        
        personTableView.snp.makeConstraints {
            $0.top.equalTo(memberAddButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(30)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
    }
}
