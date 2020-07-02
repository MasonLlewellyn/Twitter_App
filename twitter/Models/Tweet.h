//
//  Tweet.h
//  twitter
//
//  Created by Mason Llewellyn on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
NS_ASSUME_NONNULL_BEGIN

@interface Tweet : NSObject
@property (nonatomic, strong) NSString *idStr;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *createdAtString;
@property (nonatomic, strong) User *user;

//Retweet Properties
@property (nonatomic) BOOL retweeted;
@property (nonatomic) int retweetCount;
@property (nonatomic, strong) User *retweetedByUser;
//Favorite Properties
@property (nonatomic) BOOL favorited;
@property (nonatomic) int favoriteCount;

@property (nonatomic) int replyCount;
@property (nonatomic, strong) NSDate *createdDate;


- (instancetype)initWithDictionary:(NSDictionary*) dictionary;
+ (NSMutableArray*)tweetsWithArray:(NSArray*)dictionaries;//Spawn an array of tweet objects given their dictionaries




@end

NS_ASSUME_NONNULL_END
