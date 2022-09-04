//
//  UserAPI.swift
//  Social Media App
//
//  Created by Mohanned Alsahaf on 29/01/1444 AH.
//

import Foundation
import SwiftyJSON
import Alamofire

class UserAPI:API{
    static func GetUserInfo(userid:String,completionHandler:@escaping (User) -> ()){
        let userUrl = "\(baseUrl)/user/\(userid)"
        
        AF.request(userUrl,headers: headers).responseJSON { res in
          
            let jsonData = JSON(res.value)
            
            
            let decoder = JSONDecoder()
            
            do {
                let user =  try decoder.decode(User.self, from:
                jsonData.rawData())//fill the user with the info i will get
                completionHandler(user)
            }catch let Error{
                print(Error)
            }
            
        }

        
    }
    
    
    static func SignUpNewUser(firstName:String,lastName:String,email:String,completionHandler:@escaping (User?,String?) -> ()){
        let userUrl = "\(baseUrl)/user/create"
        let params = [
            "firstName":firstName,
            "lastName":lastName,
            "email":email
            
        ]
        
        AF.request(userUrl,method :.post,parameters: params,encoder: JSONParameterEncoder.default,headers: headers).validate().responseJSON { res in
            switch res.result{
            case .success:
                let jsonData = JSON(res.value)
                
                
                let decoder = JSONDecoder()
                
                do {
                    let user =  try decoder.decode(User.self, from:
                    jsonData.rawData())//fill the user with the info i will get
                    completionHandler(user,nil)
                }catch let Error{
                    print(Error)
                }
                
            case .failure(let error):
               let jsonData = JSON(res.data)
                let data = jsonData["data"]
                //Error Messages:
                let emailError = data["email"].stringValue
                let firstnameError = data["firstName"].stringValue
                let lastnameError = data["lastName"].stringValue
                
                let errorMessage = emailError + " " + firstnameError + " " + lastnameError
                completionHandler(nil,errorMessage)
                print(emailError)
            }
            
        }

        
    }
    
    static func SignInUser(firstName:String,lastName:String,completionHandler:@escaping (User?,String?) -> ()){
        let userUrl = "\(baseUrl)/user"
        let params = [
            "created":"1"
        ]
        
        AF.request(userUrl,method :.get,parameters: params,encoder: URLEncodedFormParameterEncoder.default,headers: headers).validate().responseJSON { res in
            switch res.result{
            case .success:
                let jsonData = JSON(res.value)
                let data = jsonData["data"]
                
                let decoder = JSONDecoder()
                
                do {
                    let users =  try decoder.decode([User].self, from:
                    data.rawData())//fill the user with the info i will get
                    
                    //here to search for the exact user
                
                    var thefoundedUser: User?
                    for user in users{
                        if user.firstName == firstName && user.lastName == lastName {

                            thefoundedUser = user
                            break
                        }
                    }
                    if let user = thefoundedUser {
                        completionHandler(user,nil) // if the user is founded
                    }else{
                        completionHandler(nil,"User Not Founded") // if its not founded
                    }
                    
//                    completionHandler(user,nil)
                    print(users)
                }catch let Error{
                    print(Error)
                }
                
            case .failure(let error):
               let jsonData = JSON(res.data)
                let data = jsonData["data"]
                //Error Messages:
                let emailError = data["email"].stringValue
                let firstnameError = data["firstName"].stringValue
                let lastnameError = data["lastName"].stringValue
                
                let errorMessage = emailError + " " + firstnameError + " " + lastnameError
                completionHandler(nil,errorMessage)
                print(emailError)
            }
            
        }

        
    }
    
    
    
    static func UpdateUser(userId:String,firstName:String,phone:String,image:String,completionHandler:@escaping (User?,String?) -> ()){
        let userUrl = "\(baseUrl)/user/\(userId)"
        let params = [
            "firstName":firstName,
            "picture":image,
            "phone":phone
            
        ]
        
        AF.request(userUrl,method :.put,parameters: params,encoder: JSONParameterEncoder.default,headers: headers).validate().responseJSON { res in
            switch res.result{
            case .success:
                let jsonData = JSON(res.value)
                let decoder = JSONDecoder()
                
                do {
                    let user =  try decoder.decode(User.self, from:
                    jsonData.rawData())//fill the user with the info i will get
                    
                    
                
                    completionHandler(user,nil)
                    print(user)
                }catch let Error{
                    print(Error)
                }
                
            case .failure(let error):
               let jsonData = JSON(res.data)
                let data = jsonData["data"]
                //Error Messages:
                let emailError = data["email"].stringValue
                let firstnameError = data["firstName"].stringValue
                let lastnameError = data["lastName"].stringValue
                
                let errorMessage = emailError + " " + firstnameError + " " + lastnameError
                completionHandler(nil,errorMessage)
                print(emailError)
            }
            
        }

        
    }
    
    
    
    
}
