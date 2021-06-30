//
//  DetailViewController.swift
//  MarvelApp
//
//  Created by admin on 6/24/21.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var eventos: UICollectionView!
    @IBOutlet weak var series: UICollectionView!
    @IBOutlet weak var portadas: UICollectionView!
    
    var detailCell: MCell = MCell(xibName: "PortadasCell", idReuse: "PortadasCell")
    var seriesCell: MCell = MCell(xibName: "SeriesCell", idReuse: "SerieCell")
    var eventCell: MCell = MCell(xibName: "EventsCell", idReuse: "EventsCell")
    
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailDescription: UILabel!
    
    
    var detailHero = CharacterResult()
    var allComics: [ComicResult] = []
    var allSeries: [SeriesResult] = []
    var allEvents: [EventResult] = []
    var client = NetworkClient()
    
    // MARK: - VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerEvents()
        registerComics()
        registerSeries()
        
        initData(data: detailHero)
        comicSetup()
        
        
    }
    
    // MARK: - CARGANDO COMICS
    
    func comicSetup(){
        
        guard let secureId = detailHero.id else{return}
        print("hola \(secureId)")
        
        client.getComics(characterId: secureId){result in
            switch result {
            case .success(let comicos):
                
                guard let secureComicos = comicos.data?.results else {return}
                
                self.allComics.append(contentsOf: secureComicos)
                self.portadas.reloadData()
                
            case .failure(let error):
                // Mostrar una alerta al usuarios con el errorDescription
                print(error.errorDescription as Any)
            }
        }
        
        client.getSeries(characterId: secureId){result in
            switch result {
            
            case .success(let series):
            
                guard let secureSeries = series.data?.results else {return}
                
                self.allSeries.append(contentsOf: secureSeries)
                self.series.reloadData()
                print("hola event2 \(self.allSeries)")
                
            case .failure(let error):
                // Mostrar una alerta al usuario con el errorDescription
                print(error.errorDescription as Any)
            }
        }
        client.getEvents(characterId: secureId){result in
            switch result {
            
            case .success(let eventos):
            
                guard let secureEventos = eventos.data?.results else {return}
                
                self.allEvents.append(contentsOf: secureEventos)
                self.eventos.reloadData()
                print("hola event2 \(self.allEvents)")
                
            case .failure(let error):
                // Mostrar una alerta al usuario con el errorDescription
                print(error.errorDescription as Any)
            }
        }
       
    }
    
    // MARK: - CARGANDO LAS CELL
    
    func registerComics() {
         let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal
           layout.minimumLineSpacing = 8
           layout.minimumInteritemSpacing = 0
           layout.estimatedItemSize = CGSize(width: 200, height: 250)
           
       
           portadas.setCollectionViewLayout(layout, animated: true)
           portadas.register(UINib(nibName: detailCell.xibName, bundle: nil), forCellWithReuseIdentifier: detailCell.idReuse)
        
    }
    func registerSeries() {
        
         let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal
           layout.minimumLineSpacing = 8
           layout.minimumInteritemSpacing = 0
           layout.estimatedItemSize = CGSize(width: 250, height: 250)
           
       
        series.setCollectionViewLayout(layout, animated: true)
        series.register(UINib(nibName: seriesCell.xibName, bundle: nil), forCellWithReuseIdentifier: seriesCell.idReuse)
        
    }
    
    func registerEvents() {
        
         let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal
           layout.minimumLineSpacing = 8
           layout.minimumInteritemSpacing = 0
           layout.estimatedItemSize = CGSize(width: 250, height: 250)
           
       
        eventos.setCollectionViewLayout(layout, animated: true)
        eventos.register(UINib(nibName: eventCell.xibName, bundle: nil), forCellWithReuseIdentifier: eventCell.idReuse)
        
    }
    
    // MARK: - CARGANDO DATOS BASE
    
   func initData (data: CharacterResult){
        detailName.text = data.name
        detailDescription.text = data.description
        
        let httpImage = data.thumbnail?.path
        guard let securehttp = httpImage else{return}
        
        let https = "https" + securehttp.dropFirst(4)
        let url = URL(string: "\(https).jpg")
        
        detailImage.kf.setImage(with: url)
        
        
    }
    
    // MARK: - COLLECTION VIEW
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == portadas {
            
            return allComics.count
        }
        if collectionView == series {
            print(" hola serie \(allSeries.count)")
            return allSeries.count
        }
        if collectionView == eventos {
            print(" hola evento \(allEvents.count)")
            return allEvents.count
        }
       return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView == portadas {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCell.idReuse, for: indexPath) as! PortadasCell
                
                cell.setPortada(data: allComics[indexPath.row])
                
                return cell
        }
        else
        if collectionView == series {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: seriesCell.idReuse, for: indexPath) as! SeriesCell
            
         //   if let secureEvent = allEvents[indexPath.row] {return}
            
            cell2.setSeries(data: allSeries[indexPath.row])
                
                return cell2
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventCell.idReuse, for: indexPath) as! EventsCell
                
            cell.setEvento(data: allEvents[indexPath.row])
                
                return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cell: UICollectionViewCell
        if collectionView == portadas {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCell.idReuse, for: indexPath) as! PortadasCell
        }else if collectionView == series{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: seriesCell.idReuse, for: indexPath) as! SeriesCell
        }else if collectionView == eventos{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventCell.idReuse, for: indexPath) as! EventsCell
        } else {
            cell = UICollectionViewCell()
        }
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let size: CGSize  = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGSize(width: size.width, height: 30)
        
        
        
    }
    
   
}
