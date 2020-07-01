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

@interface TimelineViewController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TimelineViewController

//Method to fetch timeline from Twitter API
- (void)fetchTimeline{
    __weak typeof(self) weakSelf = self;
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            [weakSelf.tweets addObjectsFromArray:tweets];
            
            NSLog(@"Full arr: %@", self.tweets);
            
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [weakSelf.tableView reloadData];
        
    }];
}
//Refreshing Function
- (void)beginRefresh:(UIRefreshControl*)refreshControl{
    [self fetchTimeline];
    [refreshControl endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Get timeline
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.rowHeight = 200;
    
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

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"--------Cell----Starting");
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tweetCell"];
    Tweet *currTweet = self.tweets[indexPath.row];
    NSLog(@"Curr Tweet: %@", currTweet);
    
    [cell setupCell:currTweet];
    
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
