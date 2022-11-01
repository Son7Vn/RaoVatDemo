//
//  RegisterViewController.swift
//  Signals03
//
//  Created by SonGoku on 27/07/2022.
//

import UIKit

class RegisterViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var avatarText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        spinner.isHidden = true
    }
    
    @IBAction func tapToSelectAvatar(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true) {}
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage {
            self.imageAvatar.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapToRegister(_ sender: Any) {
        self.spinner.isHidden = false
        loadAvatarAndRegister()
//        registerWithAvatar()
    }
    
    func registerWithAvatar() {
        let url = URL(string: Config.ServerURL + "/register")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        let username = self.username.text
        let password = self.password.text
        let emailTxt = self.email.text
        let avatarString = self.avatarText
        
        urlRequest.httpBody = "username=\(username!)&password=\(password!)&email=\(emailTxt!)&avatar=\(avatarString)".data(using: .utf8)
        
        let session = URLSession.shared
        session.dataTask(with: urlRequest) { data, urlResponse, error in
            if ((error) != nil) {
                print(error ?? "Error")
            } else {
                let dataJson = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                if let json = dataJson as? [String: Any] {
                    print(json)
                    if json["result"] as! Int == 1 {
                        DispatchQueue.main.async {
                            self.spinner.isHidden = true
                        }
                        DispatchQueue.main.async {
                            self.spinner.isHidden = true
//                            let message = json["messenger"] as! String
                            let alertView = UIAlertController(title: "Warning!", message: "Register Successfully!", preferredStyle: .alert)
                            alertView.addAction(UIAlertAction(title: "Go to LogIn Page", style: .default, handler: { alert in
                                let sb = UIStoryboard(name: "Main", bundle: nil)
                                let loginPage = sb.instantiateViewController(withIdentifier: "LOGIN") as! Login_ViewController
                                self.navigationController?.pushViewController(loginPage, animated: true)
                            }))
                            self.present(alertView, animated: true, completion: nil)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.spinner.isHidden = true
                            let message = json["messenger"] as! String
                            let alertView = UIAlertController(title: "Warning!", message: message, preferredStyle: .alert)
                            alertView.addAction(UIAlertAction(title: "Okay!", style: .default, handler: nil))
                            self.present(alertView, animated: true, completion: nil)
                        }
                    }
                }
            }
        }.resume()
    }
    
    func loadAvatarAndRegister() {
        //URLRequest:
        let boundary = UUID().uuidString
        let url = URL(string: Config.ServerURL + "/uploadTest")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        //create a path
        var data = Data()
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"avatar\"; filename=\"appios.png\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append((self.imageAvatar.image?.pngData())!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        //new session:
        let session = URLSession.shared
        session.uploadTask(with: urlRequest, from: data) { dataResponse, urlResponse, err in
            if err == nil {
                let dataJson = try? JSONSerialization.jsonObject(with: dataResponse!, options: .allowFragments)
                if let json = dataJson as? [String:Any] {
                    if (json["result"] as! Int == 1) {
                        
                        self.avatarText = json["file"] as! String
                        DispatchQueue.main.async {
                            self.registerWithAvatar()
                        }
                        
                    } else {
                        print("result = 0")
                    }
                }
            } else {
                print("Failed to register: ",err as Any)
            }
        }.resume()
    }
}

extension UIImageView {
    func load(urlAdress: String) {
        guard let url = URL(string: urlAdress) else {return}
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
