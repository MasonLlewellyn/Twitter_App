//
//  tweetDetailsViewController.m
//  twitter
//
//  Created by Mason Llewellyn on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "tweetDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "DateTools.h"
#import "APIManager.h"
#import "ComposeViewController.h"

@interface tweetDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIImageView *verifiedLogo;


@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation tweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
}

- (void)setupView{
    self.tweetLabel.text = self.tweet.text;
    self.userNameLabel.text = self.tweet.user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
       
    //Setting the CreatedAt Label to show either relative or absolute date
    NSDate *dt = [NSDate date];
    NSTimeInterval refTime = -86400;
    NSTimeInterval sinceCreated = [self.tweet.createdDate timeIntervalSinceDate:dt];
       
    if (sinceCreated >= refTime)
           self.createdAtLabel.text = self.tweet.createdDate.shortTimeAgoSinceNow;
    else
        self.createdAtLabel.text = self.tweet.createdAtString;
    
    
    NSURL *url = [NSURL URLWithString:self.tweet.user.profileImageURL];
       
    self.retweetCountLabel.text = [@(self.tweet.retweetCount) stringValue];
    if (self.tweet.retweeted){
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState: UIControlStateNormal];
    }
    else{
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState: UIControlStateNormal];
    }
       
    self.favoriteCountLabel.text = [@(self.tweet.favoriteCount) stringValue];
       
    if (self.tweet.favorited){
        [self.favoriteButton setImage:
                [UIImage imageNamed:@"favor-icon-red"]
                            forState: UIControlStateNormal];
    }
    else{
        [self.favoriteButton setImage:
                    [UIImage imageNamed:@"favor-icon"]
                                forState: UIControlStateNormal];
    }
    
       
    self.replyCountLabel.text = [@(self.tweet.replyCount) stringValue];
    self.verifiedLogo.hidden = !(self.tweet.user.verified);
       
    [self.profileImageView setImageWithURL:url];
}
- (IBAction)favoritePressed:(id)sender {
    if (self.tweet.favorited){
        //If you already favorited a tweet
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        
        [[APIManager shared] unFavorite:self.tweet competion:^(Tweet *tweet, NSError *error) {
            if (error){
                NSLog(@"Error favoriting tweet");
            }
            [self setupView];
            
        }];
        
    }
    else{
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (error){
                NSLog(@"Error favoriting tweet");
            }
            [self setupView];
            
        }];
    }
}

- (IBAction)retweetPressed:(id)sender {
    if (self.tweet.retweeted){
        //If you already retweeted a tweet
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        
        [[APIManager shared] unRetweet:self.tweet competion:^(Tweet *tweet, NSError *error) {
            if (error){
                NSLog(@"Error un-retweeting tweet");
            }
            [self setupView];
        }];
    }
    else{
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (error){
                NSLog(@"Error retweeting tweet");
            }
            [self setupView];
        }];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UINavigationController *control = [segue destinationViewController];
    ((ComposeViewController*)(control.viewControllers[0])).replyTweet = self.tweet;
}


@end
