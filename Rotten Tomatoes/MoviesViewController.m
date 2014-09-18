//
//  MoviesViewController.m
//  Rotten Tomatoes
//
//  Created by Sarath Yalamanchili on 9/12/14.
//  Copyright (c) 2014 Sarath. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailsViewController.h"
#import "SVProgressHUD.h"

@interface MoviesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *movies;
@property (nonatomic,retain) UIRefreshControl *refreshControl;
@property (strong,nonatomic) UIWindow *dropdown;
@property (strong,nonatomic) UILabel *label;
@property (strong,nonatomic) UIWindow *win;

@end

@implementation MoviesViewController

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
    
    // Set view label
    UILabel *navTitle = [[UILabel alloc]init];
    navTitle.textColor =[ UIColor yellowColor];
    navTitle.backgroundColor =[UIColor clearColor];
    navTitle.text = @"Movies";
    [navTitle sizeToFit];
    self.navigationItem.titleView = navTitle;

    //Setting Back button Label
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"Movies" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    
    // Do any additional setup after loading the view from its nib.
    NSLog(@"Inside MoviesViewController");
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 125;
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    
    //Pull down Table refresh control
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull To Refresh"];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    
    //Add Loading View
    [SVProgressHUD showWithStatus:@"Updating" maskType:SVProgressHUDMaskTypeBlack];
    [self loadMovies];
    [SVProgressHUD dismiss];

}


- (void) loadMovies{
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=f8utpyzrgqvax98qkuygchef&limit=20&country=US";
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]completionHandler: ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //Hide loading view
        if(!connectionError){
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            self.movies = object[@"movies"];
            [self.tableView reloadData];
            NSLog(@"movies : %@", self.movies);
            //[self animateHeaderViewWithText:@"Network Error"];
        }else{
            NSLog(@"Connection Error Message");
            [self animateErrorText:@"Network Error"];
        }
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.movies.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    NSDictionary *movie = self.movies[indexPath.row];
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"synopsis"];
    NSString *posterUrl = [movie valueForKeyPath:@"posters.thumbnail"];
    [cell.posterView setImageWithURL:[NSURL URLWithString:posterUrl]];
    return cell;
}

-(void)animateErrorText:(NSString *) text {
    
    self.dropdown = [[UIWindow alloc] initWithFrame:CGRectMake(0, -20, 320, 20)];
    self.dropdown.backgroundColor = [UIColor lightGrayColor];
    self.label = [[UILabel alloc] initWithFrame:self.dropdown.bounds];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    self.label.backgroundColor = [UIColor whiteColor];
    [self.dropdown addSubview:self.label];
    self.dropdown.windowLevel = UIWindowLevelStatusBar;
    [self.dropdown makeKeyAndVisible];
    [self.dropdown resignKeyWindow];
    self.label.text = text;
    
    [UIView animateWithDuration:.5 delay:0 options:0 animations:^{
        self.dropdown.frame = CGRectMake(0, 0, 320, 20);
    }completion:^(BOOL finished) {
        
        [UIView animateWithDuration:.5 delay:2 options:0 animations:^{
            self.dropdown.frame = CGRectMake(0, -20, 320, 20);
        } completion:^(BOOL finished) {
            
            //animation finished!!!
        }];
        ;
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Row Selected" message:@"You've selected a row" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    // Display Alert Message
    //[messageAlert show];
    MovieDetailsViewController *movieDetailVC = [[MovieDetailsViewController alloc]init];
      NSDictionary *movieDetail = self.movies[indexPath.row];
    movieDetailVC.title = movieDetail[@"title"];
    movieDetailVC.detsynopsis = movieDetail[@"synopsis"];
    movieDetailVC.movieUrl = [movieDetail valueForKeyPath:@"posters.detailed"];
    //movieDetailVC.synopsis = movieDetail[@"title"];
    [self.navigationController pushViewController:movieDetailVC animated:YES];
    
}

 -(void)refreshView:(UIRefreshControl *)refresh {
         [self loadMovies];
         [refresh endRefreshing];
    }
- (void)refresh:(UIRefreshControl *)refreshControl {
    [self loadMovies];
    [refreshControl endRefreshing];
    NSLog(@"Exiting refreshControl");
}


@end
