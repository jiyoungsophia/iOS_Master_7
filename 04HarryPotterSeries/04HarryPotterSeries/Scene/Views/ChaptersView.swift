//
//  ChaptersView.swift
//  04HarryPotterSeries
//
//  Created by Milou on 6/19/25.
//

import UIKit

final class ChaptersView: UIView {
    private let titleLabel = UILabel().then {
        $0.text = "Chapters"
        $0.font = .boldSystemFont(ofSize: 18)
        $0.textColor = .black
    }
    
    private let chapterVStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .fill
    }
    
    var chapters: [String] = [] {
        didSet {
            updateChapters()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
        addSubview(chapterVStackView)
    
        chapterVStackView.addArrangedSubview(titleLabel)
    }
    
    private func setupConstraints() {
        chapterVStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func updateChapters() {
        chapterVStackView.addArrangedSubviews(from: chapters) { text, _ in
            return UILabel().then {
                $0.text = text
                $0.font = .systemFont(ofSize: 14)
                $0.textColor = .darkGray
                $0.numberOfLines = 0
            }
        }
    }
}
