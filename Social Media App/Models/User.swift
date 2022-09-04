//
//  User.swift
//  Social Media App
//
//  Created by Mohanned Alsahaf on 25/01/1444 AH.
//

import Foundation
import UIKit


struct User:Decodable {
    var id:String
    var firstName:String
    var lastName:String
    var picture:String?
    var phone:String?
    var email:String?
    var gender:String?
    var location:Location?
}
