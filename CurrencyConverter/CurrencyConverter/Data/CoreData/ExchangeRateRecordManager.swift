//
//  ExchangeRateRecordManager.swift
//  CurrencyConverter
//
//  Created by Milou on 7/13/25.
//

import Foundation
import CoreData

protocol ExchangeRateRecordManagerProtocol {
    func saveRecords(rates: [String: Double], trends: [String: TrendDirection], updateTime: Int64) // Create
    func getLastUpdateTime() -> Int64? // Read
    func getLastRates() -> [String: Double] // Read
    func getTrendRecords() -> [String: TrendDirection] // Read
}

final class ExchangeRateRecordManager: ExchangeRateRecordManagerProtocol {
    
    static let shared = ExchangeRateRecordManager()
    private init() {}
    
    private var context: NSManagedObjectContext {
        return CoreDataManager.shared.context
    }
    
    // MARK: - CRUD
    
    /// Create
    func saveRecords(
        rates: [String: Double],
        trends: [String: TrendDirection],
        updateTime: Int64
    ) {
        deleteAllRecords()
        
        for (currency, rate) in rates {
            let trend = trends[currency] ?? .none
            _ = ExchangeRateRecord(
                currencyCode: currency,
                rate: rate,
                trend: trend,
                lastUpdateTime: updateTime,
                context: context
            )
        }
        
        saveContext()
    }
    
    /// Read
    func getLastUpdateTime() -> Int64? {
        let request = ExchangeRateRecord.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "lastUpdateTime", ascending: false)]
        request.fetchLimit = 1
        
        do {
            let records = try context.fetch(request)
            
            // 저장된 데이터가 없으면 Mock 시간 사용
            if let lastTime = records.first?.lastUpdateTime {
                return lastTime
            } else {
                return MockDataManager.shared.getMockUpdateTime()
            }
        } catch {
            print("업데이트 시간 조회 실패: \(error)")
            return nil
        }
    }
    
    /// Read
    func getLastRates() -> [String : Double] {
        let request = ExchangeRateRecord.fetchRequest()
        
        do {
            let records = try context.fetch(request)
            
            // 저장된 데이터가 없으면 Mock 데이터 사용
            if records.isEmpty {
                return MockDataManager.shared.loadMockExchangeRates() ?? [:]
            }
            
            var rates: [String: Double] = [:]
            for record in records {
                rates[record.currencyCode ?? ""] = record.rate
            }
            
            return rates
        } catch {
            print("환율 조회 실패: \(error)")
            return [:]
        }
    }
    
    /// Read
    func getTrendRecords() -> [String : TrendDirection] {
        let request = ExchangeRateRecord.fetchRequest()
        
        do {
            let records = try context.fetch(request)
            var trends: [String: TrendDirection] = [:]
            
            for record in records {
                trends[record.currencyCode ?? ""] = TrendDirection(rawValue: record.trend ?? "")
            }
            
            return trends
        } catch {
            print("트렌드 조회 실패: \(error)")
            return [:]
        }
    }
    
    // MARK: - Private Methods
    
    private func deleteAllRecords() {
        let request = ExchangeRateRecord.fetchRequest()
        
        do {
            let Records = try context.fetch(request)
            for record in Records {
                context.delete(record)
            }
        } catch {
            print("캐시 삭제 실패: \(error)")
        }
    }
    
    private func saveContext() {
        CoreDataManager.shared.saveContext()
    }
    
}
