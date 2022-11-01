//
//  NhomSP_CollectionViewController.swift
//  Signals03
//
//  Created by SonGoku on 12/09/2022.
//

import UIKit

private let reuseIdentifier = "Cell"

protocol CateSelec_Delegate {
    func cateSelection(nhomSP: NhomSP_Ser)
}

class NhomSP_CollectionViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrCate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NhomSP_CollectionViewCell
        let imageURL = Config.ServerURL + "/upload/" + arrCate[indexPath.item].imageName
        
        let dataIMG = try? Data(contentsOf: URL(string: imageURL)!)
        
        cell.imgColl.image = UIImage(data: dataIMG!)
        
        cell.lbl_Coll.text = arrCate[indexPath.item].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height / 3)
    }
    
    @IBOutlet weak var nhomSPColl: UICollectionView!
    var arrCate = [NhomSP_Ser]()
    var delegate : CateSelec_Delegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nhomSPColl.delegate = self
        nhomSPColl.dataSource = self
        
        loadNhomSP()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Pick Me: ", indexPath.item)
        
        let chonNhomSP: NhomSP_Ser = arrCate[indexPath.row]
        print(chonNhomSP)
        delegate?.cateSelection(nhomSP: chonNhomSP)
    }
    
    private func loadNhomSP() {
        
        let url = URL(string: Config.ServerURL + "/Cate/findAll")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        
        let urlSession = URLSession.shared
        urlSession.dataTask(with: urlRequest) { data_Cate, urlRespone, err in
            if (err != nil) {
                print("Error to request API", err as Any)
            } else {
                let decodeEx = JSONDecoder()
                let dataDecode = try? decodeEx.decode(dataServer_Cate.self, from: data_Cate!)
                self.arrCate = dataDecode!.messenger
                print(self.arrCate[0])
                DispatchQueue.main.async {
                    self.nhomSPColl.reloadData()
                }
                
            }
        }.resume()
    }
    
}
