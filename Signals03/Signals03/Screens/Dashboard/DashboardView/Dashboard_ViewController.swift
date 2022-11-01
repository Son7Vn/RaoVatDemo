//
//  Dashboard_ViewController.swift
//  Signals03
//
//  Created by SonGoku on 22/08/2022.
//

import UIKit

class Dashboard_ViewController: UIViewController {
    
    let avatarUser: UIImageView = {
       let ava = UIImageView(image: UIImage(named: "licogi12"))
        ava.layer.cornerRadius = ava.frame.size.width / 2
        ava.translatesAutoresizingMaskIntoConstraints = false
        return ava
    }()
    
    let emailText: UITextView = {
        let email = UITextView()
        email.text = "Email@gmail.com"
        email.isEditable = false
        email.isSelectable = false
        email.layer.borderWidth = 0.5
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    let adminText: UITextView = {
       let admin = UITextView()
        admin.text = "False"
        admin.isEditable = false
        admin.isSelectable = false
        admin.layer.borderWidth = 0.5
        admin.translatesAutoresizingMaskIntoConstraints = false
        return admin
    }()
    
    let btnLogOut: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(LogOutAction), for: .touchUpInside)
        return button
    }()
    
    let defaust = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .systemBackground
        verifyer()
        Layout()
    }
    
    @objc private func LogOutAction() {
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: "Log Out!", message: "Do you want go to LogIn Page?", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                if let token = self.defaust.string(forKey: "UserToken") {
                    let url = URL(string: Config.ServerURL + "/logout")
                    var urlRequest = URLRequest(url: url!)
                    urlRequest.httpMethod = "POST"
                    urlRequest.httpBody = "token=\(token)".data(using: .utf8)
                    
                    let urlSession = URLSession.shared
                    urlSession.dataTask(with: urlRequest) { data, urlRespose, error in
                        if (error != nil) {
                            print(error! as Any)
                        } else {
                            self.defaust.removeObject(forKey: "UserToken")
                            DispatchQueue.main.async {
                                let sb = UIStoryboard(name: "Main", bundle: nil)
                                let loginPage = sb.instantiateViewController(withIdentifier: "LOGIN") as! Login_ViewController
                                self.navigationController?.pushViewController(loginPage, animated: true)
                            }
                        }
                    }.resume()
                } else {
                    print("fggfgf")
                }
            }))
            alertView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
}
