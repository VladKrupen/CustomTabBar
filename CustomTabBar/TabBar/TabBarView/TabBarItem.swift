//
//  TabBarItem.swift
//  CustomTabBar
//
//  Created by Vlad on 12.08.24.
//

import UIKit

final class TabBarItem: UIView {
    var tabItem: TabItem
    var imageRightConstraints: NSLayoutConstraint?
    
    var isActive: Bool {
        willSet {
            self.imageRightConstraints?.isActive = !newValue
            self.contentView.backgroundColor = newValue ? .lightGray : .clear
            
            UIView.animate(withDuration: 0.2) {
                self.layoutIfNeeded()
            }
        }
    }
    
    var isSelected: ((TabBarItem) -> Void)?
    
    private lazy var contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = isActive ? .lightGray : .clear
        $0.layer.cornerRadius = 20
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToTab)))
        $0.isUserInteractionEnabled = true
        return $0
    }(UIView())
    
    private lazy var tabImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: tabItem.tabImage)
        $0.widthAnchor.constraint(equalToConstant: 25).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 25).isActive = true
        return $0
    }(UIImageView())
    
    private lazy var tabText: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = tabItem.tabText
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 14)
        return $0
    }(UILabel())
    
    init(tabItem: TabItem, imageRightConstraints: NSLayoutConstraint? = nil, isActive: Bool, isSelected: @escaping (TabBarItem) -> Void) {
        self.tabItem = tabItem
        self.imageRightConstraints = imageRightConstraints
        self.isActive = isActive
        self.isSelected = isSelected
        super.init(frame: .zero)
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutElements() {
        addSubview(contentView)
        contentView.addSubview(tabImage)
        contentView.addSubview(tabText)
        
        imageRightConstraints = tabImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        imageRightConstraints?.isActive = !isActive
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            tabImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            tabImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            tabImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            tabText.leadingAnchor.constraint(equalTo: tabImage.trailingAnchor, constant: 5),
            tabText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            tabText.centerYAnchor.constraint(equalTo: tabImage.centerYAnchor)
        ])
    }
}

extension TabBarItem {
    @objc private func tapToTab() {
        self.isSelected?(self)
    }
}
