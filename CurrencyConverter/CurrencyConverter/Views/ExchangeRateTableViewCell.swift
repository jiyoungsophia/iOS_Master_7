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
    
    private let rateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .gray
        $0.textAlignment = .right
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 16
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
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(currencyLabel)
        stackView.addArrangedSubview(rateLabel)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configure(_ exchangeRate: ExchangeRate) {
        currencyLabel.text = exchangeRate.currency
        rateLabel.text = String(format: "%.4f", exchangeRate.rate)
    }
}
