//
//  User.h
//  twitter
//
//  Created by Mason Llewellyn on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic) BOOL verified;
@property (nonatomic, strong) NSString *profileImageURL;
//Initializer
- (instancetype) initWithDictionary: (NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
