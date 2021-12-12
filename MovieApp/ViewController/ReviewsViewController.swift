//
//  ReviewsViewController.swift
//  MovieApp
//
//  Created by Mohamed on 18/08/2021.
//

import UIKit

class ReviewsViewController: UIViewController {

    @IBOutlet weak var reviewTextView: UITextView!
    
    var reviewText: String = ""
   
    override func viewDidLoad() {
        super.viewDidLoad()

        reviewTextView.text = reviewText
        
    }
    

   
    
}
