//
//  MembersMoney+CoreDataProperties.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/21.
//
//

import Foundation
import CoreData


extension MembersMoney {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MembersMoney> {
        return NSFetchRequest<MembersMoney>(entityName: "MembersMoney")
    }

    @NSManaged public var getMoney: Int64
    @NSManaged public var memberName: String?

}

extension MembersMoney : Identifiable {

}
