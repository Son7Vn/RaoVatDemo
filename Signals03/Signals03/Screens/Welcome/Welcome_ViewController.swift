//
//  Welcome_ViewController.swift
//  Signals03
//
//  Created by SonGoku on 22/08/2022.
//

import UIKit

class Welcome_ViewController: UIViewController {

    @IBOutlet weak var myLogo: UIImageView!
    var myBackgroundIMG = UIImageView(image: UIImage(named: "licogi12"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContrains()
        
        view.addSubview(self.myBackgroundIMG)
        view.addSubview(self.myLogo)
        self.myBackgroundIMG.bringSubviewToFront(myLogo)
        self.myLogo.layer.zPosition = 1
        
        animateViews()
    }
    
    func setupContrains() {
        self.myBackgroundIMG.frame.origin = CGPoint(x: 0, y: 0)
        self.myBackgroundIMG.frame.size = CGSize(width: self.view.frame.size.width * 3, height: self.view.frame.size.height * 3)
        self.myBackgroundIMG.alpha = 0.2
        
        self.myLogo.frame.size = CGSize(width: self.view.frame.size.width/3, height: self.myLogo.frame.size.width * (3/4))
        self.myLogo.frame.origin.x = 0 - myLogo.frame.size.width
    }
    
    func animateViews() {
        UIView.animate(withDuration: 4) {
            self.myBackgroundIMG.frame.size = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
            self.myBackgroundIMG.alpha = 0.8
        } completion: { com in }
        
        UIView.animate(withDuration: 3) {
            self.myLogo.center.x = self.view.center.x
            self.myLogo.center.y = self.view.center.y
            self.myLogo.alpha = 0.7
        } completion: { com in }
    }
    
//    @objc func handleTapOnLogo(_ sender: UITapGestureRecognizer) {
//        print("Hello")
//    }
    

}
