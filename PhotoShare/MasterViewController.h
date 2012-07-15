//
//  MasterViewController.h
//  Click Cloud
//
//  Created by Carlos Duran on 7/3/12.
//  Copyright (c) 2012 Mobiliture. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTKEntryCell.h"
#import "DetailViewController.h"
#import "AdWhirlView.h"
#import "AdWhirlDelegateProtocol.h"

@interface MasterViewController : UITableViewController <UITextFieldDelegate, 
                                        DetailViewControllerDelegate,
                                        AdWhirlDelegate>


@property (nonatomic, strong) AdWhirlView *adWhirlView;

@end
