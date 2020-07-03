//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "tweetDetailsViewController.h"
#import "ComposeViewController.h"


@interface TimelineViewController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TimelineViewController

//Method to fetch timeline from Twitter API
- (void)fetchTimeline{
    NSLog(@"---------------------------Fetching your precious data");
    __weak typeof(self) weakSelf = self;
    [[APIManager shared] getHomeTimelineWithCompletion: ^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            [weakSelf.tweets addObjectsFromArray:tweets];
            
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [weakSelf.tableView reloadData];
    }];
}
//Refreshing Function
- (void)beginRefresh:(UIRefreshControl*)refreshControl{
    NSLog(@"Refreshing something");
    [self fetchTimeline];
    
    [refreshControl endRefreshing];
}

//Re-Fetch the timeline when it reappears
- (void)viewWillAppear:(BOOL)animated{
    [self fetchTimeline];
}

//Get the maximum id number out of the present array of tweets
- (NSString*)getMaxTweetID{
    NSInteger max_id = 0;
    NSString *max_id_str = @"0";
    for (Tweet *i in self.tweets){
        NSInteger id_val = [i.idStr intValue];
        if (id_val > max_id){
            max_id = id_val;
            max_id_str = i.idStr;
        }
    }
    return max_id_str;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Get timeline
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //self.tableView.rowHeight = 200;
    
    //Initialize tweet array
    self.tweets = [[NSMutableArray alloc] init];
    
    //RefreshControl
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    
    [self fetchTimeline];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logoutPressed:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
}


#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tweetCell"];
    Tweet *currTweet = self.tweets[indexPath.row];
    
    [cell setupCell:currTweet];
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[TweetCell class]]){
        TweetCell *cell = sender;
        tweetDetailsViewController *control = [segue destinationViewController];
          
        //[control setupView:cell.tweet];
        control.tweet = cell.tweet;
    }
    
    
}



@end
