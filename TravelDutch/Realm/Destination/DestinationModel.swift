//
//  DestinationModel.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/25.
//

import Foundation
import RealmSwift

class Destination: Object {
    @Persisted var id: Int = 0
    @Persisted var destination_ko: String = ""
    @Persisted var latitude: Double = 0.0
    @Persisted var longitude: Double = 0.0
    
    // id 가 고유 값입니다.
    override static func primaryKey() -> String? {
        return "id"
    }
}
