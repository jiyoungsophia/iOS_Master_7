//
//  InfoRowView.swift
//  04HarryPotterSeries
//
//  Created by Milou on 6/18/25.
//

import UIKit
import SnapKit
import Then

final class InfoRowView: UIView {
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }
    
    var content: String? {
        get { contentLabel.text }
        set { contentLabel.text = newValue }
    }
    
    init(
        title: String,
        titleFont: UIFont = .boldSystemFont(ofSize: 14),
        titleColor: UIColor = .black,
        contentFont: UIFont = .systemFont(ofSize: 14),
        contentColor: UIColor = .gray
    ) {
        super.init(frame: .zero)
        setupView(
            title: title,
            titleFont: titleFont,
            contentFont: contentFont,
            contentColor: contentColor
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(
        title: String,
        titleFont: UIFont,
        contentFont: UIFont,
        contentColor: UIColor
    ) {
        titleLabel.text = title
        titleLabel.font = titleFont
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        contentLabel.font = contentFont
        contentLabel.textColor = contentColor
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(contentLabel)
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
