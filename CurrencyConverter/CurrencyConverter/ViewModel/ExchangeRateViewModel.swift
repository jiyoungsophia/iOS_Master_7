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
            DispatchQueue.main.async { [weak self] in
                self?.onExchangeRateChanged?()
            }
        }
    }
    
    private(set) var errorMessage: String? {
        didSet {
            if let errorMessage = errorMessage {
                DispatchQueue.main.async { [weak self] in
                    self?.onErrorOccurred?(errorMessage)
                }
            }
        }
    }
    
    var onExchangeRateChanged: (() -> Void)?
    var onErrorOccurred: ((String) -> Void)?
    
    func loadExchangeRates() {
        errorMessage = nil
        
        exchangeRateService.fetchExchangeRate { [weak self] result in
            switch result {
            case .success(let rates):
                self?.exchangeRates = rates
                
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                self?.exchangeRates = []
            }
        }
    }
}
