//
//  TweetCell.m
//  twitter
//
//  Created by Mason Llewellyn on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetCell

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
    
    /*NSLog(@"FAV-VAL %s", self.tweet.favorited);
    if (self.tweet.favorited){
        NSLog(@"updating favorites");
        self.favoriteLabel.text = [@(self.tweet.retweetCount) stringValue];
    }*/
    
    [self.profilePicture setImageWithURL:url];
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
