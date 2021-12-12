//
//  LocalCoreData.swift
//  MovieApp
//
//  Created by Mohamed on 30/08/2021.
//

import Foundation
import CoreData


/*
class LocalCoreData {
    
    var appDelegate: AppDelegate!
    var managedObjectContext: NSManagedObjectContext!
    
    
    var allMovie: [Movie] = []
    
    func saveData(){

        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedObjectContext)!
        let movie = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        
//        movie.setValue(movImg, forKey: "img")
//        movie.setValue(, forKey: <#T##String#>)
        
        do{
            try managedObjectContext.save()
            print("save data")
        }
        catch let error as NSError{
            print(error.localizedDescription)
        }
        
    }
    
    
    func fetchData(){
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieData")
        
        do{
            let movies = try managedObjectContext.fetch(fetchRequest)
            
            for mov in movies{
                let movName = mov.value(forKey: "name") as! String
                let movImg = mov.value(forKey: "img") as! String
                let movRating = mov.value(forKey: "rating") as! Double
                let moReleaseYear = mov.value(forKey: "releaseYear") as! String
                //let movObj = MoviesData(img: movImg, name: movName, releaseYear: moReleaseYear, rating: movRating)
                
                let movObj = Movie(id: 0, voteAverage: 0.0, posterPath: "", releaseDate: "", title: "", overview: "", popularity: 0.0)
                allMovie.append(movObj)
                print(allMovie)
            }
        }
        catch let error as NSError{
            print(error.localizedDescription)
        }
    }
}
*/
