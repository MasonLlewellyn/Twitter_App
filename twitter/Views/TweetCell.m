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
    self.screenNameLabel.text = self.tweet.user.screenName;
    self.createdAtLabel.text = self.tweet.createdAtString;
    
    NSURL *url = [NSURL URLWithString:self.tweet.user.profileImageURL];
    
    self.retweetLabel.text = @"";
    self.retweetLabel.text = [@(self.tweet.retweetCount) stringValue];
    /*if (self.tweet.retweeted){
        NSLog(@"updating retweet");
        self.retweetLabel.text = [@(self.tweet.retweetCount) stringValue];
    }*/
    
    self.favoriteLabel.text = @"";
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
    
    self.verifiedLogo.hidden = !(self.tweet.user.verified);
    
    [self.profilePicture setImageWithURL:url];
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
            
        }];
        
    }
    else{
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (error){
                NSLog(@"Error favoriting tweet");
            }
            
        }];
    }
    
    
    [self refreshCell];
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
