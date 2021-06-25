//
//  DetailViewController.swift
//  MarvelApp
//
//  Created by admin on 6/24/21.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    
    @IBOutlet weak var portadas: UICollectionView!
    
    var detailCell: MCell = MCell(xibName: "PortadasCell", idReuse: "PortadasCell")
    
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailDescription: UILabel!
    
    
    var detailHero = CharacterResult()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let httpImage = detailHero.comics?.collectionURI
        guard let securehttp = httpImage else{return}
        
        let https = "https" + securehttp.dropFirst(4)
        let url = URL(string: "\(https).jpg")
        print( "aaa \(url)")
        
        
        initData(data: detailHero)
        // Do any additional setup after loading the view.
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
       layout.estimatedItemSize = CGSize(width: 200, height: 250)
        
        
        portadas.setCollectionViewLayout(layout, animated: true)
        
        portadas.register(UINib(nibName: detailCell.xibName, bundle: nil), forCellWithReuseIdentifier: detailCell.idReuse)
    }
    
    
    func initData (data: CharacterResult){
        detailName.text = data.name
        detailDescription.text = data.description
        
        let httpImage = data.thumbnail?.path
        guard let securehttp = httpImage else{return}
        
        let https = "https" + securehttp.dropFirst(4)
        let url = URL(string: "\(https).jpg")
        
        detailImage.kf.setImage(with: url)
        
        //print("aaa \(https)")
        
    }

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let secureComics = detailHero.comics?.available else {return 0}
        
        return secureComics
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCell.idReuse, for: indexPath) as! PortadasCell
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCell.idReuse, for: indexPath) as! PortadasCell
       
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let size: CGSize  = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGSize(width: size.width, height: 30)
        
    }
   
    
}
