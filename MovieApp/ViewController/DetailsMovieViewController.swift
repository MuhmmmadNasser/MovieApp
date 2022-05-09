//
//  DetailsMovieViewController.swift
//  MovieApp
//
//  Created by Mohamed on 13/08/2021.
//

import UIKit
import SDWebImage
import youtube_ios_player_helper
import CoreData
import Cosmos

class DetailsMovieViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var favouriteBtnOutlet: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var reviewsTextView: UITextView!
    @IBOutlet weak var overViewLabel: UILabel!
    
 
    
    //MARK: - Variables
    
    var appDelegate: AppDelegate!
    var managedObjectContext: NSManagedObjectContext!
    
    //static var IMG_KEY = "image"
    
    var objMovie : Movie!
    var trailerArray: [Result] = []
    var reviewArr: [ReviewsContent] = []
    var movieArr: [Movie] = []
    
    
    // USER DEFAULTS
    let userDefault = UserDefaults.standard
    
//    var name: String = ""
//    var img: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        movieNameLabel.text = objMovie.title
        releaseDateLabel.text = objMovie.releaseDate
        
        
        let urlImg = "https://image.tmdb.org/t/p/w185/\(objMovie.posterPath)"
        movieImg.sd_setImage(with: URL(string: urlImg), placeholderImage: UIImage(systemName: "exclamationmark.triangle.fill"))
        movieImg.layer.cornerRadius = 10
        movieImg.layer.borderWidth = 1.5
        movieImg.layer.borderColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        movieImg.clipsToBounds = true
        
    
        overViewLabel.text = objMovie.overview
        
        cosmosView.rating = objMovie.voteAverage / 2.0
        cosmosView.settings.updateOnTouch = false
        
        // CoreData
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
        /*
        // User defaults
        let isSelected = UserDefaults.standard.bool(forKey: "highLightStar\(objMovie.title)")
        if isSelected {
            favouriteBtnOutlet.setImage(UIImage.init(systemName: "star.fill"), for: .normal)
        }else{
            favouriteBtnOutlet.setImage(UIImage.init(systemName: "star"), for: .normal)
        
            print("star is slash")
        }
        //updateBackGround(isSelected: isSelected)
        */
        
        
        //Check if the star is highlight or no
        let highLightCheck = userDefault.bool(forKey: "highLightStar\(objMovie.title)")
        if highLightCheck {
            favouriteBtnOutlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }else{
            favouriteBtnOutlet.setImage(UIImage(systemName: "star"), for: .normal)
        }
        favouriteBtnOutlet.tintColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        
        
        /*
        //Check if the star is highlight or no
        let highLightCheck = userDefault.bool(forKey: "highLightStar \(objMovie.title)")
        if highLightCheck {
            favouriteBtnOutlet.setImage(UIImage.init(systemName: "star.fill"), for: .normal)
        }else{
            favouriteBtnOutlet.setImage(UIImage.init(systemName: "star"), for: .normal)
        }
 */
        favouriteBtnOutlet.tintColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //MARK: - Trailer *****************************************************************
        
        let apiTrailer: TrailerAPIProtocol = TrailerAPI()
        apiTrailer.getTrailer(key: objMovie.id) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                
                case .success(let response):
                    self.trailerArray = response?.results ?? []
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        /*
        TrailerApiManage().fetchTrailerData(key: objMovie.id) { (fetchArr, error) in
            if let unwrappedArray = fetchArr{
                
                self.trailerArray = unwrappedArray
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            if let unwrappedError = error{
                print(unwrappedError)
            }
        }
        */
        setupUi()
        
        
        //MARK: - REVIEWS *****************************************************************
        
        let apiReview: ReviewsAPIProtocol = ReviewsAPI()
        apiReview.ReviewsAPI(id: objMovie.id) { (result) in
            
            var text = ""
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.reviewArr = response?.results ?? []
                    for item in self.reviewArr{
                        text.append("\(item.author)\n")
                        text.append("\(item.content)\n\n")
                        self.reviewsTextView.text = text
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    
        /*
        ReviewsApiManage().fetchReviewsData(id: objMovie.id) { [self] (fetchReview, error) in
        
            if let unwrapedFetchedArray = fetchReview{
                
                self.reviewArr = unwrapedFetchedArray
                var text = ""
                DispatchQueue.main.async {
                    for item in reviewArr{
                        text.append("\(item.author)\n")
                        text.append("\(item.content)\n\n")
                        reviewsTextView.text = text
                    }
                }
            }
            if let unwrapedError = error{
                print(unwrapedError)
            }
 
        }*/
        
    }
    
    
    // MARK: - Favourite Movie *********************************************************
    @IBAction func favouriteBtn(_ sender: UIButton) {
        
        favouriteBtnOutlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
        userDefault.setValue(true, forKey: "highLightStar\(objMovie.title)" )
        saveData(obj: objMovie)
        
        
        /*
        favouriteBtnOutlet.setImage(UIImage.init(systemName: "star.fill"), for: .normal)
        userDefault.setValue(true, forKey: "highLightStar \(objMovie.title)" )
        saveData(obj: objMovie)
        */
        /*
        if sender.isSelected == false{
            
            sender.isSelected = true
            var favImgBtn = favouriteBtnOutlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
            userDefault.setValue(true, forKey: "highLightStar \(objMovie.title)" )
            //saveData(obj: objMovie)
            
        }else{
            sender.isSelected = false
            var favImgBtn =  favouriteBtnOutlet.setImage(UIImage(systemName: "star"), for: .normal)
            userDefault.setValue(true, forKey: "highLightStar \(objMovie.title)" )
            //saveData(obj: objMovie)
        }
        */
        /*
        if sender.isSelected == false{
            var favImgBtn = favouriteBtnOutlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
            sender.isSelected = true

            
            
            let name = movieNameLabel.text
            let imag = objMovie.posterPath
            
            //let imag = "\(movieImg.image)"
            //let movImg = "https://image.tmdb.org/t/p/w185/\(movieImg)"
            /*
            let entity = NSEntityDescription.entity(forEntityName: "MovieData", in: managedObjectContext)!
            let movie = NSManagedObject(entity: entity, insertInto: managedObjectContext)
            
            movie.setValue(name, forKey: "name")
            movie.setValue(imag, forKey: "img")
            
            do{
                try managedObjectContext.save()
                print("save data")
            }
            catch let error as NSError{
                print(error.localizedDescription)
            }
            */
            /*
        favouriteBtnOutlet.setImage(UIImage(systemName: "star.fill"), for: .normal)
            updateBackGround(isSelected: sender.isSelected)
            UserDefaults.standard.setValue(sender.isSelected, forKey: "switchIsOn")
 */
            saveData()
            
            /*
            let vc = storyboard?.instantiateViewController(identifier: "Favourite") as! FavouriteTableViewController
           // vc.objFavouriteArray = movieArr[]
//            vc.img = objMovie.posterPath
//            vc.name = objMovie.title
            navigationController?.pushViewController(vc, animated: true)
            */
         
        }
        else{
            sender.isSelected = false
         var favImgBtn =  favouriteBtnOutlet.setImage(UIImage(systemName: "star.slash"), for: .normal)
            
        }
 */
 
    }
    
    
    /*
    private func updateBackGround(isSelected: Bool) {
        if isSelected {
            
            favouriteBtnOutlet.setImage(UIImage.init(systemName: "star.fill"), for: .normal)
            isSelected = true
            
            print("star is fill")
       }//else{
            favouriteBtnOutlet.setImage(UIImage.init(systemName: "star.slash"), for: .normal)
            isSelected = false
            print("star is slash")

        }
    }
   */
   
    
    
    //MARK: - Show Reviews
    @IBAction func reviewsBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "Reviews") as! ReviewsViewController
        if let text = reviewsTextView.text{
            vc.reviewText = "\(text)"
        }
        navigationController?.pushViewController(vc, animated: true)
 
    }
  
    func saveData(obj: Movie){
        
        //let name = movieNameLabel.text!
        let name = "\(obj.title)"
        //print(name)
        let imag = "\(obj.posterPath)"
        //print(imag)
        
        let entity = NSEntityDescription.entity(forEntityName: "MovieData", in: managedObjectContext)!
        let movie = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        
        movie.setValue(name, forKey: "name")
        movie.setValue(imag, forKey: "img")
        
        do{
            try managedObjectContext.save()
            print("save data")
        }
        catch let error as NSError{
            print(error.localizedDescription)
        }
        
    }
    
}


    // MARK: - Movie Trailer *****************************************************************

extension  DetailsMovieViewController: UICollectionViewDelegate,UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        trailerArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SingleTrailerCollectionViewCell
        
        cell.playerView.load(withVideoId: "\(trailerArray[indexPath.row].key)")
        
        return cell
    }
    
    func setupUi(){
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
 
        item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 1, trailing: 2)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitem: item, count: 1)
     
        let section = NSCollectionLayoutSection(group: group)
        
        //section.orthogonalScrollingBehavior = .continuous
        section.orthogonalScrollingBehavior = .paging
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        collectionView.collectionViewLayout = layout
    }
    
}
