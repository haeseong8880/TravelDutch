//
//  KakaoMapEntity.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/18.
//

import Foundation

// MARK: - KakaoMapEntity
struct KakaoMapEntity: Codable {
    let meta: Meta
    let documents: [Document]
}

// MARK: - Document
struct Document: Codable {
    let addressName,x, y, addressType: String

    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case y, x
        case addressType = "address_type"
    }
}

// MARK: - Meta
struct Meta: Codable {
    let totalCount, pageableCount: Int
    let isEnd: Bool

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case pageableCount = "pageable_count"
        case isEnd = "is_end"
    }
}
