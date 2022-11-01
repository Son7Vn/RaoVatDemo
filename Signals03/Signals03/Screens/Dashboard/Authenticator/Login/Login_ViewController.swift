//
//  Login_ViewController.swift
//  Signals03
//
//  Created by SonGoku on 23/08/2022.
//

import UIKit

extension UIColor {
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
}

class Login_ViewController: UIViewController {
        
    let loginTxt: UITextView = {
        let logintext = UITextView()
        let attributed = NSMutableAttributedString(string: "Log In", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 35), NSMutableAttributedString.Key.foregroundColor: UIColor.black])
        logintext.attributedText = attributed
        logintext.textAlignment = .center
        logintext.isEditable = false
        logintext.isSelectable = false
        logintext.translatesAutoresizingMaskIntoConstraints = false
        return logintext
    }()
    
    let usernameTxt: UITextField = {
        let usernametxt = UITextField()
        usernametxt.placeholder = "username"
        usernametxt.backgroundColor = .lightGray
        usernametxt.translatesAutoresizingMaskIntoConstraints = false
        return usernametxt
    }()
    
    let passwordTxt: UITextField = {
        let pass = UITextField()
        pass.placeholder = "password"
        pass.backgroundColor = .lightGray
        pass.translatesAutoresizingMaskIntoConstraints = false
        return pass
    }()
    
    let registerBtn: UIButton = {
        let register = UIButton(type: .system)
        register.setTitle("Register", for: .normal)
        register.setTitleColor(.white, for: .normal)
        register.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 1, alpha: 1)
        register.translatesAutoresizingMaskIntoConstraints = false
        register.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        return register
    }()
    
    let loginBtn: UIButton = {
        let login = UIButton(type: .system)
        login.setTitle("LogIn", for: .normal)
        login.setTitleColor(.white, for: .normal)
        login.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 1, alpha: 1)
        login.translatesAutoresizingMaskIntoConstraints = false
        login.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return login
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc private func registerAction() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let registerPage = sb.instantiateViewController(withIdentifier: "REGISTER") as! RegisterViewController
        self.navigationController?.pushViewController(registerPage, animated: true)
    }
    
    @objc private func loginAction() {
        let username = usernameTxt.text
        let password = passwordTxt.text
        let url = URL(string: "\(Config.ServerURL)/login")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = "username=\(username ?? "")&password=\(password ?? "")".data(using: .utf8)
        
        let urlSession = URLSession.shared
        urlSession.dataTask(with: urlRequest) { data, urlres, error in
            if (error != nil) {
                print("Error ne:",error as Any)
            } else {
                let dataJson = try! JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                if let json = dataJson as? [String: Any] {
                    if json["result"] as! Int == 1 {
                        let defaust = UserDefaults.standard
                        defaust.set(json["token"], forKey: "UserToken")
                        DispatchQueue.main.async {
                            let alerView = UIAlertController(title: "Login Successfully!", message: "Go to Dasboard", preferredStyle: .alert)
                            alerView.addAction(UIAlertAction(title: "Ok", style: .default, handler: { ok in
                                let sb = UIStoryboard(name: "Main", bundle: nil)
                                let DashboardView = sb.instantiateViewController(withIdentifier: "DASHBOARD") as! Dashboard_ViewController
                                self.navigationController?.pushViewController(DashboardView, animated: true)
                            }))
                            self.present(alerView, animated: true, completion: nil)
                        }
                        
                    } else {
                        let messager = json["messenger"] as? String
                        print(messager as Any)
                        DispatchQueue.main.async {
                            let alertView = UIAlertController(title: "Warning!", message: messager, preferredStyle: .alert)
                            alertView.addAction(UIAlertAction(title: "Ok!", style: .default, handler: nil))
                            self.present(alertView, animated: true, completion: nil)
                        }
                        
                    }
                }
            }
        }.resume()
    }
    
}
