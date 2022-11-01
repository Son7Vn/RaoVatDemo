//
//  Data_Model.swift
//  Signals03
//
//  Created by SonGoku on 12/09/2022.
//

import Foundation

struct dataServer_Cate: Decodable {
    let result: Int
    let messenger: [NhomSP_Ser]
}

struct NhomSP_Ser: Decodable {
    let _id: String
    let name: String
    let imageName: String
}
