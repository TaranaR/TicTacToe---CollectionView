//
//  T3Cell.swift
//  TicTacToe
//
//  Created by DCS on 08/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class T3Cell: UICollectionViewCell {

    private let myImageView:UIImageView={
        let imageView=UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func setupCell(with status:Int){
        contentView.layer.borderWidth=2
        contentView.layer.borderColor=UIColor.white.cgColor
        contentView.addSubview(myImageView)
        
        myImageView.frame=CGRect(x: 5, y: 5, width: 50, height: 50)
        
        let name=(status == 0) ? ("circle") : (status == 1 ? "multiply" : "")
        
        myImageView.image=UIImage(named: name)
    }
}
