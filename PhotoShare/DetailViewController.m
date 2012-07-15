//
//  DetailViewController.m
//  Click Cloud
//
//  Created by Carlos Duran on 7/3/12.
//  Copyright (c) 2012 Mobiliture. All rights reserved.
//

#import "DetailViewController.h"
#import "PTKDocument.h"
#import "PTKData.h"
#import "UIImageExtras.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController {
    UIImagePickerController * _picker;
}
@synthesize doc = _doc;
@synthesize imageView = _imageView;
@synthesize delegate = _delegate;

@synthesize contentView = _contentView;
@synthesize adBannerView = _adBannerView;
@synthesize adBannerViewIsVisible = _adBannerViewIsVisible;

#pragma mark - iAd functions
-(int)getBannerHeight:(UIDeviceOrientation)orientation {
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        return 32;
    } else {
        return 50;
    }
}
-(int)getBannerHeight {
    return [self getBannerHeight:[UIDevice currentDevice].orientation];
}
-(void)createAdBannerView {
    Class classAdBannerView = NSClassFromString(@"ADBannerView");
    if (classAdBannerView != nil) {
        self.adBannerView = [[classAdBannerView alloc] initWithFrame:CGRectZero];
        [_adBannerView setRequiredContentSizeIdentifiers:[NSSet setWithObjects:
                                                          ADBannerContentSizeIdentifierPortrait,
                                                          ADBannerContentSizeIdentifierLandscape,
                                                          nil]];
        if (UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
            [_adBannerView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierLandscape];
        } else {
            [_adBannerView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierPortrait];
        }
        [_adBannerView setFrame:CGRectOffset([_adBannerView frame], 0, -[self getBannerHeight])];
        [_adBannerView setDelegate:self];
        [self.view addSubview:_adBannerView];
    }
}
-(void)fixupAdView:(UIInterfaceOrientation)toInterfaceOrientation {
    if (_adBannerView != nil) {
        if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
            [_adBannerView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierLandscape];
        } else {
            [_adBannerView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierPortrait];
        }
        [UIView beginAnimations:@"fixupViews" context:nil];
        if (_adBannerViewIsVisible) {
            // *** Ad frame at top
            
//            CGRect adBannerViewFrame = [_adBannerView frame];
//            adBannerViewFrame.origin.x = 0;
//            adBannerViewFrame.origin.y = 0;
//            [_adBannerView setFrame:adBannerViewFrame];
//            CGRect contentViewFrame = _contentView.frame;
//            contentViewFrame.origin.y = [self getBannerHeight:toInterfaceOrientation];
//            contentViewFrame.size.height = self.view.frame.size.height -
//            [self getBannerHeight:toInterfaceOrientation];
//            _contentView.frame = contentViewFrame;

//            CGRect adBannerViewFrame = [_adBannerView frame];
//            adBannerViewFrame.origin.x = 0;
//            adBannerViewFrame.origin.y = 0;
//            [_adBannerView setFrame:adBannerViewFrame];

            // *** Ad frame at bottom
            CGRect contentViewFrame = _contentView.frame;
            contentViewFrame.size.height = self.view.frame.size.height -
            [self getBannerHeight:toInterfaceOrientation];
            _contentView.frame = contentViewFrame;
            CGRect adBannerViewFrame = [_adBannerView frame];
            adBannerViewFrame.origin.x = 0;
            adBannerViewFrame.origin.y = (_contentView.frame.size.height + 1.0);
            [_adBannerView setFrame:adBannerViewFrame];
        } else {
            CGRect adBannerViewFrame = [_adBannerView frame];
            adBannerViewFrame.origin.x = 0;
            adBannerViewFrame.origin.y = 
            - [self getBannerHeight:toInterfaceOrientation];
            [_adBannerView setFrame:adBannerViewFrame];
            CGRect contentViewFrame = _contentView.frame;
            contentViewFrame.origin.y = 0;
            contentViewFrame.size.height = self.view.frame.size.height;
            _contentView.frame = contentViewFrame;
        }
        [UIView commitAnimations];
    }
}

#pragma mark ADBannerViewDelegate

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    if (!_adBannerViewIsVisible) {
        _adBannerViewIsVisible = YES;
        [self fixupAdView:[UIDevice currentDevice].orientation];
    }
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    NSError *err;
    NSLog(@"Error - Failed to receive Ad: %@", [err localizedDescription]);
    
    if (_adBannerViewIsVisible) {
        _adBannerViewIsVisible = NO;
        [self fixupAdView:[UIDevice currentDevice].orientation];
    }
}


#pragma mark - Managing the detai item
-(void)setDoc:(id)newDoc {
    if (_doc != newDoc) {
        _doc = newDoc;
        
        // Update the view
        [self configureView];
    }
}

-(void)configureView
{
    // Update the user interface for the detail item
    self.title = [self.doc description];
    if (self.doc.photo) {
        self.imageView.image = self.doc.photo;
    } else {
        self.imageView.image = [UIImage imageNamed:@"defaultimage.png"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
 
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTapped:)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
    [self.view addGestureRecognizer:tapRecognizer];
    
    [self configureView];
    
    // iAd setup
    [self createAdBannerView];
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
- (void)viewWillAppear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(documentStateChanged:)
                                                 name:UIDocumentStateChangedNotification 
                                               object:self.doc];
    // iAd setup
    [self fixupAdView:[UIDevice currentDevice].orientation];
    
}
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self fixupAdView:[UIDevice currentDevice].orientation];
}
- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)documentStateChanged:(NSNotification *)notificaiton {
    
    [self configureView];
    
}
#pragma mark Callbacks
-(void)imageTapped:(UITapGestureRecognizer*)recognizer {
    if (!_picker) {
        _picker = [[UIImagePickerController alloc] init];
        _picker.delegate = self;
        _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _picker.allowsEditing = NO;
    }
    [self presentModalViewController:_picker animated:YES];
}
-(void)doneTapped:(id)sender {
    NSLog(@"Closing %@...:",self.doc.fileURL);
 
    [self.doc saveToURL:self.doc.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
        [self.doc closeWithCompletionHandler:^(BOOL success) {
            dispatch_async(dispatch_get_main_queue(), ^{                        
                if (!success) {
                    NSLog(@"Failed to close %@", self.doc.fileURL);
                    // Continue anyway...
                }
                
                [self.delegate detailViewControllerDidClose:self];
            });
        }];
    }];
    
    
}

#pragma mark UIImagePickeerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {    
    
    UIImage *image = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CGSize mainSize = self.imageView.bounds.size;
    UIImage *sImage = [image imageByBestFitForSize:mainSize]; //[image scaleToFitSize:mainSize];
    
    self.doc.photo = sImage;
    self.imageView.image = sImage;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
