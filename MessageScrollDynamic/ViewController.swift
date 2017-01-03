//
//  ViewController.swift
//  MessageScrollDynamic
//
//  Created by ZhuJiang on 17/1/2.
//  Copyright © 2017年 Charles. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionDynamic: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let flowLayout = self.collectionDynamic.collectionViewLayout as? DynamicCollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: self.view.frame.size.width, height: 50)
            flowLayout.minimumLineSpacing = 28
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    ///MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 33
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecBlockCollectionViewCell.CellIdentifier(), for: indexPath)
        var color: UIColor?
        if indexPath.row % 2 == 0 {
            color = UIColor.red
        } else if indexPath.row % 3 == 0 {
            color = UIColor.green
        }
        else {
            color = UIColor.blue
        }
        
        cell.contentView.backgroundColor = color
        return cell
    }
}

