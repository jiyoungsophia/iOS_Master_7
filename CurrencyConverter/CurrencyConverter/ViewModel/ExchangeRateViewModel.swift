//
//  ExchangeRateViewModel.swift
//  CurrencyConverter
//
//  Created by Milou on 7/8/25.
//

import Foundation

@MainActor
class ExchangeRateViewModel {
    private let exchangeRateService = ExchangeRateService()
    
    private(set) var exchangeRates: [ExchangeRate] = [] {
        didSet {
            onExchangeRateChanged?()
        }
    }
    
    private(set) var errorMessage: String? {
        didSet {
            if let errorMessage = errorMessage {
                onErrorOccurred?(errorMessage)
            }
        }
    }
    
    var onExchangeRateChanged: (() -> Void)?
    var onErrorOccurred: ((String) -> Void)?
    
    func loadExchangeRates() {
        errorMessage = nil
        
        Task {
            let result = await exchangeRateService.fetchExchangeRate()
            
            switch result {
            case .success(let rates):
                exchangeRates = rates
            case .failure(let error):
                errorMessage = error.localizedDescription
                exchangeRates = []
            }
        }
    }
}
