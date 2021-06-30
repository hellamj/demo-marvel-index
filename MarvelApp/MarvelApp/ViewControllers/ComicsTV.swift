//
//  ComicsTV.swift
//  MarvelApp
//
//  Created by admin on 6/22/21.
//

import UIKit

class ComicsTV: UITableViewController {
    
    var isLoading = false
    var misCells: MCell = MCell(xibName: "HeroCell", idReuse: "HeroCell")
    var loadCell: MCell = MCell(xibName: "LoadingCell", idReuse: "LoadingCell")
    let client = NetworkClient()
    var heroes: [CharacterResult] = []
    var offset: Int = 0
    var currentPosition: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "marvel")
        imageView.image = image
        navigationItem.titleView = imageView
        
        networkSetup()
        
        
        let tableViewLoadingCellNib = UINib(nibName: loadCell.xibName, bundle: nil)
        self.tableView.register(tableViewLoadingCellNib, forCellReuseIdentifier: loadCell.idReuse)
        
        self.tableView?.register(UINib(nibName: misCells.xibName, bundle: nil), forCellReuseIdentifier: misCells.idReuse)
    }
    
    // MARK: - Network Setup (CARGANDO LOS PERSONAJES)
    
    func networkSetup(){
        client.getCharacters(offset: offset){result in
            switch result {
            case .success(let characters):
                print(characters.data?.results?.first as Any)
                guard let secureChar = characters.data?.results else{
                    return
                }
                self.offset += secureChar.count
                //ESTA LINEA ES IMPORTANTISIMA PARA QUE VAYA EL SCROLL LOCO
                self.heroes.append(contentsOf: secureChar)
                self.tableView.reloadData()
                self.isLoading = false
                
            case .failure(let error):
                // Mostrar una alerta al usuarios con el errorDescription
                print(error.errorDescription as Any)
            }
        }
    }
    
    
    // MARK: - TABLEVIEW
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return heroes.count
        } else if section == 1 {
            //Return the Loading cell
            return 1
        } else {
            //Return nothing
            return 0
        }
        // #warning Incomplete implementation, return the number of rows
        //return heroes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: misCells.idReuse, for: indexPath) as! HeroCell
            
            cell.initData(data: heroes[indexPath.row])
            //cell.heroName.text = self.heroes[indexPath.row].name
            
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: loadCell.xibName, for: indexPath) as! LoadingCell
            cell.activityIndicator.startAnimating()
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let cell = tableView.dequeueReusableCell(withIdentifier: misCells.idReuse, for: indexPath) as! HeroCell
        if indexPath.section == 0 {
        currentPosition = indexPath.row
        print("hola soy tu amiga cell")
            performSegue(withIdentifier: "segueComic", sender: self)
            
        }
    }
    
    // MARK: - SETTINGS SCROLL INFINITO
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100 //Item Cell height
        } else {
            return 55 //Loading Cell height
        }
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (offsetY > contentHeight - scrollView.frame.height * 5) && !isLoading {
            loadMoreData()
        }
    }
    
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            networkSetup()
            
        }
    }
    
    // MARK: - PREPARE FOR SEGUE
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueComic" {
            guard let destino = segue.destination as? DetailViewController else {return}
            destino.detailHero = heroes[currentPosition]
            print("Hola que tal")
        }
    }
    
}


