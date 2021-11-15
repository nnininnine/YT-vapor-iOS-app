//
//  ModalType.swift
//  YT-vapor-iOS-app
//
//  Created by Nuttapon Buaban on 15/11/2564 BE.
//

import Foundation

enum ModalType: Identifiable {
    var id:String {
        switch self {
        case .add: return "add"
        case .update: return "update"
        }
    }
    
    case add
    case update(Song)
}
