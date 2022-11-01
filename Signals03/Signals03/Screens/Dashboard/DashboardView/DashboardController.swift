//
//  DashboardController.swift
//  Signals03
//
//  Created by SonGoku on 30/08/2022.
//

import UIKit

extension Dashboard_ViewController {
    
    func verifyer() {
        if let token = self.defaust.string(forKey: "UserToken") {
            let url = URL(string: "\(Config.ServerURL)/verify")
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = "token=\(token)".data(using: .utf8)
            
            let urlSession = URLSession.shared
            urlSession.dataTask(with: urlRequest) { data, urlRes, error in
                if (error != nil) {
                    print("Failed to verify!",error as Any)
                } else {
                    
                    let dataJson = try? JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    if let json = dataJson as? [String: Any] {
                        if (json["result"] as! Int == 1){
                            let decode = json["decode"] as! [String: Any]
                            let email = decode["email"]
                            let avatarName = decode["avatar"] as! String
                            let avatar = Config.ServerURL + "/upload/" + avatarName
                            let admin = decode["status"]
                            
                            DispatchQueue.main.async {
                                let alertView = UIAlertController(title: "Welcome Back", message: "Success to verify token!", preferredStyle: .alert)
                                alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(alertView: UIAlertAction!) in
                                    self.emailText.text = (email as! String)
                                    DispatchQueue.main.async {
                                        do {
                                            let imgData = try? Data(contentsOf: URL(string: avatar)!)
                                            self.avatarUser.image = UIImage(data: imgData!)
                                        }
                                    }
                                    if (admin as! Int) == 0 {
                                        self.adminText.text = "False"
                                    } else {
                                        self.adminText.text = "True"
                                    }

                                }))
                                self.present(alertView, animated: false, completion: nil)
                            }
                        } else {
                            print(json)
                            DispatchQueue.main.async {
                                let sb = UIStoryboard(name: "Main", bundle: nil)
                                let loginPage = sb.instantiateViewController(withIdentifier: "LOGIN") as! Login_ViewController
                                self.navigationController?.pushViewController(loginPage, animated: false)
                            }
                        }
                    }
                }
            }.resume()
        } else {
            DispatchQueue.main.async {
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let loginPage = sb.instantiateViewController(withIdentifier: "LOGIN") as! Login_ViewController
                self.navigationController?.pushViewController(loginPage, animated: false)
            }
        }
        
    }
    
}
