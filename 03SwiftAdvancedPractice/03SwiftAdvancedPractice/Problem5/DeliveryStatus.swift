//
//  DeliveryStatus.swift
//  03SwiftAdvancedPractice
//
//  Created by 지영 on 6/5/25.
//

import Foundation

enum DeliveryStatus {
    case notStarted
    case inTrasit(daysRemaining: Int)
    case error
}
