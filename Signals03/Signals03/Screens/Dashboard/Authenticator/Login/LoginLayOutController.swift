//
//  LoginLayOutController.swift
//  Signals03
//
//  Created by SonGoku on 29/08/2022.
//

import UIKit

extension Login_ViewController {
    
    func setupLayout() {
        //view1:
        view.addSubview(loginTxt)
        NSLayoutConstraint.activate([
            loginTxt.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginTxt.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginTxt.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginTxt.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ])
        //view2:
        let view2 = UIView()
        view2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(view2)
        
        NSLayoutConstraint.activate([
            view2.topAnchor.constraint(equalTo: loginTxt.bottomAnchor),
            view2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view2.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08)
        ])
        view2.addSubview(usernameTxt)
        NSLayoutConstraint.activate([
            usernameTxt.topAnchor.constraint(equalTo: view2.topAnchor),
            usernameTxt.centerXAnchor.constraint(equalTo: view2.centerXAnchor),
            usernameTxt.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 0.6),
            usernameTxt.widthAnchor.constraint(equalTo: view2.widthAnchor,multiplier: 0.7)
        ])
        //view3:
        let view3 = UIView()
        view3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(view3)
        NSLayoutConstraint.activate([
            view3.topAnchor.constraint(equalTo: view2.bottomAnchor),
            view3.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view3.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view3.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08)
        ])
        view3.addSubview(passwordTxt)
        NSLayoutConstraint.activate([
            passwordTxt.topAnchor.constraint(equalTo: view3.topAnchor),
            passwordTxt.centerXAnchor.constraint(equalTo: view3.centerXAnchor),
            passwordTxt.heightAnchor.constraint(equalTo: view3.heightAnchor, multiplier: 0.6),
            passwordTxt.widthAnchor.constraint(equalTo: view3.widthAnchor,multiplier: 0.7)
        ])
        
        //view4:
        let view4 = UIView()
        view4.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(view4)
        NSLayoutConstraint.activate([
            view4.topAnchor.constraint(equalTo: view3.bottomAnchor),
            view4.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view4.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view4.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
        ])
        view4.addSubview(registerBtn)
        NSLayoutConstraint.activate([
            registerBtn.topAnchor.constraint(equalTo: view4.topAnchor),
            registerBtn.leadingAnchor.constraint(equalTo: passwordTxt.leadingAnchor),
            registerBtn.heightAnchor.constraint(equalTo: view4.heightAnchor, multiplier: 1),
            registerBtn.widthAnchor.constraint(equalTo: view4.widthAnchor, multiplier: 0.2)
        ])
        view4.addSubview(loginBtn)
        NSLayoutConstraint.activate([
            loginBtn.topAnchor.constraint(equalTo: view4.topAnchor),
            loginBtn.trailingAnchor.constraint(equalTo: passwordTxt.trailingAnchor),
            loginBtn.heightAnchor.constraint(equalTo: registerBtn.heightAnchor),
            loginBtn.widthAnchor.constraint(equalTo: registerBtn.widthAnchor)
        ])
    }
    
}
