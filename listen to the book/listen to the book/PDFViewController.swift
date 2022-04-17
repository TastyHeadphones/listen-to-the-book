//
//  PDFViewController.swift
//  listen to the book
//
//  Created by Magic Keegan on 4/16/22.
//

import UIKit
import PDFKit
import AVFoundation


class PDFViewController: UIViewController {
    
    private var pdfUrl: URL!
    private var document: PDFDocument!
    private var outline: PDFOutline?
    private var pdfView = PDFView()
    private var book:Book!
    
    private var isReading:Bool = false
    private let synthesizer = AVSpeechSynthesizer()
    
    func configure(book:Book){
        self.book = book
        self.pdfUrl = book.url
        self.document = PDFDocument(url: pdfUrl)
        self.outline = document.outlineRoot
        pdfView.document = document
        
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            pdfView.frame = view.safeAreaLayoutGuide.layoutFrame
        }
    
    override func viewWillAppear(_ animated: Bool) {
        //前往保存的页数
        guard let targetPage = document.page(at: book.page) else { return }

        pdfView.go(to: targetPage)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //保存当前读到的页数
        let curPage = pdfView.currentPage?.pageRef?.pageNumber
        let sumPages = document.documentRef?.numberOfPages
        book.page = curPage!
        book.rate = Float(curPage!) / Float(sumPages!)
    }
    
    private func setupPDFView() {
        view.insertSubview(pdfView, at: 0)
            pdfView.displayDirection = .horizontal
            pdfView.usePageViewController(true)
            pdfView.pageBreakMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            pdfView.autoScales = true
        }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPDFView()
    }
    
    
    
    
    
    @IBAction func readingButtonTapped(_ sender:UIButton){
        isReading.toggle()
        if(isReading){
            sender.setImage(UIImage(systemName: "pause"), for: .normal)
            let utterance = AVSpeechUtterance(string: "目录 序 第一部 卷一 第一章 第一部 卷一 第二章 第一部 卷一 第三章 第一部 卷一 第四章 第一部 卷一 第五章 第一部 卷一 第六章 第一部 卷一 第七章")
            utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
            utterance.rate = 0.4
            synthesizer.speak(utterance)
        }
        else{
            sender.setImage(UIImage(systemName: "play"), for: .normal)
            synthesizer.stopSpeaking(at: .immediate)
        }
        
        
    }
    
}




