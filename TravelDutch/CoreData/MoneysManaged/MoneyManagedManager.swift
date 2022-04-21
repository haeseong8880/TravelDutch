//
//  MoneyManagedManager.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/21.
//

import UIKit
import CoreData

class MoneyManagedManager {
    static let shared: MoneyManagedManager = MoneyManagedManager()
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "MoneysManage"
    
    func getMemberMoney(ascending: Bool = false) -> [MoneysManaged] {
        var models: [MoneysManaged] = [MoneysManaged]()
        
        if let context = context {
            let idSort: NSSortDescriptor = NSSortDescriptor(key: "id", ascending: ascending)
            let fetchRequest: NSFetchRequest<NSManagedObject>
            = NSFetchRequest<NSManagedObject>(entityName: modelName)
            fetchRequest.sortDescriptors = [idSort]
            
            do {
                if let fetchResult: [MoneysManaged] = try context.fetch(fetchRequest) as? [MoneysManaged] {
                    models = fetchResult
                }
            } catch let error as NSError {
                print("Could not fetch🥺: \(error), \(error.userInfo)")
            }
        }
        print("MemberMoney Get => \(models)")
        return models
    }
    
    func saveMemberMoney(payType: String, whereUseMoney: String, useMoney: String, onSuccess: @escaping ((Bool) -> Void)) {
        if let context = context,
           let entity: NSEntityDescription
            = NSEntityDescription.entity(forEntityName: modelName, in: context) {
            
            if let req: MoneysManaged = NSManagedObject(entity: entity, insertInto: context) as? MoneysManaged{
                req.payType = payType
                req.whereUseMoney = whereUseMoney
                req.useMoney = useMoney
                
                contextSave { success in
                    onSuccess(success)
                }
            }
        }
    }
    
    func deleteMemberMoney(id: Int64, onSuccess: @escaping ((Bool) -> Void)) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = filteredRequest(id: id)
        do {
            if let results: [MoneysManaged] = try context?.fetch(fetchRequest) as? [MoneysManaged] {
                if results.count != 0 {
                    context?.delete(results[Int(id)])
                }
            }
        } catch let error as NSError {
            print("Could not fatch🥺: \(error), \(error.userInfo)")
            onSuccess(false)
        }
        
        contextSave { success in
            onSuccess(success)
        }
    }
}

extension MoneyManagedManager {
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
