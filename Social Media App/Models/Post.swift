//
//  Post.swift
//  Social Media App
//
//  Created by Mohanned Alsahaf on 25/01/1444 AH.
//

import Foundation
import UIKit
struct Post:Decodable {
    var id:String
    var image: String
    var likes:Int
    var text:String
    var owner:User//because owner have multiple values so we made a separate class to put all the owner information in it
    var tags:[String]?
}
