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
