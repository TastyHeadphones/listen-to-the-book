//
//  BooksViewController.swift
//  listen to the book
//
//  Created by Magic Keegan on 4/16/22.
//

import UIKit

class BooksViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var readingProgeress: UIProgressView!
    @IBOutlet var readingLable: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let book = Book.currentReadingBook
        readingProgeress.progress = book.rate
        readingLable.text = "当前正在阅读 \(book.name)"
    }
    
    

}

extension BooksViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Book.shared.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath)
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: 15))
        title.text = Book.shared[indexPath.row].name
        title.textColor = .white
        title.textAlignment = .center
        
        //增加圆角矩形
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.blue.cgColor
        cell.contentView.backgroundColor = .systemBlue
        cell.contentView.layer.masksToBounds = true
        title.translatesAutoresizingMaskIntoConstraints = false
        
        cell.contentView.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor,constant: -5),
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
