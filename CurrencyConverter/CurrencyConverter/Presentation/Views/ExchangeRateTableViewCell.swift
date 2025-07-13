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
    
    private let trendLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textAlignment = .center
        $0.text = ""
    }
    
    private let favoriteButton = UIButton().then {
        $0.setImage(UIImage(systemName: "star"), for: .normal)
        $0.setImage(UIImage(systemName: "star.fill"), for: .selected)
        $0.imageView?.tintColor = .favorite
    }
    
    private var exchangeRate: ExchangeRate?
    var onFavoriteButtonTapped: ((String) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .background
        
        labelVStackView.addArrangedSubview(currencyLabel)
        labelVStackView.addArrangedSubview(countryLabel)
        
        [labelVStackView, trendLabel, rateLabel, favoriteButton]
            .forEach { contentView.addSubview($0) }
        
        labelVStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        trendLabel.snp.makeConstraints {
            $0.trailing.equalTo(favoriteButton.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(20)
        }
        
        rateLabel.snp.makeConstraints {
            $0.trailing.equalTo(trendLabel.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(labelVStackView.snp.trailing).offset(16)
            $0.width.equalTo(120)
        }
        
        favoriteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }
    }
    
    func configure(_ exchangeRate: ExchangeRate, isFavorite: Bool = false, trend: TrendDirection = .none) {
        self.exchangeRate = exchangeRate
        currencyLabel.text = exchangeRate.currency
        rateLabel.text = "\(rate: exchangeRate.rate)"
        countryLabel.text = exchangeRate.country
        favoriteButton.isSelected = isFavorite
        trendLabel.text = trend.icon
    }
    
    private func setupAction() {
        favoriteButton.addTarget(
            self,
            action: #selector(favoriteButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc
    private func favoriteButtonTapped() {
        guard let currency = exchangeRate?.currency else { return }
        onFavoriteButtonTapped?(currency)
    }
}
