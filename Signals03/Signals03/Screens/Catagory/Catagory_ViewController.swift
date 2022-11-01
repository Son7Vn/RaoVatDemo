//
//  Catagory_ViewController.swift
//  Signals03
//
//  Created by SonGoku on 22/08/2022.
//

import UIKit

class Catagory_ViewController: UIViewController  {
    

    let imgCate: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "logo")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var txtNhomSP: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Chon NhomSP", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .systemGray
        btn.layer.cornerRadius = 2.0
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(nhomspAction), for: .touchUpInside)
        return btn
    }()
    @objc private func nhomspAction() {
        
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let nhomSPPage = sb.instantiateViewController(withIdentifier: "NHOMSP") as! NhomSP_CollectionViewController
        nhomSPPage.delegate = self
        self.navigationController?.pushViewController(nhomSPPage, animated: true)
        
        
    }
    
    lazy var txtDiaDiem: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Dia diem", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .systemGray
        btn.layer.cornerRadius = 2.0
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(diadiemAction), for: .touchUpInside)
        return btn
    }()
    @objc func diadiemAction() {
        print("Them dia diem")
    }
    
    let txtTenSP: LeftPadderTextField = {
        let txt = LeftPadderTextField()
        txt.placeholder = "Ten san pham"
        txt.layer.cornerRadius = 1.0
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.layer.borderWidth = 1
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let txtGia: LeftPadderTextField = {
        let txt = LeftPadderTextField()
        txt.placeholder = "Gia san pham"
        txt.layer.cornerRadius = 1.0
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.layer.borderWidth = 1
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let txtPhone: LeftPadderTextField = {
        let txt = LeftPadderTextField()
        txt.placeholder = "So dien thoai"
        txt.layer.cornerRadius = 1.0
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.layer.borderWidth = 1
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let btn_AddTin: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Them San Pham", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .orange
        btn.layer.cornerRadius = 2.0
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        Layout()
        
    }
    
}

extension Catagory_ViewController: CateSelec_Delegate {
    func cateSelection(nhomSP: NhomSP_Ser) {
        print("Hello")
        self.navigationController?.popViewController(animated: true)
        DispatchQueue.main.async {
            let urlIMG = Config.ServerURL + "/upload/" + nhomSP.imageName
            let dataImg = try? Data(contentsOf: URL(string: urlIMG)!)
            self.imgCate.image = UIImage(data: dataImg!)
        }
    }
}
