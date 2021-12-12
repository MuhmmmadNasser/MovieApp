//
//  FavouriteTableViewController.swift
//  MovieApp
//
//  Created by Mohamed on 14/08/2021.
//

import UIKit
import SDWebImage
import CoreData

class FavouriteTableViewController: UITableViewController {
    
    //var objFavouriteArray: Movie!
//    var img: String = ""
//    var name: String = ""
    
    
    var appDelegate: AppDelegate!
    var managedObjectContext: NSManagedObjectContext!
    
    //var favMovieArray: [Favourite] = []
    var favMovieArray: [Movie] = []
    var coreDataMovieArray: [NSManagedObject] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
 
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return favouriteArray.count
        favMovieArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SingleFavouriteTableViewCell

        cell.movieName?.text = favMovieArray[indexPath.row].title
        let image = favMovieArray[indexPath.row].posterPath
        let urlImg = "https://image.tmdb.org/t/p/w185/\(image)"
        cell.movieImg?.sd_setImage(with: URL(string: "\(urlImg)"), placeholderImage: UIImage(systemName: "exclamationmark.triangle.fill"))
        
        return cell
        
        
//        cell.movieImg.image = UIImage(named: "1")
//        cell.movieName.text = "vxvc"
        //cell.movieImg.image = UIImage(named: favMovieArray[indexPath.row].img)
        
//        let urlImg = "https://image.tmdb.org/t/p/w185/\(favouriteArray[indexPath.row].img)"
//        cell.movieImg.sd_setImage(with: URL(string: urlImg), placeholderImage: UIImage(systemName: "exclamationmark.triangle.fill"))
        
        
//        cell.movieName.text = name
//        let urlImg = "https://image.tmdb.org/t/p/w185/\(img)"
//        cell.movieImg.sd_setImage(with: URL(string: urlImg), placeholderImage: UIImage(systemName: "exclamationmark.triangle.fill"))
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            let userDefault = UserDefaults.standard
            let deletedMovieTitle = favMovieArray[indexPath.row].title
            userDefault.setValue(false, forKey: "highLightStar\(deletedMovieTitle)" )
            
            print("delete")
            
            favMovieArray.remove(at: indexPath.row )
            managedObjectContext.delete(coreDataMovieArray[indexPath.row])
            
            do{
                try managedObjectContext.save()
            }
            catch let error as NSError{
                print(error.localizedDescription)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
     
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    func fetchData(){
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieData")

        do{
            coreDataMovieArray = try managedObjectContext.fetch(fetchRequest)
            favMovieArray.removeAll()
            
            for mov in coreDataMovieArray{
                
                let name = mov.value(forKey: "name") as! String
                let image = mov.value(forKey: "img") as! String
                
                //let movObj = Favourite(name: name, img: image)
                let movObj = Movie(id: 0, voteAverage: 0.0, posterPath: image, releaseDate: "", title: name, overview: "", popularity: 0.0)
                favMovieArray.append(movObj)
            }
            tableView.reloadData()
        }
        catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    

}
