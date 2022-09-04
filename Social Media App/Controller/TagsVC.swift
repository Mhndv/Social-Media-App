//
//  TagsVC.swift
//  Social Media App
//
//  Created by Mohanned Alsahaf on 04/02/1444 AH.
//

import UIKit
import NVActivityIndicatorView
class TagsVC: UIViewController {
    var tags:[String] = [
   
     ]
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var TagsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        TagsCollectionView.delegate = self
        TagsCollectionView.dataSource = self
        loaderView.startAnimating()
        PostAPI.GetAllTags { tags in
            self.tags = tags
            self.TagsCollectionView.reloadData()
            self.loaderView.stopAnimating()
        }
        
    }

}


extension TagsVC:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagsCell", for: indexPath) as! TagsCell
        
        let currentTag = tags[indexPath.row]
        cell.tagNameLabel.text = currentTag
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedtag = tags[indexPath.row]//get the exact tag
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PostVC") as? PostVC{
            vc.tag = selectedtag // putting the selected tag 
            self.present(vc, animated: true)
        }
    }
    
    
}
