//
//  User.m
//  twitter
//
//  Created by Mason Llewellyn on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    
    if (self){
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.verified = dictionary[@"verified"]; //This is extra for now, I'll remove it if it causes problems
        self.profileImageURL = dictionary[@"profile_image_url_https"];
        
    }
    return self;
}
@end
