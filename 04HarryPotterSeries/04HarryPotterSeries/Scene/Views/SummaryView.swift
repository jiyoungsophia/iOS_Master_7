//
//  SummaryView.swift
//  04HarryPotterSeries
//
//  Created by Milou on 6/19/25.
//

import UIKit
import SnapKit
import Then

final class SummaryView: UIView {
    private let titleLabel = UILabel().then {
        $0.text = "Summary"
        $0.font = .boldSystemFont(ofSize: 18)
        $0.textColor = .black
    }
    
    private let contentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .gray
        $0.numberOfLines = 0
    }
    
    private let toggleButton = UIButton().then {
        $0.setTitle("Show more", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.contentHorizontalAlignment = .trailing
    }
    
    private let summaryVStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    var content: String? {
        get { contentLabel.text }
        set { contentLabel.text = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
        
        [titleLabel, contentLabel, toggleButton]
            .forEach { summaryVStackView.addArrangedSubview($0) }
        
        addSubview(summaryVStackView)
        
        summaryVStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
