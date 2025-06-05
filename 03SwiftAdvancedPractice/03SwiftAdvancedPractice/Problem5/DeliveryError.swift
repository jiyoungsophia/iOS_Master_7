//
//  DeliveryError.swift
//  03SwiftAdvancedPractice
//
//  Created by 지영 on 6/5/25.
//

import Foundation

enum DeliveryError: Error {
    case invalidAddress
    case notStarted
    case systemError(reason: String)
}
