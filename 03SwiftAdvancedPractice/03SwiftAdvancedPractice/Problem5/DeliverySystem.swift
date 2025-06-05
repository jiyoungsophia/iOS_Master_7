//
//  DeliverySystem.swift
//  03SwiftAdvancedPractice
//
//  Created by 지영 on 6/5/25.
//

import Foundation

func predictDeliveryDay(for address: String, status: DeliveryStatus) throws -> String {
    if address.isEmpty {
        throw DeliveryError.invalidAddress
    }
    
    switch status {
    case .notStarted:
        throw DeliveryError.notStarted
    case .inTrasit(daysRemaining: let daysRemaining):
        return "배송까지 \(daysRemaining)일 남았습니다."
    case .error:
        throw DeliveryError.systemError(reason: "system error")
    }
}


func testDeliverySystem(address: String, status: DeliveryStatus) {
    do {
        let result = try predictDeliveryDay(for: address, status: status)
        print(result)
    } catch DeliveryError.invalidAddress {
        print("주소를 입력해주세요.")
    } catch DeliveryError.notStarted {
        print("아직 배송이 시작되지 않았습니다.")
    } catch DeliveryError.systemError(reason: let reason) {
        print("시스템 오류: \(reason)")
    } catch {
        print("알 수 없는 오류")
    }
}
