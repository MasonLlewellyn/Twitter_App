//
//  tweetDetailsViewController.h
//  twitter
//
//  Created by Mason Llewellyn on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface tweetDetailsViewController : UIViewController
@property (nonatomic, strong) Tweet *tweet;
- (void) setupView;
@end

NS_ASSUME_NONNULL_END
