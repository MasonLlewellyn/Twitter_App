//
//  APIManager.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "APIManager.h"
#include "Tweet.h"

//5lUJuO5AUpPUCez4ewYDFrtgh
//s5ynGqXzstUZwFPxVyMDkYh197qvHOcVM3kwv1o2TKhS1avCdS

static NSString * const baseURLString = @"https://api.twitter.com";
static NSString * const consumerKey = @"fNvMH8e7hfBR676COZJ7kuS4E";// Enter your consumer key here
static NSString * const consumerSecret = @"rQzBkGpzYlxd2qL4TglXQ4tTZbe88rCOhNN4T1YtA4rRrwjmej";// Enter your consumer secret here

@interface APIManager()

@end

@implementation APIManager

+ (instancetype)shared {
    static APIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSString *key = consumerKey;
    NSString *secret = consumerSecret;
    // Check for launch arguments override
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-key"]) {
        key = [[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-key"];
    }
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-secret"]) {
        secret = [[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-secret"];
    }
    
    self = [super initWithBaseURL:baseURL consumerKey:key consumerSecret:secret];
    if (self) {
        
    }
    return self;
}

- (void)getHomeTimelineWithCompletion: (NSString*)maxIDStr completion:(void(^)(NSArray *tweets, NSError *error))completion{
    [self GET:@"1.1/statuses/home_timeline.json?tweet_mode=extended"
    parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *  _Nullable tweetDictionaries) {
         NSMutableArray *tweets = [Tweet tweetsWithArray:tweetDictionaries];
        completion(tweets, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSArray *tweetDictionaries = nil;
        completion(tweetDictionaries, error);
    }];
}

- (void)getHomeTimelineWithCompletion:(void(^)(NSArray *tweets, NSError *error))completion {
    
    [self GET:@"1.1/statuses/home_timeline.json?tweet_mode=extended"
   parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *  _Nullable tweetDictionaries) {
        NSMutableArray *tweets = [Tweet tweetsWithArray:tweetDictionaries];
       completion(tweets, nil);
       
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
       NSArray *tweetDictionaries = nil;
       completion(tweetDictionaries, error);
   }];
}

- (void)postStatusWithText:(NSString *)text completion:(void (^)(Tweet *, NSError *))completion{
    NSString *urlString = @"1.1/statuses/update.json?tweet_mode=extended";
    NSDictionary *parameters = @{@"status": text};
    
    [self POST:urlString parameters:parameters
      progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void)postReplyWithText:(NSString *)text givenTweet:(Tweet*)tweet completion:(void (^)(Tweet *, NSError *))completion{
    NSString *urlString = @"1.1/statuses/update.json?tweet_mode=extended";
    NSString *full_text= [NSString stringWithFormat:@"@%@ %@", tweet.user.screenName, text];
    NSDictionary *parameters = @{@"status": full_text, @"in_reply_to_status_id":tweet.idStr};
    
    
    
    [self POST:urlString parameters:parameters
      progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void)favorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion{
    NSString *urlString = @"1.1/favorites/create.json?tweet_mode=extended";
    NSDictionary *parameters = @{@"id": tweet.idStr};
    
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
    

}

- (void)unFavorite:(Tweet *)tweet competion:(void (^)(Tweet *, NSError *))completion{
    NSString *urlString = @"1.1/favorites/destroy.json?tweet_mode=extended";
    NSDictionary *parameters = @{@"id": tweet.idStr};
    
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void)retweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion{
    NSString *urlString = @"1.1/statuses/retweet/";
    NSString *fullURL = [NSString stringWithFormat:@"%@%@.json?tweet_mode=extended", urlString, tweet.idStr];
    
    [self POST:fullURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void)unRetweet:(Tweet *)tweet competion:(void (^)(Tweet *, NSError *))completion{
    NSString *urlString = @"1.1/statuses/unretweet/";
    NSString *fullURL = [NSString stringWithFormat:@"%@%@.json?tweet_mode=extended", urlString, tweet.idStr];
    
    [self POST:fullURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
        
    }];
}
@end
