//
//  TabBarViewController.swift
//  CustomTabBar
//
//  Created by Vlad on 12.08.24.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    let tabItems: [TabItem] = TabItem.tabItems
    
    private lazy var tabView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 35
        return $0
    }(UIView())
    
    private var tabViewStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        layoutElements()
        setupTabBar(pages: tabItems)
    }
    
    private func setupTabBar(pages: [TabItem]) {
        pages.enumerated().forEach {
            if $0.offset == 0 {
                tabViewStack.addArrangedSubview(createOneTabItem(item: $0.element, isFirst: true))
            } else {
                tabViewStack.addArrangedSubview(createOneTabItem(item: $0.element))
            }
        }
    }
    
    private func createOneTabItem(item: TabItem, isFirst: Bool = false) -> UIView {
        TabBarItem(tabItem: item, isActive: isFirst) { [weak self] selectedItem in
            guard let self = self else {
                return
            }
            self.tabViewStack.arrangedSubviews.forEach {
                guard let tabItem = $0 as? TabBarItem else {
                    return
                }
                tabItem.isActive = false
            }
            selectedItem.isActive.toggle()
            self.selectedIndex = item.index
        }
    }
 
    private func setupTabBar() {
        tabBar.isHidden = true
        setViewControllers([HomeViewController(), ChatViewController(), ProfileViewController()], animated: true)
    }
    
    private func layoutElements() {
        layoutTabView()
        layoutTabViewStack()
    }
    
    private func layoutTabView() {
        view.addSubview(tabView)
        
        NSLayoutConstraint.activate([
            tabView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            tabView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            tabView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            tabView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func layoutTabViewStack() {
        tabView.addSubview(tabViewStack)
        
        NSLayoutConstraint.activate([
            tabViewStack.topAnchor.constraint(equalTo: tabView.topAnchor),
            tabViewStack.bottomAnchor.constraint(equalTo: tabView.bottomAnchor),
            tabViewStack.leadingAnchor.constraint(equalTo: tabView.leadingAnchor, constant: 20),
            tabViewStack.trailingAnchor.constraint(equalTo: tabView.trailingAnchor, constant: -20),
        ])
    }
}
