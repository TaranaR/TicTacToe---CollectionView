//
//  ViewController.swift
//  TicTacToe
//
//  Created by DCS on 07/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var state = [2,2,2,2,
                         2,2,2,2,
                         2,2,2,2,
                         2,2,2,2]
    
    private let winningCombinations = [[0, 1, 2, 3], [4, 5, 6, 7], [8, 9, 10, 11], [12, 13, 14, 15], [0, 4, 8, 12], [1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15],[0, 5, 10, 15],[3, 6, 9, 12]]
    
    private var zeroFlag = false
    
    private let myCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 200, left: 50, bottom: 20, right: 50)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        //assignbackground()
        return collectionView
    }()
    
    private let MyPlayer1:UILabel={
        let label=UILabel()
        label.text="X Player 1"
        label.textAlignment = .left
        label.font = UIFont(name:"ArialRoundedMTBold", size: 30)
        label.textColor = .white
        return label
    }()
    
    private let MyPlayer2:UILabel={
        let label=UILabel()
        label.text="O Player 2"
        label.textAlignment = .left
        label.font = UIFont(name:"ArialRoundedMTBold", size: 30)
        label.textColor = .white
        return label
    }()
    
    private let Winner:UILabel={
        let label=UILabel()
        label.textAlignment = .left
        label.font = UIFont(name:"ArialRoundedMTBold", size: 25)
        label.textColor = .white
        return label
    }()
    private let bgimg:UIImageView = {
        let bg = UIImageView(image: UIImage(named: "t3bg"))
        bg.contentMode = .scaleAspectFill
        bg.clipsToBounds = true
        return bg
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myCollectionView.backgroundView = bgimg
        view.addSubview(bgimg)
        view.addSubview(myCollectionView)
        setupCollectionView()
        view.addSubview(Winner)
        view.addSubview(MyPlayer1)
        view.addSubview(MyPlayer2)
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //assignbackground()
        myCollectionView.frame=view.bounds
        Winner.frame = CGRect(x: 120, y: 520, width: view.width, height: 30)
        MyPlayer1.frame = CGRect(x: 31, y: 50, width: view.width, height: 40)
        MyPlayer2.frame = CGRect(x: 30, y: MyPlayer1.bottom+10, width: view.width, height: 40)
    }

}

extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    
    private func setupCollectionView(){
        myCollectionView.dataSource=self
        myCollectionView.delegate=self
        myCollectionView.backgroundColor = .yellow
        myCollectionView.register(T3Cell.self, forCellWithReuseIdentifier: "t3Cell")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return state.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "t3Cell", for: indexPath) as! T3Cell
        cell.setupCell(with: state[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if state[indexPath.row] != 0 && state[indexPath.row] != 1{
            state.remove(at: indexPath.row)
            if zeroFlag{
                state.insert(0, at: indexPath.row)
            }else{
                state.insert(1, at: indexPath.row)
            }
            
            zeroFlag = !zeroFlag
            
            
            collectionView.reloadData()
            collectionView.reloadSections(IndexSet(integer: 0))
            checkWinner()
        }
    }
    
    private func checkWinner(){
        if !state.contains(2){
            Winner.text = "Draw"
        }else{
            for i in winningCombinations{
                if state[i[0]] == state[i[1]] && state[i[1]] == state[i[2]] && state[i[2]] == state[i[3]] && state[i[0]] != 2{
                    //resetState()
                    
                    if state[i[0]] == 0{
                      Winner.text="Player 2 won"
                    }else{
                        Winner.text="Player 1 won"
                    }
                    
                    resetState()
                    break
                }
                Winner.text = ""
            }
        }
    }
    private func resetState(){
        state = [2,2,2,2,
                 2,2,2,2,
                 2,2,2,2,
                 2,2,2,2]
        
        zeroFlag=false
        myCollectionView.reloadData()
    }
    
}
