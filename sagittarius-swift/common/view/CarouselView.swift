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
    var imageUrls : [AnyObject]!
    var count : Int!
    var timeInterval : NSTimeInterval!
    var currentPageIndicatorColor : UIColor!
    var pageIndicatorColor : UIColor!
    var placeHolderImage: String!
    var timer: NSTimer!
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    
    convenience init(frame: CGRect, delegate: CarouselViewDelegate, placeHolderImage: String, timeInterval: NSTimeInterval,  currentPageIndicatorColor: UIColor, pageIndicatorColor: UIColor) {
        self.init(frame: frame)
        
        self.delegate = delegate
        self.placeHolderImage = placeHolderImage
        self.timeInterval = timeInterval
        self.currentPageIndicatorColor = currentPageIndicatorColor
        self.pageIndicatorColor = pageIndicatorColor
        self.setupMainView()
    }
    
    func reLayout() {
        let scrollW = self.frame.size.width
        let scrollH = self.frame.size.height
        if self.count > 0 {
            for var i = 0; i<self.count; i++ {
                let imageView = UIImageView(frame: CGRect(x: scrollW * CGFloat(i) + scrollW, y: 0, width: scrollW, height: scrollH))
                imageView.clipsToBounds = true;
                imageView.userInteractionEnabled = true
                imageView.contentMode = .ScaleAspectFill
                
                if let item = self.imageUrls[i] as? Dictionary<String, AnyObject> {
                    imageView.loadWithUrl((item["viewImageUrl"] as? String)!, placeHolder: self.placeHolderImage)
                }
                let tap = UITapGestureRecognizer(target: self, action: "imageViewTaped:")
                imageView.addGestureRecognizer(tap)
                scrollView.addSubview(imageView)
            }
        }
        
        if self.count > 0 {
            self.addTimer()
            pageControl.numberOfPages = self.count
            self.scrollView.scrollRectToVisible(CGRect(x: scrollW, y: 0, width: scrollW, height: scrollH), animated: false)
            self.scrollView.contentSize = CGSize(width: CGFloat(self.count + 2) * scrollW, height: scrollH)
        }
    }
    
    func setImages(images: [AnyObject]) {
        self.imageUrls = images
        self.count = images.count
        reLayout()
    }
    
    func setupMainView() {
        let scrollW = self.frame.size.width
        let scrollH = self.frame.size.height
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: scrollW, height: scrollH))
        
        scrollView.scrollsToTop = false;
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        scrollView.pagingEnabled = true
        self.addSubview(scrollView)
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: scrollH - 10 - 10, width: scrollW, height: 10))
        pageControl.userInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = self.currentPageIndicatorColor
        pageControl.pageIndicatorTintColor = self.pageIndicatorColor
        self.addSubview(pageControl)
        scrollView.delegate = self
    }
    
    func addTimer() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(self.timeInterval, target: self, selector: "nextImage", userInfo: nil, repeats: true);
        NSRunLoop.currentRunLoop().addTimer(self.timer, forMode: "NSRunLoopCommonModes")
    }

    func removeTimer () {
        if self.timer.valid {
            self.timer.invalidate()
            self.timer = nil
        }
    }
    
    func nextImage() {
        
        let currentPage = self.pageControl.currentPage
        let scrollW = self.frame.size.width
        let point = CGPointMake(CGFloat(currentPage + 2) * scrollW, 0)
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
