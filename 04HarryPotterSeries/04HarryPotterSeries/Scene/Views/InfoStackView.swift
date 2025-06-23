//
//  InfoRowView.swift
//  04HarryPotterSeries
//
//  Created by Milou on 6/18/25.
//

import UIKit
import SnapKit
import Then

final class InfoStackView: UIView {
    
    // MARK: - Properties
    var content: String? {
        get { contentLabel.text }
        set { contentLabel.text = newValue }
    }
    
    // MARK: - UI Components
    private lazy var titleLabel = UILabel()
    
    private lazy var contentLabel = UILabel().then {
        $0.numberOfLines = 0
    }
    
    private lazy var stackView = UIStackView().then {
        $0.spacing = 8
    }
    
    // MARK: - Initializers
    init(
        axis: NSLayoutConstraint.Axis = .horizontal,
        title: String,
        titleFont: UIFont = .boldSystemFont(ofSize: 14),
        titleColor: UIColor = .black,
        contentFont: UIFont = .systemFont(ofSize: 14),
        contentColor: UIColor = .gray
    ) {
        super.init(frame: .zero)
        setupView(
            axis: axis,
            title: title,
            titleFont: titleFont,
            contentFont: contentFont,
            contentColor: contentColor
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    private func setupView(
        axis: NSLayoutConstraint.Axis,
        title: String,
        titleFont: UIFont,
        contentFont: UIFont,
        contentColor: UIColor
    ) {
        stackView.axis = axis
        
        titleLabel.text = title
        titleLabel.font = titleFont
        titleLabel.setContentHuggingPriority(.required, for: axis == .horizontal ? .horizontal : .vertical)
        
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
