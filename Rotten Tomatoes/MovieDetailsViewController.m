//
//  MovieDetailsViewController.m
//  Rotten Tomatoes
//
//  Created by Sarath Yalamanchili on 9/15/14.
//  Copyright (c) 2014 Sarath. All rights reserved.
//

#import "MovieDetailsViewController.h"

@interface MovieDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieSynopsis;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation MovieDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
   [super viewDidLoad];
    NSLog(@"Inside MovieDetailsViewController");
    NSLog(@"Synopsis: %@",self.detsynopsis);
    NSLog(@"ImageUrl: %@", self.movieUrl);
    
    self.movieTitle.text =  self.title;
    self.movieSynopsis.text = self.detsynopsis;
    
    NSString *thumbUrl = self.movieUrl;
    NSString *ImageURL =  [ thumbUrl stringByReplacingOccurrencesOfString:@"tmb" withString:@"org"];
    
    [self.movieImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]]]];
    self.movieImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView setScrollEnabled:YES];
  /*
    UIScrollView *scrollView;
    UIImageView *imageView;
    UIView    * uiView;
    
    scrollView = [[UIScrollView alloc]init];
    uiView   = [[UIView alloc] init];
    imageView = [[UIImageView alloc]init];
    
    UILabel *pointsCheckInLbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 165.0, 320.0, 500.0)];
    pointsCheckInLbl.font = [UIFont boldSystemFontOfSize:14.0];
    pointsCheckInLbl.textAlignment = UITextAlignmentCenter;
    pointsCheckInLbl.textColor = [UIColor blackColor];
    pointsCheckInLbl.backgroundColor = [UIColor clearColor];
    pointsCheckInLbl.numberOfLines = 0;
    //    [pointsCheckInLbl sizeToFit];
    pointsCheckInLbl.text = self.detsynopsis;//synLabel;//@"Points Earned For Check-In";
    [ uiView  addSubview: pointsCheckInLbl];
    
    NSString *thumbUrl = self.movieUrl;
    NSString *ImageURL =  [ thumbUrl stringByReplacingOccurrencesOfString:@"tmb" withString:@"org"];

    [movieImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]]]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:scrollView];
    [scrollView addSubview: uiView];
    //[self.view addSubview:imageView];


    self.movieDetailImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]]];
    self.movieDetailImage.contentMode = UIViewContentModeScaleAspectFit;
    scrollView.translatesAutoresizingMaskIntoConstraints  = NO;
   /* self.synopsisDetail.text = self.detsynopsis;
    [scrollView addSubview:self.movieDetailImage];
    scrollView.translatesAutoresizingMaskIntoConstraints  = NO;
    self.movieDetailImage.translatesAutoresizingMaskIntoConstraints = NO;
*/
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
