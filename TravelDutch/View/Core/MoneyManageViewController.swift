//
//  MoneyManageViewController.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/11.
//

import UIKit

class MoneyManageViewcontroller: UIViewController {
    
    // MARK: - Properties
    private let moneyManageTableView = MoneyManageTableView()
    
    var pickerList = ["교통 🚎", "숙박 🏨", "식비 🍚", "쇼핑 🛍", "기타"]
    
    var toolbar: UIToolbar!
    var exitBtn: UIBarButtonItem!
    var picker: UIPickerView!
    
    private let noticeLabel = UILabel().then {
        $0.text = "모인 금액 ➡️ "
        $0.font = .systemFont(ofSize: 22, weight: .bold)
    }
    
    private let totalLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .right
    }
    
    private let usedTypeLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .light)
        $0.text = "지출 종류 선택 ➡️ "
    }
    
    private let usedCommentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .light)
        $0.text = "사용처 입력 ➡️ "
    }
    
    private let usedMoneyLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .light)
        $0.text = "사용 금액 입력 ➡️ "
    }
    
    private let moneyHistoryLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 30, weight: .bold)
        $0.text = "사용 내역 📝"
    }
    
    private let calUsedLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .right
    }
    
    private let usedTypeTextField = UITextField().then {
        $0.font = .systemFont(ofSize: 22, weight: .light)
        $0.borderStyle = .roundedRect
        $0.layer.borderWidth = 0.5
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.darkGray.cgColor
        $0.setPlaceholderColor(.systemGray)
    }
    
    private let usedCommentTextField = UITextField().then {
        $0.font = .systemFont(ofSize: 22, weight: .light)
        $0.borderStyle = .roundedRect
        $0.layer.borderWidth = 0.5
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.darkGray.cgColor
        $0.setPlaceholderColor(.systemGray)
    }
    
    private let usedMoneyTextField = UITextField().then {
        $0.font = .systemFont(ofSize: 22, weight: .light)
        $0.borderStyle = .roundedRect
        $0.layer.borderWidth = 0.5
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.darkGray.cgColor
        $0.keyboardType = .numberPad
        $0.setPlaceholderColor(.systemGray)
    }
    
    private let moneyAddButton = UIButton().then {
        $0.setTitle("등록", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(moneyAddAction), for: .touchUpInside)
    }
    
    private let payUsedLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 22, weight: .bold)
        $0.text = "계산 된 금액 💸"
    }
    
    private let payUsedCalLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .right
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        layout()
        pickerConfigure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.getTotalMoneyCal()
            self.usedTotalMoneyCal()
            self.totalMoneyCal()
        }
    }
    
    private func getTotalMoneyCal() {
        let memberMoneyList: [MemberModel] = MemberManager.shared.getAllMember()
        var totalMoney: Int = 0
        if !memberMoneyList.isEmpty {
            memberMoneyList.forEach {
                totalMoney += Int($0.money)!
            }
        }
        totalLabel.text = "\(totalMoney)원"
    }
    
    private func usedTotalMoneyCal() {
        let moneyHisotryList: [MoneyHistoryModel] = MoneyHistoryManager.shared.getAllMoneyHistory()
        var totalMoney: Int = 0
        if !moneyHisotryList.isEmpty {
            moneyHisotryList.forEach {
                totalMoney += Int($0.moneyHistory)!
            }
        }
        calUsedLabel.text = "\(totalMoney)원"
    }
    
    private func totalMoneyCal() {
        let memberMoney: Int = Int(totalLabel.text!.replacingOccurrences(of: "원", with: ""))!
        let moneyHistory: Int = Int(calUsedLabel.text!.replacingOccurrences(of: "원", with: ""))!
        
        payUsedCalLabel.text = "\(memberMoney - moneyHistory)원"
    }
    
    // MARK: - configure
    private func configure() {
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "돈 관리 💵"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func pickerConfigure() {
        
        picker = UIPickerView()
        picker.delegate = self
        usedTypeTextField.inputView = picker
        
        exitBtn = UIBarButtonItem()
        exitBtn.title = "닫기"
        exitBtn.target = self
        exitBtn.action = #selector(pickerExit)
        
        toolbar = UIToolbar()
        toolbar.tintColor = .darkGray
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 40)
        toolbar.setItems([exitBtn], animated: true)
        
        usedTypeTextField.inputAccessoryView = toolbar
    }
    
    // MARK: - Layout
    private func layout() {
        [ noticeLabel, totalLabel, usedTypeLabel, usedTypeTextField, usedCommentLabel, usedCommentTextField, usedMoneyLabel, usedMoneyTextField, moneyAddButton, moneyHistoryLabel, moneyManageTableView, calUsedLabel, payUsedLabel, payUsedCalLabel ].forEach { view.addSubview($0) }
        
        noticeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(120)
        }
        
        totalLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.equalTo(noticeLabel.snp.trailing).inset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        usedTypeLabel.snp.makeConstraints {
            $0.top.equalTo(noticeLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo((UIScreen.main.bounds.width / 2) - 30)
        }
        
        usedTypeTextField.snp.makeConstraints {
            $0.top.equalTo(noticeLabel.snp.bottom).offset(10)
            $0.leading.equalTo(usedTypeLabel.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        usedCommentLabel.snp.makeConstraints {
            $0.top.equalTo(usedTypeLabel.snp.bottom).offset(25)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo((UIScreen.main.bounds.width / 2) - 30)
        }
        
        usedCommentTextField.snp.makeConstraints {
            $0.top.equalTo(usedTypeLabel.snp.bottom).offset(20)
            $0.leading.equalTo(usedTypeLabel.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        usedMoneyLabel.snp.makeConstraints {
            $0.top.equalTo(usedCommentLabel.snp.bottom).offset(25)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo((UIScreen.main.bounds.width / 2) - 30)
        }
        
        usedMoneyTextField.snp.makeConstraints {
            $0.top.equalTo(usedCommentLabel.snp.bottom).offset(20)
            $0.leading.equalTo(usedMoneyLabel.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        moneyAddButton.snp.makeConstraints {
            $0.top.equalTo(usedMoneyLabel.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(100)
        }
        
        moneyHistoryLabel.snp.makeConstraints {
            $0.top.equalTo(moneyAddButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(180)
        }
        
        calUsedLabel.snp.makeConstraints {
            $0.top.equalTo(moneyHistoryLabel.snp.top).inset(5)
            $0.trailing.equalToSuperview().inset(10)
            $0.leading.equalTo(moneyHistoryLabel.snp.trailing).inset(30)
        }
        
        moneyManageTableView.snp.makeConstraints {
            $0.top.equalTo(moneyHistoryLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(payUsedLabel.snp.top)
        }
        
        payUsedLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.width.equalTo(180)
        }
        
        payUsedCalLabel.snp.makeConstraints {
            $0.top.equalTo(payUsedLabel.snp.top).inset(5)
            $0.trailing.equalToSuperview().inset(10)
            $0.leading.equalTo(payUsedLabel.snp.trailing).inset(30)
        }
        
    }
    
    // MARK: - action
    @objc func pickerExit() {
        self.view.endEditing(true)
    }
    
    @objc func moneyAddAction() {
        let history = MoneyHistoryModel()
        let today = Date()
        
        history.moneyHistory = usedMoneyTextField.text!
        history.payType = usedTypeTextField.text!
        history.payComment = usedCommentTextField.text!
        history.timeStamp = today.toString()
        MoneyHistoryManager.shared.saveMoneyHistory(history: history) {
            if $0 {
                self.moneyManageTableView.tableReload(history: history)
                self.usedTypeTextField.text = nil
                self.usedMoneyTextField.text = nil
                self.usedCommentTextField.text = nil
                self.picker = nil
                self.getTotalMoneyCal()
                self.usedTotalMoneyCal()
                self.totalMoneyCal()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}

extension MoneyManageViewcontroller : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerList[row])
        usedTypeTextField.text = pickerList[row]
        self.view.endEditing(true)
    }
}

