//
//  MoneyManagedManager.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/21.
//

import UIKit
import CoreData

class MoneyManageManager {
    static let shared: MoneyManageManager = MoneyManageManager()

    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllMoneyManage() -> [MoneyManage] {
        var models: [MoneyManage] = [MoneyManage]()
        do {
            if let result = try context.fetch(MoneyManage.fetchRequest()) {
                models = result
            }
        }
        catch {
            print("getAllItems Error => \(error.localizedDescription)")
        }
        return models
    }
    
    func createItem(timeStamp: Date, payComment: String, payType: String, moneyHistory: String) -> Bool {
        let insertItem = MoneyManage(context: context)
        insertItem.timeStamp = timeStamp
        insertItem.payComment = payComment
        insertItem.payType = payType
        insertItem.moneyHistory = moneyHistory
        do {
            try context?.save()
            return true
        }
        catch {
            print("createItem Error => \(error.localizedDescription)")
            return false
        }
    }
    
//    func deleteItem(item: MembersMoney) {
//        context?.delete(item)
//        do {
//            try context?.save()
//        }
//        catch {
//
//        }
//    }
    
//    func updateItem(item: MembersMoney, name: String) {
//        item.memberName = name
//        do {
//            try context?.save()
//        }
//        catch {
//
//        }
//    }
}
