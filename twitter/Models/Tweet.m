//
//  Tweet.m
//  twitter
//
//  Created by Mason Llewellyn on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

//Re-Format's the date string from the Twitter API (E MMM d HH:mm:ss Z y) to dd/mm/yy
- (NSString *)FormattedDate:(NSString*) createdAt{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    
    //Convert string into date
    NSDate *date = [formatter dateFromString:createdAt];
    
    //Reproducing date in the desired format
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    
    return self.createdAtString = [formatter stringFromDate:date];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    NSDictionary *original_tweet = dictionary[@"retweeted_status"];
    
    if (original_tweet != nil){
        //In the case that the given tweet is a retweet
        NSDictionary *userDict = dictionary[@"user"];
        self.retweetedByUser = [[User alloc] initWithDictionary:userDict];
        
        dictionary = original_tweet;
    }
    
    self.idStr = dictionary[@"id_str"];
    self.text = dictionary[@"full_text"];
    
    self.createdAtString = dictionary[@"created_at"];
    self.createdAtString = [self FormattedDate: self.createdAtString];
    
    self.favorited = [dictionary[@"favorited"] boolValue];
    self.favoriteCount = [dictionary[@"favorite_count"] intValue];
    
    self.retweeted = [dictionary[@"retweeted"] boolValue];
    self.retweetCount = [dictionary[@"retweet_count"] intValue];
    
    NSDictionary *user = dictionary[@"user"];
    self.user = [[User alloc] initWithDictionary:user];
    
    
    return self;
}

+ (NSMutableArray*)tweetsWithArray:(NSArray *)dictionaries{
    NSMutableArray* op_array = [NSMutableArray array];
    for (NSDictionary *dict in dictionaries){
        Tweet *curr_t = [[Tweet alloc] initWithDictionary:dict];
        [op_array addObject:curr_t];
    }
    return op_array;
}


@end
