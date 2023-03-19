//
//  MainCoordinator.swift
//  REasy Converter
//
//  Created by Raphael on 12/03/23.
//

import RCoordinator
import UIKit

class MainCoordinator: Coordinator {

    var navigationController: UINavigationController
    var tabBarController: UITabBarController

    init(navigationController: UINavigationController,
         tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ConverterViewController()
        vc.router = self
        push(viewController: vc, animated: false)
    }
    
    func startTabBar() {
        let converterVC = ConverterViewController()
        converterVC.router = self
        converterVC.title = "Conversor"
        converterVC.tabBarItem = UITabBarItem(title: "Conversor",
                                              image: UIImage(systemName: "arrow.up.right.and.arrow.down.left.rectangle.fill"),
                                              tag: 0)
        // arrow.up.right.and.arrow.down.left.rectangle.fill dollarsign.circle.fill
        
        let settingsVC = SettingsViewController()
        settingsVC.title = "Configurações"
        settingsVC.view.backgroundColor = .white
        settingsVC.tabBarItem = UITabBarItem(title: "Configurações",
                                             image: UIImage(systemName: "list.bullet.circle.fill"),
                                             tag: 1)
        
        let navConverter = UINavigationController(rootViewController: converterVC)
        navConverter.navigationBar.prefersLargeTitles = true
        let navSettings = UINavigationController(rootViewController: settingsVC)
        navSettings.navigationBar.prefersLargeTitles = true
        
        tabBarController.tabBar.tintColor = .green
        tabBarController.tabBar.unselectedItemTintColor = .lightGray
        tabBarController.viewControllers = [
            navConverter,
            navSettings
        ]
    }
}

extension MainCoordinator: MainEventsProtocol {

    func handle(event: MainEvents) {
        switch event {
        case .dismiss:
            dismiss(animated: true)
        case .pop:
            pop(animated: true)
        case .home:
            let homeVC = UIViewController()
            present(viewController: homeVC, animated: true)
        }

    }
    
}

private var routerKey: UInt8 = 0

extension UIViewController {

    var router: MainEventsProtocol? {
        get {
            return objc_getAssociatedObject(self, &routerKey) as? MainEventsProtocol
        }
        set {
            objc_setAssociatedObject(self, &routerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

}

