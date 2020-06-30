//
//  TweetCell.m
//  twitter
//
//  Created by Mason Llewellyn on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell

//Given a tweet, this method sets up the tableViewCell to display that tweet
- (void) setupCell:(Tweet*)givenTweet{
    NSLog(@"-------------------------");
    NSLog(@"Setting up cell with tweet from user @%@", givenTweet.user.screenName);
    self.tweet = givenTweet;
    self.tweetLabel.text = self.tweet.text;
    self.nameLabel.text = self.tweet.user.name;
    self.screenNameLabel.text = self.tweet.user.screenName;
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
