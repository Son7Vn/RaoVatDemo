//
//  Dashboard_Layout.swift
//  Signals03
//
//  Created by SonGoku on 06/09/2022.
//

import UIKit

extension Dashboard_ViewController {
    
    func Layout() {
        let view1 = UIView()
        view1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(view1)
        NSLayoutConstraint.activate([
            view1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            view1.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5)
            
        ])
        view1.addSubview(avatarUser)
        NSLayoutConstraint.activate([
            avatarUser.centerXAnchor.constraint(equalTo: view1.centerXAnchor),
            avatarUser.centerYAnchor.constraint(equalTo: view1.centerYAnchor),
            avatarUser.widthAnchor.constraint(equalTo: view1.widthAnchor, multiplier: 0.5),
            avatarUser.heightAnchor.constraint(equalTo: view1.heightAnchor, multiplier: 0.7)
        ])
        
     let view2 = UIView()
        view2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(view2)
        NSLayoutConstraint.activate([
            view2.topAnchor.constraint(equalTo: view1.bottomAnchor),
            view2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            view2.heightAnchor.constraint(equalTo: view1.heightAnchor, multiplier: 0.3)
        ])
        view2.addSubview(emailText)
        NSLayoutConstraint.activate([
            emailText.topAnchor.constraint(equalTo: view2.topAnchor),
            emailText.centerXAnchor.constraint(equalTo: view2.centerXAnchor),
            emailText.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 0.3),
            emailText.widthAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 2.0)
        ])
        view2.addSubview(adminText)
        NSLayoutConstraint.activate([
            adminText.topAnchor.constraint(equalTo: emailText.bottomAnchor, constant: 20),
            adminText.centerXAnchor.constraint(equalTo: view2.centerXAnchor),
            adminText.heightAnchor.constraint(equalTo: emailText.heightAnchor),
            adminText.widthAnchor.constraint(equalTo: emailText.widthAnchor)
        ])
        view.addSubview(btnLogOut)
        NSLayoutConstraint.activate([
            btnLogOut.topAnchor.constraint(equalTo: view2.bottomAnchor),
            btnLogOut.centerXAnchor.constraint(equalTo: view2.centerXAnchor),
            btnLogOut.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 0.3),
            btnLogOut.widthAnchor.constraint(equalTo: view2.widthAnchor, multiplier: 0.3)
        ])
    }
}
