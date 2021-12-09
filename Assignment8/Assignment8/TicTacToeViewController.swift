//
//  TicTacToeViewController.swift
//  Assignment8
//
//  Created by DCS on 06/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class TicTacToeViewController: UIViewController {
    
    var xpoint :  Int = 0;
    var opoint :  Int = 0;
    
    private var state=[2,2,2,2,
                       2,2,2,2,
                       2,2,2,2,
                       2,2,2,2]
    
    private let WinningCombinations = [[0,1,2,3] , [4,5,6,7] , [8,9,10,11] , [12,13,14,15] , [0,4,8,12] , [1,5,9,13] , [2,6,10,14] , [3,7,11,15] , [0,5,10,15] , [3,6,9,12]]
    
    private var zeroFlag = false
    
    private let XLabel : UILabel = {
        let label = UILabel()
        label.text = "Player X Points : "
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.font = UIFont(name: "HoeflerText-BlackItalic", size: 25)
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    
    private let OLabel : UILabel = {
        let label = UILabel()
        label.text = "Player O Points : "
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.font = UIFont(name: "HoeflerText-BlackItalic", size: 25)
        label.textAlignment = .center
        label.backgroundColor =  .clear
        return label
    }()
    
    private let XPointLabel : UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .red
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.font = UIFont(name: "HoeflerText-BlackItalic", size: 25)
        label.textAlignment = .center
        label.backgroundColor =  .clear
        return label
    }()
    
    private let OPointLabel : UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .blue
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.font = UIFont(name: "HoeflerText-BlackItalic", size: 25)
        label.textAlignment = .center
        label.backgroundColor =  .clear
        return label
    }()
    
    private let TurnLabel : UILabel = {
        let label = UILabel()
        label.text="Player X Turn"
        label.textColor = .red
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.font = UIFont(name: "HoeflerText-BlackItalic", size: 25)
        label.textAlignment = .center
        label.backgroundColor =  .clear
        return label
    }()
    
    private let TitleLabel : UILabel = {
        let label = UILabel()
        label.text="TIC TAC TOE GAME"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.font = UIFont(name: "HoeflerText-Black", size: 30)
        label.textAlignment = .center
        label.backgroundColor =  .clear
        return label
    }()
    
    private let myCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: 70, height: 70)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
       
        view.addSubview(XLabel)
        view.addSubview(OLabel)
        view.addSubview(XPointLabel)
        view.addSubview(OPointLabel)
        view.addSubview(myCollectionView)
        view.addSubview(TurnLabel)
        view.addSubview(TitleLabel)
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        XLabel.frame = CGRect(x: 20, y: 50, width: 200, height: 50)
        XPointLabel.frame = CGRect(x: 200, y: 50, width: 150, height: 50)
        OLabel.frame = CGRect(x: 20, y: 105, width: 200, height: 50)
        OPointLabel.frame = CGRect(x: 200, y: 105, width: 150, height: 50)
        myCollectionView.frame = CGRect(x: 0, y: 170, width: view.frame.size.width, height: 500)
        TurnLabel.frame = CGRect(x: 10, y: 500, width: view.frame.size.width, height: 50)
        TitleLabel.frame = CGRect(x: 10, y: 560, width: view.frame.size.width, height: 50)
    }
    
}

extension TicTacToeViewController : UICollectionViewDataSource , UICollectionViewDelegate {
    
    private func setupCollectionView()
    {
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(TicTacToeCollectionViewCell.self, forCellWithReuseIdentifier: "TicTacToeCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicTacToeCollectionViewCell", for: indexPath) as! TicTacToeCollectionViewCell
        
        cell.setupCell(with: state[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("helloo")
        
        if state[indexPath.row] != 0 && state[indexPath.row] != 1 {
            state.remove(at: indexPath.row)
            
            if zeroFlag {
                state.insert(0, at: indexPath.row)
                TurnLabel.text="Player X Turn"
                TurnLabel.textColor = UIColor.red
            }else{
                state.insert(1, at: indexPath.row)
                 TurnLabel.text="Player O Turn"
                 TurnLabel.textColor = UIColor.blue
            }
            zeroFlag = !zeroFlag
            collectionView.reloadSections(IndexSet(integer:0))
            checkWinner()
        }
    }
    
    private func checkWinner()
    {
        if !state.contains(2)
        {
            print("Draw")
            let alert = UIAlertController(title: title, message: "Opps !!! No one Won", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: .cancel))
            DispatchQueue.main.async {
                self.present(alert,animated: true)
            }
            resetState()
        }
        else
        {
            for i in WinningCombinations
            {
                if state[ i[0] ] == state[ i[1] ] && state[ i[1] ] == state[ i[2] ] && state[ i[2] ] == state[ i[3] ]  && state[ i[0] ] != 2
                {
                    print("\(state [ i[0] ]) won")
                    if(state [ i[0] ] == 0)
                    {
                        opoint = opoint + 1;
                        
                        let alert = UIAlertController(title: title, message: "Congratulation !!! Player O Won", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Play Again", style: .cancel))
                        DispatchQueue.main.async {
                            self.present(alert,animated: true)
                            }
                       
                        OPointLabel.text = "\(opoint)"
                    }
                    else
                    {
                        
                        xpoint = xpoint + 1;
                        let alert = UIAlertController(title: title, message: "Congratulation !!! Player X Won", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Play Again", style: .cancel))
                        DispatchQueue.main.async {
                            self.present(alert,animated: true)
                        }
                        XPointLabel.text = "\(xpoint)"
                    }
                
                    resetState()
                    break
                }
            }
        }
    }
    private func resetState(){
        state = [2,2,2,2,
                 2,2,2,2,
                 2,2,2,2,
                 2,2,2,2]
        zeroFlag = false
        myCollectionView.reloadSections(IndexSet(integer: 0))
    }
}
