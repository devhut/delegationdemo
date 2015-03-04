//  PeopleModel.h
//  DelegationDemo
//  Created by Dan Lopez on 2/20/15.
//  Copyright (c) 2015 DevHut. All rights reserved.

#import <Foundation/Foundation.h>

@interface PeopleModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *employer;

+ (instancetype)sharedModel;

@end
