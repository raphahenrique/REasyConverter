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

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ConverterViewController()
        vc.router = self
        push(viewController: vc, animated: false)
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

