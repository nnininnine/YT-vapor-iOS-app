//
//  Song.swift
//  YT-vapor-iOS-app
//
//  Created by Nuttapon Buaban on 14/11/2564 BE.
//

import Foundation

struct Song: Identifiable, Codable{
    let id: UUID?
    var title: String
}
