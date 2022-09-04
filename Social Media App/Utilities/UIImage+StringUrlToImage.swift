//
//  UIImage+StringUrlToImage.swift
//  Social Media App
//
//  Created by Mohanned Alsahaf on 27/01/1444 AH.
//

import Foundation
import UIKit
extension UIImageView{
    func ConvertStringUrlToImage(stringUrl:String){
        if let userpicStringToUrl = URL(string: stringUrl){//to make the image string url into url
            
            if let userpicUrlToData = try? Data(contentsOf: userpicStringToUrl){//to make the url into data to put it into uiimage
                
                self.image = UIImage(data: userpicUrlToData)
                //putting the image
            
            }
        }
    }
    
    func MakeCircleImage(){
        self.layer.cornerRadius = self.frame.height/2 // to make the circle
    }
}
