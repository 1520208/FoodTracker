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
    var rating = 0
    
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
    
        print("Button pressed")
    }
    
    
    //MARK: Private Methods
    
    private func setupButtons(){
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        for _ in 0..<starCount {
        
            let button = UIButton()
            button.backgroundColor = UIColor.red
            //add constraints
            button.translatesAutoresizingMaskIntoConstraints = false //disables the button's automatically generated contraints
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            //setup the button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            //add button to stack
            addArrangedSubview(button)
            
            //add the new button to the rating button array
            ratingButtons.append(button)
        }
    }
}


