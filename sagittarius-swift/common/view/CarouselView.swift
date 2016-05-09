//
//  CarouselView.swift
//  sagittarius-swift
//
//  Created by bonedeng on 5/7/16.
//  Copyright © 2016 xingdongyou. All rights reserved.
//

import UIKit

protocol CarouselViewDelegate {
    func didClickedImageAtIndex(index: Int)
}

class CarouselView: UIView, UIScrollViewDelegate{

    var delegate : CarouselViewDelegate?
    var imageUrls : [String]!
    var count : Int!
    var timeInterval : NSTimeInterval!
    var currentPageIndicatorColor : UIColor!
    var pageIndicatorColor : UIColor!
    var placeHolderImage: String!
    var timer: NSTimer!
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    
    convenience init(frame: CGRect, delegate: CarouselViewDelegate, imageUrls: [String],  placeHolderImage: String, timeInterval: NSTimeInterval,  currentPageIndicatorColor: UIColor, pageIndicatorColor: UIColor) {
        self.init(frame: frame)
        
        self.delegate = delegate
        self.imageUrls = imageUrls
        self.placeHolderImage = placeHolderImage
        self.count = self.imageUrls.count
        self.timeInterval = timeInterval
        self.currentPageIndicatorColor = currentPageIndicatorColor
        self.pageIndicatorColor = pageIndicatorColor
        self.setupMainView()
    }
    
    func setupMainView() {
        let scrollW = self.frame.size.width
        let scrollH = self.frame.size.height
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: scrollW, height: scrollH))
        if self.count > 0 {
            for var i = 0; i<self.count; i++ {
                let imageView = UIImageView(frame: CGRect(x: scrollW * CGFloat(i), y: 0, width: scrollW, height: scrollH))
                imageView.clipsToBounds = true;
                imageView.userInteractionEnabled = true
                imageView.contentMode = .ScaleAspectFill
                imageView.tag = i
                
                print("i is \(i)")
                imageView.image = UIImage(named: self.imageUrls[i])
                let tap = UITapGestureRecognizer(target: self, action: "imageViewTaped:")
                imageView.addGestureRecognizer(tap)
                scrollView.addSubview(imageView)
            }
        }
        
        scrollView.scrollsToTop = false;
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentOffset = CGPoint(x: scrollW, y: 0)
        scrollView.pagingEnabled = true
        scrollView.contentSize = CGSize(width: CGFloat(self.count + 2) * scrollW, height: 0)
        self.addSubview(scrollView)
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: scrollH - 10 - 10, width: scrollW, height: 10))
        pageControl.numberOfPages = self.count
        pageControl.userInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = self.currentPageIndicatorColor
        pageControl.pageIndicatorTintColor = self.pageIndicatorColor
        self.addSubview(pageControl)
        scrollView.delegate = self
        print("init over")
        
        if self.count > 0 {
            self.addTimer()
        }
        
    }
    
    func addTimer() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(self.timeInterval, target: self, selector: "nextImage", userInfo: nil, repeats: true);
        NSRunLoop.currentRunLoop().addTimer(self.timer, forMode: "NSRunLoopCommonModes")
    }

    func removeTimer () {
        if self.timer.valid {
            self.timer.invalidate()
        }
    }
    
    func nextImage() {
        
        let currentPage = self.pageControl.currentPage
        let scrollW = self.frame.size.width
        let point = CGPointMake(CGFloat(currentPage + 1) * scrollW, 0)
        self.scrollView.setContentOffset(point, animated: true)
        
    }
    
    func imageViewTaped(tap: UITapGestureRecognizer) {
        self.delegate?.didClickedImageAtIndex(tap.view!.tag)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let scrollW = self.scrollView.frame.size.width
        let currentPage = Int(self.scrollView.contentOffset.x / scrollW)
        if currentPage == self.count+1 {
            self.pageControl.currentPage = 0
        } else if currentPage == 0 {
            self.pageControl.currentPage = self.count
        } else {
            self.pageControl.currentPage = currentPage - 1
        }
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        self.scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let scrollW = self.scrollView.frame.size.width
        let currentPage = Int(self.scrollView.contentOffset.x / scrollW)
        if currentPage == self.count+1 {
            self.pageControl.currentPage = 0
            self.scrollView.setContentOffset(CGPoint(x: scrollW, y: 0), animated: false)
        } else if currentPage == 0 {
            self.pageControl.currentPage = self.count
            let point = CGPoint(x: CGFloat(self.count) * scrollW, y: 0)
            self.scrollView.setContentOffset(point, animated: false)
        } else {
            self.pageControl.currentPage = currentPage-1
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.removeTimer()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.addTimer()
    }

}
