//
//  PortadasCell.swift
//  MarvelApp
//
//  Created by admin on 6/24/21.
//

import UIKit

class PortadasCell: UICollectionViewCell {
    
    @IBOutlet weak var imagePortada: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code}
    }
    
    func setPortada(data: ComicResult){
        
        let httpImage = data.thumbnail?.path
        guard let securehttp = httpImage else{return}
        let ext = data.thumbnail?.imageExtension
        guard let secureExt = ext else{return}
        
        let https = "https" + securehttp.dropFirst(4)
        let url = URL(string: "\(https).\(secureExt)")
        
        //print("\(url)")
        imagePortada.kf.setImage(with: url)
        
        
    }
    
    
}
