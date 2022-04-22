//
//  MoneyManage+CoreDataProperties.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/22.
//
//

import Foundation
import CoreData


extension MoneyManage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoneyManage> {
        return NSFetchRequest<MoneyManage>(entityName: "MoneyManage")
    }

    @NSManaged public var payType: String?
    @NSManaged public var timeStamp: Date?
    @NSManaged public var payComment: String?
    @NSManaged public var moneyHistory: String?

}

extension MoneyManage : Identifiable {

}
