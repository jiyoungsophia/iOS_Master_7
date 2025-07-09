//
//  ExchangeRateViewModel.swift
//  CurrencyConverter
//
//  Created by Milou on 7/8/25.
//

import Foundation

class ExchangeRateViewModel {
    private let exchangeRateService = ExchangeRateService()
    
    private var allExchangeRates: [ExchangeRate] = []
    
    private(set) var exchangeRates: [ExchangeRate] = [] {
        didSet {
            self.onExchangeRateChanged?()
        }
    }
    
    private(set) var errorMessage: String? {
        didSet {
            if let errorMessage = errorMessage {
                self.onErrorOccurred?(errorMessage)
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
                self?.allExchangeRates = rates
                self?.exchangeRates = rates
                
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                self?.allExchangeRates = []
                self?.exchangeRates = []
            }
        }
    }
    
    func filterExchangeRates(with searchText: String) {
        if searchText.isEmpty {
            exchangeRates = allExchangeRates
        } else {
            exchangeRates = allExchangeRates.filter { rate in
                rate.currency.localizedCaseInsensitiveContains(searchText) || rate.country.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
