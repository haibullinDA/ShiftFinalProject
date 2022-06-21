//
//  CustomTextView.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import UIKit

final class CustomTextView: UIView {
    private let testText = """
    LONDON — Cryptocurrencies “have no intrinsic value” and people who invest in them should be prepared to lose all their money, Bank of England Governor Andrew Bailey said.
    
    Digital currencies like bitcoin, ether and even dogecoin have been on a tear this year, reminding some investors of the 2017 crypto bubble in which bitcoin blasted toward $20,000, only to sink as low as $3,122 a year later.
    
    Asked at a press conference Thursday about the rising value of cryptocurrencies, Bailey said: “They have no intrinsic value. That doesn’t mean to say people don’t put value on them, because they can have extrinsic value. But they have no intrinsic value.”
    
    “I’m going to say this very bluntly again,” he added. “Buy them only if you’re prepared to lose all your money.”
    
    Bailey’s comments echoed a similar warning from the U.K.’s Financial Conduct Authority.
    
    “Investing in cryptoassets, or investments and lending linked to them, generally involves taking very high risks with investors’ money,” the financial services watchdog said in January.
    
    “If consumers invest in these types of product, they should be prepared to lose all their money.”
    
    Bailey, who was formerly the chief executive of the FCA, has long been a skeptic of crypto. In 2017, he warned: “If you want to invest in bitcoin, be prepared to lose all your money.”
    """
    
    private enum Constraint {
        static let textViewHorizontalAnchor: CGFloat = 15
    }
    private enum Constant {
        static let emptyViewHeight: CGFloat = 88
        static let viewCornerRadius: CGFloat = 24
    }
    
    private let emptyView = UIView()
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = Nunito.semiBold14.font
        textView.textAlignment = .left
        textView.isEditable = false
        return textView
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.layer.cornerRadius = Constant.viewCornerRadius
        self.textView.text = testText
        self.setupLayout()
    }
}

private extension CustomTextView {
    func setupLayout() {
        self.emptyView.translatesAutoresizingMaskIntoConstraints = false
        self.emptyView.clipsToBounds = true
        self.addSubview(self.emptyView)
        NSLayoutConstraint.activate([
            self.emptyView.topAnchor.constraint(equalTo: self.topAnchor),
            self.emptyView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.emptyView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.emptyView.heightAnchor.constraint(equalToConstant: Constant.emptyViewHeight)
        ])
        
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.textView)
        NSLayoutConstraint.activate([
            self.textView.topAnchor.constraint(equalTo: self.emptyView.bottomAnchor),
            self.textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constraint.textViewHorizontalAnchor),
            self.textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constraint.textViewHorizontalAnchor),
            self.textView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
