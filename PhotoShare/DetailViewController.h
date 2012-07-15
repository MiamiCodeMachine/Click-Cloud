//
//  DetailViewController.h
//  Click Cloud
//
//  Created by Carlos Duran on 7/3/12.
//  Copyright (c) 2012 Mobiliture. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iAd/AdBannerView.h"

@class PTKDocument;
@class DetailViewController;

@protocol DetailViewControllerDelegate
-(void)detailViewControllerDidClose:(DetailViewController *)detailViewController;
@end

@interface DetailViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, ADBannerViewDelegate>

@property (strong, nonatomic)PTKDocument *doc;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak)id<DetailViewControllerDelegate>delegate;

@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) id adBannerView;
@property (nonatomic) BOOL adBannerViewIsVisible;

@end
