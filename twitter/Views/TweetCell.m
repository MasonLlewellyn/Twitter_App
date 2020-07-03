//
//  TweetCell.m
//  twitter
//
//  Created by Mason Llewellyn on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "DateTools.h"

@implementation TweetCell


//Refreshes the cell UI
- (void) refreshCell{
    [self setupCell:self.tweet];
}
//Given a tweet, this method sets up the tableViewCell to display that tweet
- (void) setupCell:(Tweet*)givenTweet{
    self.tweet = givenTweet;
    self.tweetLabel.text = self.tweet.text;
    self.nameLabel.text = self.tweet.user.name;
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
    
    self.retweetLabel.text = [@(self.tweet.retweetCount) stringValue];
    if (self.tweet.retweeted){
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState: UIControlStateNormal];
    }
    else{
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState: UIControlStateNormal];
    }
    
    self.favoriteLabel.text = [@(self.tweet.favoriteCount) stringValue];
    
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
 
    
    self.replyLabel.text = [@(self.tweet.replyCount) stringValue];
    self.verifiedLogo.hidden = !(self.tweet.user.verified);
    
    [self.profilePicture setImageWithURL:url];
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
            [self refreshCell];
        }];
    }
    else{
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (error){
                NSLog(@"Error retweeting tweet");
            }
            [self refreshCell];
        }];
    }
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
            [self refreshCell];
            
        }];
        
    }
    else{
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (error){
                NSLog(@"Error favoriting tweet");
            }
            [self refreshCell];
            
        }];
    }
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
