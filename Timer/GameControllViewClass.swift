//
//  GameControllViewClass.swift
//  Timer
//
//  Created by Sergey Koriukin on 01/07/2019.
//  Copyright © 2019 Sergey Koriukin. All rights reserved.
//

import UIKit


@IBDesignable

class GameControllerViewClass: UIView  {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        let xibView = loadViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(xibView)
    }
    
    private func loadViewFromXib() -> UIView
        {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "GameControllerView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
    }
    
}
