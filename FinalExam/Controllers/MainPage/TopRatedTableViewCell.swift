//
//  TopRatedTableViewCell.swift
//  FinalExam
//
//  Created by Акбала Тлеугалиева on 5/22/22.
//  Copyright © 2022 Akbala Tleugaliyeva. All rights reserved.
//

import UIKit
import SDWebImage
class TopAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)?
            .map { $0.copy() } as? [UICollectionViewLayoutAttributes]

        attributes?
            .reduce([CGFloat: (CGFloat, [UICollectionViewLayoutAttributes])]()) {
                guard $1.representedElementCategory == .cell else { return $0 }
                return $0.merging([ceil($1.center.y): ($1.frame.origin.y, [$1])]) {
                    ($0.0 < $1.0 ? $0.0 : $1.0, $0.1 + $1.1)
                }
            }
            .values.forEach { minY, line in
                line.forEach {
                    $0.frame = $0.frame.offsetBy(
                        dx: 0,
                        dy: minY - $0.frame.origin.y
                    )
                }
            }

        return attributes
    }
}

class TopRatedTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categoryLabel: UILabel!
    var mainMovie = MainMovies()
     override func awakeFromNib() {
               super.awakeFromNib()
               // Initialization code
               
               collectionView.delegate = self
               collectionView.dataSource = self
               
               let layout = TopAlignedCollectionViewFlowLayout()
               layout.sectionInset = UIEdgeInsets(top: 22.0, left: 24.0, bottom: 10.0, right: 24.0)
               layout.minimumInteritemSpacing = 16
               layout.minimumLineSpacing = 16
               layout.estimatedItemSize.width = 300
               layout.estimatedItemSize.height = 300
               layout.scrollDirection = .horizontal
               collectionView.collectionViewLayout = layout
           }

           override func setSelected(_ selected: Bool, animated: Bool) {
               super.setSelected(selected, animated: animated)

               // Configure the view for the selected state
           }
           
           func setData(mainMovie: MainMovies) {
           
               self.mainMovie = mainMovie
               
               collectionView.reloadData()
           }
       
       func convertDataFormatter(_ date: String?) -> String {
           var fixDate = ""
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd"
           if let originalDate = date {
               if let newDate = dateFormatter.date(from: originalDate){
                   dateFormatter.dateFormat = "d MMM, yyyy"
                   fixDate = dateFormatter.string(from: newDate)
               }
           }
           return fixDate

       }
           
           // MARK: - collectionView
           func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
               return mainMovie.movies.count
           }

           func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
               
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath)
                          
                          //imageview
               let transformer = SDImageResizingTransformer(size: CGSize(width: 190, height: 160), scaleMode: .aspectFill)
                          
               let imageview = cell.viewWithTag(1000) as! UIImageView
               imageview.sd_setImage(with: URL(string: mainMovie.movies[indexPath.row].posterImage), placeholderImage: nil, context: [.imageTransformer: transformer])
               imageview.layer.cornerRadius = 8
               let filmName = cell.viewWithTag(1001) as! UILabel
               filmName.text = mainMovie.movies[indexPath.row].title
               let releaseDate = cell.viewWithTag(1002) as! UILabel
               releaseDate.text = convertDataFormatter(mainMovie.movies[indexPath.row].release_date)
               let rating = cell.viewWithTag(1003) as! UILabel
               rating.text = "\(mainMovie.movies[indexPath.row].vote_average)"
                          return cell
           }
           
           func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
               collectionView.deselectItem(at: indexPath, animated: true)
           }

       }
