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
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "MoneyManage"
    
    func getAllMoneyManage(ascending: Bool = false) -> [MoneyManage] {
        var models: [MoneyManage] = [MoneyManage]()
        
        if let context = context {
            let idSort: NSSortDescriptor = NSSortDescriptor(key: "id", ascending: ascending)
            let fetchRequest: NSFetchRequest<NSManagedObject>
                = NSFetchRequest<NSManagedObject>(entityName: modelName)
            fetchRequest.sortDescriptors = [idSort]
            
            do {
                if let fetchResult: [MoneyManage] = try context.fetch(fetchRequest) as? [MoneyManage] {
                    models = fetchResult
                }
            } catch let error as NSError {
                print("Could not fetch🥺: \(error), \(error.userInfo)")
            }
        }
        print("Destination Get => \(models)")
        return models
    }
    
    func createItem(payComment: String, payType: String, moneyHistory: String, onSuccess: @escaping ((Bool) -> Void)) {
        
        if let context = context,
           let entity: NSEntityDescription
            = NSEntityDescription.entity(forEntityName: modelName, in: context) {
            if let moneyManage : MoneyManage = NSManagedObject(entity: entity, insertInto: context) as? MoneyManage{
                moneyManage.payComment = payComment
                moneyManage.payType = payType
                moneyManage.moneyHistory = moneyHistory
                
                contextSave { success in
                    onSuccess(success)
                }
                
//                do {
//                    try context.save()
//                } catch {
//                    print("Error saving")
//                }
            }
            
            //        if let moneyManage: MoneyManage = MoneyManage(context: context){
            //            moneyManage.moneyHistory = moneyHistory
            //            moneyManage.timeStamp = timeStamp
            //            moneyManage.payType = payType
            //            moneyManage.payComment = payComment
            //
            //        }
            //        do {
            //            try context.save()
            //            contextSave { success in
            //                onSuccess(success)
            //            }
            //        }
            //        catch {
            //            print("createItem Error => \(error.localizedDescription)")
            //
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

extension MoneyManageManager {
    fileprivate func filteredRequest(id: Int64) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
            = NSFetchRequest<NSFetchRequestResult>(entityName: modelName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: id))
        return fetchRequest
    }
    
    fileprivate func contextSave(onSuccess: ((Bool) -> Void)) {
        do {
            try context?.save()
            onSuccess(true)
        } catch let error as NSError {
            print("Could not save🥶: \(error), \(error.userInfo)")
            onSuccess(false)
        }
    }
}

