//
//  MainEvents.swift
//  REasy Converter
//
//  Created by Raphael on 12/03/23.
//

import RCoordinator
import UIKit

protocol MainEventsProtocol {
    func handle(event: MainEvents)
}

enum MainEvents: Event {
    
    case dismiss
    case pop
    case home
    
    func handle(_ handler: MainEventsProtocol) {
        handler.handle(event: self)
    }
}
