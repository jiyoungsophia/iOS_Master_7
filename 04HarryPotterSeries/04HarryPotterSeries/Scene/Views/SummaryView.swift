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
    private let charaterLimit: Int = 450
    
    private var fullText = "" {
        didSet {
            updateUI()
        }
    }
    
    private var isExpanded: Bool = false {
        didSet {
            updateContent()
        }
    }
    private var isButtonNeeded: Bool {
        fullText.count >= charaterLimit
    }
    
    var content: String? {
        get { fullText }
        set { fullText = newValue ?? "" }
    }
    
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
        
        toggleButton.addTarget(self, action: #selector(toggleButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func toggleButtonTapped() {
        isExpanded.toggle()
    }
    
    private func updateUI() {
        toggleButton.isHidden = !isButtonNeeded
        updateContent()
    }
    
    private func updateContent() {
        guard isButtonNeeded else {
            contentLabel.text = fullText
            return
        }
        
        if isExpanded {
            contentLabel.text = fullText
            toggleButton.setTitle("접기", for: .normal)
        } else {
            let truncatedText = fullText.prefix(charaterLimit) + "..."
            contentLabel.text = String(truncatedText)
            toggleButton.setTitle("더보기", for: .normal)
        }
    }
}
