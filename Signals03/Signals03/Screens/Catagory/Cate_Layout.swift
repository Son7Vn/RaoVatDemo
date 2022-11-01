//
//  Cate_Layout.swift
//  Signals03
//
//  Created by SonGoku on 11/09/2022.
//

import UIKit

extension Catagory_ViewController {
    func Layout() {
        
        let view1 = UIView()
        view1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(view1)
        NSLayoutConstraint.activate([
            view1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            view1.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.25)
        ])
        view1.addSubview(imgCate)
        NSLayoutConstraint.activate([
            imgCate.centerXAnchor.constraint(equalTo: view1.centerXAnchor),
            imgCate.centerYAnchor.constraint(equalTo: view1.centerYAnchor),
            imgCate.widthAnchor.constraint(equalTo: view1.widthAnchor, multiplier: 0.3),
            imgCate.heightAnchor.constraint(equalTo: imgCate.widthAnchor, multiplier: 1)
        ])
        
        let view2 = UIView()
//        view2.backgroundColor = .systemGray
        view2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(view2)
        NSLayoutConstraint.activate([
            view2.topAnchor.constraint(equalTo: view1.bottomAnchor),
            view2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            view2.heightAnchor.constraint(equalTo: view1.heightAnchor, multiplier: 2)
        ])
        view2.addSubview(txtNhomSP)
        NSLayoutConstraint.activate([
            txtNhomSP.topAnchor.constraint(equalTo: view2.topAnchor,constant: 20),
            txtNhomSP.centerXAnchor.constraint(equalTo: view2.centerXAnchor),
            txtNhomSP.widthAnchor.constraint(equalTo: view2.widthAnchor, multiplier: 0.8),
            txtNhomSP.heightAnchor.constraint(equalTo: txtNhomSP.widthAnchor, multiplier: 0.15)
        ])
        view2.addSubview(txtDiaDiem)
        NSLayoutConstraint.activate([
            txtDiaDiem.topAnchor.constraint(equalTo: txtNhomSP.bottomAnchor, constant: 10),
            txtDiaDiem.centerXAnchor.constraint(equalTo: view2.centerXAnchor),
            txtDiaDiem.widthAnchor.constraint(equalTo: txtNhomSP.widthAnchor),
            txtDiaDiem.heightAnchor.constraint(equalTo: txtNhomSP.heightAnchor)
        ])
        view2.addSubview(txtTenSP)
        NSLayoutConstraint.activate([
            txtTenSP.topAnchor.constraint(equalTo: txtDiaDiem.bottomAnchor, constant: 10),
            txtTenSP.centerXAnchor.constraint(equalTo: view2.centerXAnchor),
            txtTenSP.widthAnchor.constraint(equalTo: txtDiaDiem.widthAnchor),
            txtTenSP.heightAnchor.constraint(equalTo: txtDiaDiem.heightAnchor)
        ])
        view2.addSubview(txtGia)
        NSLayoutConstraint.activate([
            txtGia.topAnchor.constraint(equalTo: txtTenSP.bottomAnchor, constant: 10),
            txtGia.centerXAnchor.constraint(equalTo: view2.centerXAnchor),
            txtGia.widthAnchor.constraint(equalTo: txtTenSP.widthAnchor),
            txtGia.heightAnchor.constraint(equalTo: txtTenSP.heightAnchor)
        ])
        view2.addSubview(txtPhone)
        NSLayoutConstraint.activate([
            txtPhone.topAnchor.constraint(equalTo: txtGia.bottomAnchor, constant: 10),
            txtPhone.centerXAnchor.constraint(equalTo: view2.centerXAnchor),
            txtPhone.widthAnchor.constraint(equalTo: txtGia.widthAnchor),
            txtPhone.heightAnchor.constraint(equalTo: txtGia.heightAnchor)
        ])
        
        let view3 = UIView()
        view3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(view3)
        NSLayoutConstraint.activate([
            view3.topAnchor.constraint(equalTo: view2.bottomAnchor),
            view3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view3.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            view3.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        view3.addSubview(btn_AddTin)
        NSLayoutConstraint.activate([
            btn_AddTin.topAnchor.constraint(equalTo: view3.topAnchor),
            btn_AddTin.centerXAnchor.constraint(equalTo: view2.centerXAnchor),
            btn_AddTin.widthAnchor.constraint(equalTo: txtGia.widthAnchor),
            btn_AddTin.heightAnchor.constraint(equalTo: txtGia.heightAnchor)
        ])
    }
}
