//
//  ViewController.swift
//  Project37
//
//  Created by slim on 2017/11/17.
//  Copyright © 2017 halloween-jack. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var cardContainer: UIView!
    
    var allCards = [CardViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCards()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func loadCards() {
        for card in allCards {
            card.view.removeFromSuperview()
            card.removeFromParentViewController()
        }
        
        allCards.removeAll(keepingCapacity: true)
        
        // create an array of card positons
        let positions = [
            CGPoint(x: 75, y: 85),
            CGPoint(x: 185, y: 85),
            CGPoint(x: 295, y: 85),
            CGPoint(x: 405, y: 85),
            CGPoint(x: 75, y: 235),
            CGPoint(x: 185, y: 235),
            CGPoint(x: 295, y: 235),
            CGPoint(x: 405, y: 235)
        ]
        
        // load and unwrap out Zener card images
        let circle = UIImage(named: "cardCircle")!
        let cross = UIImage(named: "cardCross")!
        let lines = UIImage(named: "cardLines")!
        let square = UIImage(named: "cardSquare")!
        let star = UIImage(named: "cardStar")!
        
        // create an array of the images, one for each card, then shuffle it
        var images = [circle, circle, cross, cross, lines, lines, square, star]
        images = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: images) as! [UIImage]
        
        for (index, position) in positions.enumerated() {
            // loop over each card position and create a new card view controller
            let card = CardViewController()
            card.delegate = self
            
            // use view controller containment and also add the card's view to our cardContainer view
            addChildViewController(card)
            cardContainer.addSubview(card.view)
            card.didMove(toParentViewController: self)
            
            // position the card appropriately, then give it an image from our array
            card.view.center = position
            card.front.image = images[index]
            
            // if we just gave the card the star image, mark this as the correct answer
            if card.front.image == star {
                card.isCorrect = true
            }
            
            // add the new card view controller to our array for easier tracking
            allCards.append(card)
        }
        
    }

}

