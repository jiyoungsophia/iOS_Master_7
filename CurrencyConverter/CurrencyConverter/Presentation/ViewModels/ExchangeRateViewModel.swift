//
//  ExchangeRateViewModel.swift
//  CurrencyConverter
//
//  Created by Milou on 7/8/25.
//

import Foundation

enum ExchangeRateAction {
    case loadExchangeRates
    case filterExchangeRates(String)
    case toggleFavorite(String)
}

struct ExchangeRateState {
    var allExchangeRates: [ExchangeRate]
    var filteredExchangeRates: [ExchangeRate]
    var favoriteCurrencies: Set<String>
    var currentSearchText: String
    var errorMessage: String?
    
    init() {
        self.allExchangeRates = []
        self.filteredExchangeRates = []
        self.favoriteCurrencies = []
        self.currentSearchText = ""
        self.errorMessage = nil
    }
}

class ExchangeRateViewModel: ViewModelProtocol {
    
    private let exchangeRateService: ExchangeRateService
    private let favoriteCurrencyManager: FavoriteCurrencyManagerProtocol 
    
    typealias Action = ExchangeRateAction
    typealias State = ExchangeRateState
    
    var action: ((ExchangeRateAction) -> Void)?
    
    private(set) var state: ExchangeRateState {
        didSet {
            self.onStateChanged?()
        }
    }
    
    var onStateChanged: (() -> Void)?
    
    init(
        exchangeRateService: ExchangeRateService = ExchangeRateService(),
        favoriteCurrencyManager: FavoriteCurrencyManagerProtocol = FavoriteCurrencyManager.shared
    ) {
        self.exchangeRateService = exchangeRateService
        self.favoriteCurrencyManager = favoriteCurrencyManager
        self.state = ExchangeRateState()
        
        loadFavoritesFromCoreData()
        
        self.action = { [weak self] action in
            self?.handleAction(action)
        }
    }
    
    private func handleAction(_ action: ExchangeRateAction) {
        switch action {
        case .loadExchangeRates:
            self.loadExchangeRates()
        case .filterExchangeRates(let searchText):
            self.filterExchangeRates(with: searchText)
        case .toggleFavorite(let currency):
            self.toggleFavorite(currency)
        }
    }
    
    func loadExchangeRates() {
        state.errorMessage = nil
        
        exchangeRateService.fetchExchangeRate { [weak self] result in
            switch result {
            case .success(let rates):
                self?.state.allExchangeRates = rates
                self?.state.filteredExchangeRates = self?.sortExchangeRates(rates) ?? []
                
            case .failure(let error):
                self?.state.errorMessage = error.localizedDescription
                self?.state.allExchangeRates = []
                self?.state.filteredExchangeRates = []
            }
        }
    }
    
    func filterExchangeRates(with searchText: String) {
        state.currentSearchText = searchText
        let baseRates: [ExchangeRate]
        
        if searchText.isEmpty {
            baseRates = state.allExchangeRates
        } else {
            baseRates = state.allExchangeRates.filter { rate in
                rate.currency.localizedCaseInsensitiveContains(searchText) || rate.country.localizedCaseInsensitiveContains(searchText)
            }
        }
        state.filteredExchangeRates = sortExchangeRates(baseRates)
    }
    
    private func sortExchangeRates(_ rates: [ExchangeRate]) -> [ExchangeRate] {
        return rates.sorted {
            if isFavorite($0.currency) != isFavorite($1.currency) {
                return isFavorite($0.currency)
            }
            return $0.currency < $1.currency
        }
    }
    
    func toggleFavorite(_ currency: String) {
        if isFavorite(currency) {
            favoriteCurrencyManager.removeFavorite(currency)
            state.favoriteCurrencies.remove(currency)
        } else {
            favoriteCurrencyManager.addFavorite(currency)
            state.favoriteCurrencies.insert(currency)
        }
        
        filterExchangeRates(with: state.currentSearchText)
    }
    
    private func loadFavoritesFromCoreData() {
        let savedFavorites = favoriteCurrencyManager.loadFavoriteCurrencies()
        state.favoriteCurrencies = savedFavorites
    }
    
    func isFavorite(_ currency: String) -> Bool {
        return state.favoriteCurrencies.contains(currency)
    }
}
