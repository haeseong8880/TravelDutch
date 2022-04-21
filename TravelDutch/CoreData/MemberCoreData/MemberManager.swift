//
//  MemberManager.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/20.
//

import UIKit
import CoreData

class MemberMoneyManager {
    static let shared: MemberMoneyManager = MemberMoneyManager()
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "MembersMoney"
    
    func getMemberMoney(ascending: Bool = false) -> [MembersMoney] {
        var models: [MembersMoney] = [MembersMoney]()
        
        if let context = context {
            let idSort: NSSortDescriptor = NSSortDescriptor(key: "id", ascending: ascending)
            let fetchRequest: NSFetchRequest<NSManagedObject>
            = NSFetchRequest<NSManagedObject>(entityName: modelName)
            fetchRequest.sortDescriptors = [idSort]
            
            do {
                if let fetchResult: [MembersMoney] = try context.fetch(fetchRequest) as? [MembersMoney] {
                    models = fetchResult
                }
            } catch let error as NSError {
                print("Could not fetch🥺: \(error), \(error.userInfo)")
            }
        }
        print("MemberMoney Get => \(models)")
        return models
    }
    
    func saveMemberMoney(memberName: String, getMoney: Int64, onSuccess: @escaping ((Bool) -> Void)) {
        if let context = context,
           let entity: NSEntityDescription
            = NSEntityDescription.entity(forEntityName: modelName, in: context) {
            
            if let req: MembersMoney = NSManagedObject(entity: entity, insertInto: context) as? MembersMoney{
                req.memberName = memberName
                req.getMoney = getMoney
                
                contextSave { success in
                    onSuccess(success)
                }
            }
        }
    }
    
    func deleteMemberMoney(id: Int64, onSuccess: @escaping ((Bool) -> Void)) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = filteredRequest(id: id)
        do {
            if let results: [MembersMoney] = try context?.fetch(fetchRequest) as? [MembersMoney] {
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

extension MemberMoneyManager {
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
