//
//  ViewController.swift
//  MovieApp
//
//  Created by Mohamed on 13/08/2021.
//

import UIKit
import SDWebImage
import CoreData
import Network


class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var leftConstrainSideMenu: NSLayoutConstraint!
    
    @IBOutlet weak var sortView: UIView!
    
    
    var movieArray: [Movie] = []
    var objMovie: Movie!
    
    var appDelegate: AppDelegate!
    var managedObjectContext: NSManagedObjectContext!
    
    //    var coreDataMovieArray: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
        self.collectionView.addSubview(self.sortView)
        
        monitorNetwork()
        
        // fetchData()
        
        
    }
    
    func monitorNetwork(){
        let monitor = NWPathMonitor()
        
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
                //self.saveData()
                //self.displayData()
            } else {
                print("There's no internet connection.")
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Network", message: "There's no internet connection.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    //self.displayData()
                }
            }
        }
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.start(queue: queue)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        activityIndicator.startAnimating()
        
        
        /*
         HomeMovieApiManager().fetchData { (movieArr, error)  in
         
         self.activityIndicator.stopAnimating()
         
         if let unwrappedMoviesArray = movieArr{
         
         self.movieArray = unwrappedMoviesArray
         
         DispatchQueue.main.async {
         self.collectionView.reloadData()
         }
         }
         if let unwrappedError = error{
         print(unwrappedError)
         }
         }
         */
        
        
        let api: MoviesAPIProtocol = MoviesAPI()
        api.getMovies { (result) in
            self.activityIndicator.stopAnimating()
            
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    
                    self.movieArray = response?.results ?? []
                    print(self.movieArray)
                    self.collectionView.reloadData()
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
            /*
             let api = MoviesAPI()
             
             api.getMovies { movieArr, error in
             self.activityIndicator.stopAnimating()
             
             if let unwrappedArray = movieArr {
             self.movieArray = unwrappedArray
             
             DispatchQueue.main.async {
             self.collectionView.reloadData()
             }
             }
             if let unwrappedError = error{
             print(unwrappedError)
             }
             }*/
        
            setUpUI()
            
        }
        
        func setUpUI(){
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)), subitem: item, count: 2)
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            
            let layout = UICollectionViewCompositionalLayout(section: section)
            
            collectionView.collectionViewLayout = layout
        }
        
        func saveData(){
            
            let entity = NSEntityDescription.entity(forEntityName: "MovieData", in: managedObjectContext)!
            let movie = NSManagedObject(entity: entity, insertInto: managedObjectContext)
            
            movie.setValue(objMovie.posterPath, forKey: "img")
            movie.setValue(objMovie.title, forKey: "name")
            movie.setValue(objMovie.voteAverage, forKey: "rating")
            // movie.setValue(objMovie.releaseDate, forKey: "releaseYear")
            //movie.setValue(objMovie.overview, forKey: "overview")
            
            do{
                try managedObjectContext.save()
                print("save data")
                //print(movie)
            }
            catch let error as NSError{
                print(error.localizedDescription)
            }
        }
        
        
        func displayData(){
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieData")
            
            do{
                let movies = try managedObjectContext.fetch(fetchRequest)
                
                for mov in movies{
                    let movName = mov.value(forKey: "name") as! String
                    let movImg = mov.value(forKey: "img") as! String
                    let movRating = mov.value(forKey: "rating") as! Double
                    let movReleaseYear = mov.value(forKey: "releaseYear") as! String
                    let movOverview = mov.value(forKey: "overview") as! String
                    
                    let movObj = Movie(id: 0, voteAverage: movRating, posterPath: movImg, releaseDate: movReleaseYear, title: movName, overview: movOverview, popularity: 0.0)
                    movieArray.append(movObj)
                    print(movieArray)
                }
            }
            catch let error as NSError{
                print(error.localizedDescription)
            }
        }
        
        
        //MARK:- SORT BUTTON ********************************************
        
        @IBAction func sortSideMenu(_ sender: Any) {
            if  leftConstrainSideMenu.constant == 150{
                leftConstrainSideMenu.constant = 0
            }else{
                leftConstrainSideMenu.constant = 150
            }
        }
        
        @IBAction func highstRateSortBtn(_ sender: Any) {
            activityIndicator.startAnimating()
            /*
             let sortedArray = movieArray.sorted { (first, second) -> Bool in
             first.voteAverage > second.voteAverage
             }*/
            
            let sortedArray = movieArray.sorted { $0.voteAverage > $1.voteAverage }
            
            
            movieArray = sortedArray
            collectionView.reloadData()
            activityIndicator.stopAnimating()
        }
        
        @IBAction func prpularitySortBtn(_ sender: Any) {
            activityIndicator.startAnimating()
            let sortedArray = movieArray.sorted { (first, second) -> Bool in
                first.popularity > second.popularity
            }
            movieArray = sortedArray
            collectionView.reloadData()
            activityIndicator.stopAnimating()
        }
        
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            movieArray.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SingleMovieCollectionViewCell
            //cell.movieImg.image = UIImage(systemName: "exclamationmark.triangle.fill")
            
            let urlImg = "https://image.tmdb.org/t/p/w185/\(movieArray[indexPath.row].posterPath)"
            cell.movieImg.sd_setImage(with: URL(string: urlImg), placeholderImage: UIImage(systemName: "exclamationmark.triangle.fill"))
            
            cell.movieImg.layer.cornerRadius = 10
            cell.movieImg.layer.borderWidth = 1.5
            cell.movieImg.layer.borderColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
            cell.movieImg.clipsToBounds = true
            
            return cell
        }
        
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            let vc = storyboard?.instantiateViewController(identifier: "DetailsMovie") as! DetailsMovieViewController
            
            //        vc.name = movieArray[indexPath.row].title
            //        vc.img = movieArray[indexPath.row].posterPath
            vc.objMovie = movieArray[indexPath.row]
            //vc.id = "\(movieArray[indexPath.row].id)"
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }

