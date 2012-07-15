//
//  PTKEntryCell.h
//  Click Cloud
//
//  Created by Carlos Duran on 7/5/12.
//  Copyright (c) 2012 Mobiliture. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTKEntryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *warningImageView;

@end
