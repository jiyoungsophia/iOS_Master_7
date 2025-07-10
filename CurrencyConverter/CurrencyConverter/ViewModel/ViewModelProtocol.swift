//
//  ViewModelProtocol.swift
//  CurrencyConverter
//
//  Created by Milou on 7/10/25.
//

import Foundation

protocol ViewModelProtocol {
    associatedtype Action
    associatedtype State
    
    var action: ((Action) -> Void)? { get }
    var state: State { get }
}
