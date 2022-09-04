//
//  ShadowView.swift
//  Social Media App
//
//  Created by Mohanned Alsahaf on 27/01/1444 AH.
//

import UIKit
//we make class for the shadow view and its inherit the uiview and then put this class to any view i want it to apply this shadow
class ShadowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetShadow()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        SetShadow()
    }
    func SetShadow(){
        //to make the shadow for the view
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.4  //تتحكم ب شفافيه الظل
        self.layer.shadowOffset = CGSize(width: 5, height: 0)//انزياح الظل
        self.layer.shadowRadius = 3 //مقدار توزع الظل
        
        self.layer.cornerRadius = 7 // عشان اخلي الزوايا دائريه
        
   
    }
    
}
