//
//  Comment.swift
//  Social Media App
//
//  Created by Mohanned Alsahaf on 26/01/1444 AH.
//

import Foundation
import UIKit

struct Comment:Decodable{
    var id :String
    var message:String
    var owner:User
}
