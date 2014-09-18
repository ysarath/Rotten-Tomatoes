//
//  MovieCell.h
//  Rotten Tomatoes
//
//  Created by Sarath Yalamanchili on 9/14/14.
//  Copyright (c) 2014 Sarath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@property (weak, nonatomic) IBOutlet UIImageView *posterView;

@end
