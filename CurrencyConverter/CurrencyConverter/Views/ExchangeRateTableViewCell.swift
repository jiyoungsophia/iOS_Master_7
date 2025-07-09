//
//  ExchangeRateTableViewCell.swift
//  CurrencyConverter
//
//  Created by Milou on 7/8/25.
//

import UIKit
import SnapKit
import Then

class ExchangeRateTableViewCell: UITableViewCell {

    static let identifier = "ExchangeRateTableViewCell"
    
    private let currencyLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .text
    }
    
    private let countryLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
    }
    
    private let labelVStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
    }
    
    private let rateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .gray
        $0.textAlignment = .right
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .background
        
        labelVStackView.addArrangedSubview(currencyLabel)
        labelVStackView.addArrangedSubview(countryLabel)
        
        contentView.addSubview(labelVStackView)
        contentView.addSubview(rateLabel)
        
        labelVStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        rateLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(labelVStackView.snp.trailing).offset(16)
            $0.width.equalTo(120)
        }
    }
    
    func configure(_ exchangeRate: ExchangeRate) {
        currencyLabel.text = exchangeRate.currency
        rateLabel.text = String(format: "%.4f", exchangeRate.rate)
        countryLabel.text = exchangeRate.currency.toCountryName
    }
}
