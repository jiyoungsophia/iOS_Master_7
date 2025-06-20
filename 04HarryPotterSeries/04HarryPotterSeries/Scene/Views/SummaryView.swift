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
    
    var content = "" {
        didSet {
            updateUI() // 글자 수에 따라 UI 변경
        }
    }
    
    var initialExpandedState: Bool = false {
        didSet {
            if isButtonNeeded {
                isExpanded = initialExpandedState
            }
        }
    }
    
    var onExpandedStateChanged: ((Bool) -> Void)?
    
    private var isExpanded: Bool = false {
        didSet {
            updateTextState()
        }
    }
    
    private var isButtonNeeded: Bool {
        content.count >= charaterLimit
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

    private func updateUI() {
        toggleButton.isHidden = !isButtonNeeded
        updateTextState()
    }
    
    private func updateTextState() {
        guard isButtonNeeded else {
            contentLabel.text = content // 450자 미만일땐 풀텍스트
            return
        }
        
        if isExpanded {
            contentLabel.text = content
            toggleButton.setTitle("접기", for: .normal)
        } else {
            let truncatedText = content.prefix(charaterLimit) + "..."
            contentLabel.text = String(truncatedText)
            toggleButton.setTitle("더보기", for: .normal)
        }
    }
    
    @objc
    private func toggleButtonTapped() {
        isExpanded.toggle()
        onExpandedStateChanged?(isExpanded)
    }
}
