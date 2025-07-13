//
//  MockDataManager.swift
//  CurrencyConverter
//
//  Created by Milou on 7/13/25.
//

import Foundation

final class MockDataManager {
    static let shared = MockDataManager()
    private init() {}
    
    func loadMockExchangeRates() -> [String: Double]? {
        guard let url = Bundle.main.url(forResource: "MockExchangeRates", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        do {
            let mockResponse = try JSONDecoder().decode(ExchangeRateResponse.self, from: data)
            return mockResponse.rates
        } catch {
            print("❌ Mock 데이터 파싱 실패: \(error)")
            return nil
        }
    }
    
    func getMockUpdateTime() -> Int64 {
        // JSON에서 직접 가져오기
        return 1752278551
    }
}
