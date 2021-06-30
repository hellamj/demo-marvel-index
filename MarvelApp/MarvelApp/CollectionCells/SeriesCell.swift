//
//  SeriesCell.swift
//  MarvelApp
//
//  Created by admin on 6/29/21.
//

import UIKit

class SeriesCell: UICollectionViewCell {

    @IBOutlet weak var imageSeries: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setSeries(data: SeriesResult){
        
        let httpImage = data.thumbnail?.path
        guard let securehttp = httpImage else{return}
        let ext = data.thumbnail?.imageExtension
        guard let secureExt = ext else{return}
        
        let https = "https" + securehttp.dropFirst(4)
        let url = URL(string: "\(https).\(secureExt)")
        
        //print("\(url)")
        imageSeries.kf.setImage(with: url)
        
        
    }

}
