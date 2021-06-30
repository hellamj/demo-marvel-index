//
//  EventsCell.swift
//  MarvelApp
//
//  Created by admin on 6/29/21.
//

import UIKit

class EventsCell: UICollectionViewCell {

    @IBOutlet weak var imageEvent: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setEvento(data: EventResult){
        
        let httpImage = data.thumbnail?.path
        guard let securehttp = httpImage else{return}
        let ext = data.thumbnail?.imageExtension
        guard let secureExt = ext else{return}
        
        let https = "https" + securehttp.dropFirst(4)
        let url = URL(string: "\(https).\(secureExt)")
        
        //print("\(url)")
        imageEvent.kf.setImage(with: url)
    }

}
