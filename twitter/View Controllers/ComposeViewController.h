//
//  ComposeViewController.h
//  twitter
//
//  Created by Mason Llewellyn on 7/1/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface ComposeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (nonatomic, strong) Tweet* replyTweet;
@end

NS_ASSUME_NONNULL_END
