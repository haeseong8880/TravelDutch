//
//  PersonTableView.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/10.
//

import UIKit

class PersonTableView: UITableView {
    
    //MARK: - Properties
    var memberList: [Member] = []
    
    //MARK: - LifeCycle
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.delegate = self
        self.dataSource = self
        
        self.allowsSelection = false
        
        register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableReload(member: Member){
        DispatchQueue.main.async {
            self.memberList.append(member)
            self.reloadData()
        }
    }
    
    func alertForSafeDeletion(indexPath: IndexPath) {
        let alert = UIAlertController(title: nil, message: "멤버를 삭제할까요?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "네", style: .default) { _ in
            self.memberList.remove(at: indexPath.row)
            self.reloadData()
        }
        alert.addAction(yesAction)
        let noAction = UIAlertAction(title: "아니오", style: .cancel) { _ in }
        alert.addAction(noAction)
        self.window?.rootViewController?.present(alert, animated: true)
    }
    
    func popup(titleText: String, placeholderText: String, index: Int, type: ActionStyle) {
        let alert = UIAlertController(title: titleText,message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        alert.addTextField { (textField) in
            textField.placeholder = placeholderText
            if type == .money { textField.keyboardType = .numberPad }
        }
        
        alert.addAction(UIAlertAction(title: "수정", style: .default, handler: {[weak self] action in
            guard let self = self else { return }
            if let result = alert.textFields?.first?.text {
                if type == .name {
                    MemberManager.shared.updateMember(members: self.memberList[index], newData: result, type: .name) { resultBool in
                        if resultBool {
                            self.memberList[index].name = result
                            self.reloadData()
                        }
                    }
                }
                else if type == .money { self.memberList[index].money = result + "원" }
                
            }
        }))
        self.window?.rootViewController?.present(alert, animated: true)
    }
}

// MARK: - Extension
extension PersonTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.id, for: indexPath) as? PersonTableViewCell else { return UITableViewCell() }
        cell.name = memberList[indexPath.row].name
        cell.money = memberList[indexPath.row].money
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let nameEdting = UIContextualAction(style: .normal, title: "이름 수정") { (action, view, completionHandler) in
            self.popup(titleText: "이름 수정", placeholderText: "수정 할 이름을 입력해주세요.", index: indexPath.row, type: .name)
            completionHandler(true)
        }
        let moneyEdting = UIContextualAction(style: .normal, title: "금액 수정") { (action, view, completionHandler) in
            self.popup(titleText: "금액 수정", placeholderText: "수정 할 금액을 입력해주세요.", index: indexPath.row, type: .money)
            completionHandler(true)
        }
        let deleteAction = UIContextualAction(style: .normal, title: "삭제") { (action, view, completionHandler) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                //                MemberMoneyManager.shared.deleteMemberMoney(id: Int64(indexPath.row)) { result in
                //                    if result {
                //                        self.alertForSafeDeletion(indexPath: indexPath)
                //                        completionHandler(true)
                //                    }
                //                }
            }
        }
        
        nameEdting.backgroundColor = .systemBlue
        moneyEdting.backgroundColor = .systemGray
        deleteAction.backgroundColor = .systemRed
        
        let configure = UISwipeActionsConfiguration(actions:[ nameEdting, moneyEdting, deleteAction ])
        configure.performsFirstActionWithFullSwipe = false
        return configure
    }
}
