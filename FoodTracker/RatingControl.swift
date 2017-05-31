//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Jacqueline on 30.05.17.
//  Copyright © 2017 Jacky's Code Factory. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //properties
    private var ratingButtons = [UIButton]()  // property, that contains buttons
    var rating = 0 {
        didSet{
            updateButtonSelectionStates()
        }
    }

    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0){
        didSet{
            setupButtons()
        }
    }
    
    @IBInspectable var starCount: Int = 5{
        didSet{
            setupButtons()
        }
    }
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder:NSCoder){
        super.init(coder: coder)
        setupButtons()
    }
    
    func ratingButtonTapped(button: UIButton){
        guard let index = ratingButtons.index(of: button) else{
            fatalError("The button, \(button), is not in the ratingButtons array:\(ratingButtons)")
        }
        
        let selectedRating = index + 1
        
        if selectedRating == rating {
            //if the selected star represenets the current rating, reset the rating to 0.
            rating = 0
        }else{
            //otherwise set the rating to the selected star
            rating = selectedRating
        }
    }
    
    
    //MARK: Private Methods
    
    private func setupButtons(){
        
        //clear any existing buttons
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        //Load Button Images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named:"filledStar", in: bundle, compatibleWith:self.traitCollection)
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith:self.traitCollection)
        let highlightedStar = UIImage(named:"highlighteadStar", in: bundle, compatibleWith:self.traitCollection)
        
        for index in 0..<starCount {
        
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])

            //add constraints
            button.translatesAutoresizingMaskIntoConstraints = false //disables the button's automatically generated contraints
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            //set the accesibility label
            button.accessibilityLabel = "Set \(index+1) star rating"
            
            //setup the button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            //add button to stack
            addArrangedSubview(button)
            
            //add the new button to the rating button array
            ratingButtons.append(button)
        }
        
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates(){
        for (index, button) in ratingButtons.enumerated() {
            //if the index of a button is less than the rating, that button should be selected
            button.isSelected = index < rating
            let hintString: String?
            if rating == index + 1{
                hintString = "Tap to reset the rating to zero."
            }else{
                hintString = nil
            }
            //calculate the calue string
            let valueString:String
            switch (rating){
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set"
            default:
                valueString = "\(rating) stars set."
            }
            //assign the hint string and value string
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
    
    
    
    
    
    
    
    
    
}


