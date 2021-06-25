//
//  HeroCell.swift
//  MarvelApp
//
//  Created by admin on 6/22/21.
//

import UIKit
import Kingfisher

class HeroCell: UITableViewCell {

    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func initData (data: CharacterResult){
        heroName.text = data.name
        heroDescription.text = data.description
        
        let httpImage = data.thumbnail?.path
        guard let securehttp = httpImage else{return}
        
        let https = "https" + securehttp.dropFirst(4)
        let url = URL(string: "\(https).jpg")
        
        heroImage.kf.setImage(with: url)
        
        //print("aaa \(https)")
        
    }
}
