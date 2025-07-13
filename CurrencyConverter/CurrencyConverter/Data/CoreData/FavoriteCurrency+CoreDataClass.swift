//
//  FavoriteCurrency+CoreDataClass.swift
//  CurrencyConverter
//
//  Created by Milou on 7/11/25.
//
//

import Foundation
import CoreData

@objc(FavoriteCurrency)
public class FavoriteCurrency: NSManagedObject {

    convenience init(currencyCode: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.currencyCode = currencyCode
    }
}

extension FavoriteCurrency {
    
    /// 특정 통화 코드로 즐겨찾기 검색
    static func fetchRequest(for currencyCode: String) -> NSFetchRequest<FavoriteCurrency> {
        let request = FavoriteCurrency.fetchRequest()
        request.predicate = NSPredicate(format: "currencyCode == %@", currencyCode)
        request.fetchLimit = 1
        return request
    }
    
    /// 모든 즐겨찾기 통화 코드 조회 (알파벳 순 정렬)
    static func fetchAllCurrencyCodes(context: NSManagedObjectContext) -> [String] {
        let request = FavoriteCurrency.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "currencyCode", ascending: true)]
        
        do {
            let favorites = try context.fetch(request)
            return favorites.map { $0.currencyCode ?? "" }
        } catch {
            print("즐겨찾기 조회 실패: \(error)")
            return []
        }
    }
    
    /// 즐겨찾기 존재 여부 확인
    static func exists(currencyCode: String, context: NSManagedObjectContext) -> Bool {
        let request = fetchRequest(for: currencyCode)
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("즐겨찾기 존재 확인 실패: \(error)")
            return false
        }
    }
}
