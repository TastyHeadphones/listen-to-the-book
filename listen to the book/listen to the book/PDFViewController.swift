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
    private var thumbnailView = PDFThumbnailView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    private var pdfView = PDFView()
    
    private var isReading:Bool = false
    private let synthesizer = AVSpeechSynthesizer()
    
    func configure(book:Book){
        self.pdfUrl = book.url
        self.document = PDFDocument(url: pdfUrl)
        self.outline = document.outlineRoot
        pdfView.document = document
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thumbnailView.pdfView = pdfView
        thumbnailView.layoutMode = .horizontal
        thumbnailView.thumbnailSize = CGSize(width: 20, height: 20)
        view.insertSubview(thumbnailView, at: 0)
        pdfView.displayDirection = .horizontal
        pdfView.usePageViewController(true)
        pdfView.pageBreakMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        pdfView.autoScales = true
    }
    
    
    
    @IBAction func startReading(_ sender:UIButton){
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
    
    @IBAction func stopReading(){
        
    }
    
}


