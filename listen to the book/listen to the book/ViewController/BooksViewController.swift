//
//  BooksViewController.swift
//  listen to the book
//
//  Created by Magic Keegan on 4/16/22.
//

import UIKit
import Lottie

class BooksViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var readingProgeress: UIProgressView!
    @IBOutlet var readingLable: UILabel!
    @IBOutlet var lottieView: AnimationView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置动画视图
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .loop
        lottieView.animationSpeed = 0.5
        lottieView.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //获取当前读书及进度
        let book = Book.currentReadingBook
        readingProgeress.progress = book.rate
        readingProgeress.accessibilityLabel = "The book reading rate"
        readingProgeress.accessibilityValue = "\(book.rate * 100) percent"
        readingLable.text = "The book reading now is \(book.name)\n has read \(book.page) pages"
    }
    
    

}

extension BooksViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Book.shared.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as! BookCell
        //设置书名信息和书名标签约束
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: cell.contentView.bounds.size.width, height: 50))
        title.lineBreakMode = .byCharWrapping
        title.font = .preferredFont(forTextStyle: .title2)
        title.numberOfLines = 0
        title.text = Book.shared[indexPath.row].name
        title.textColor = .white
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        title.adjustsFontForContentSizeCategory = true
        //设置圆角矩形
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.blue.cgColor
        cell.contentView.backgroundColor = .systemBlue
        cell.contentView.layer.masksToBounds = true
        
        //为title设置描述
        cell.book = Book.shared[indexPath.row]
        
        //添加视图
        cell.contentView.addSubview(title)
        //设置约束
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor,constant: 0),
            title.centerXAnchor.constraint(equalTo: cell.centerXAnchor)
        ])
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "PDFSegue":
            if let cell = sender as? UICollectionViewCell,let indexPath = self.collectionView.indexPath(for: cell){
                let row = indexPath.row
                let book = Book.shared[row]
                Book.currentReadingBook = book
                let PDFVC = segue.destination as! PDFViewController
                PDFVC.configure(book: book)
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "PDFSegue", sender: indexPath)
        
    }
}
