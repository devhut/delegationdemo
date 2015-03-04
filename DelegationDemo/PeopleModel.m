//  PeopleModel.m
//  DelegationDemo
//  Created by Dan Lopez on 2/20/15.
//  Copyright (c) 2015 DevHut. All rights reserved.

#import "PeopleModel.h"

@implementation PeopleModel

+ (instancetype)sharedModel {
    static PeopleModel *sharedPeeps = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPeeps = [[self alloc]init];
    });
    return sharedPeeps;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _name = @"Steve Smith";
        _location = @"Los Angeles";
        _employer = @"Pixar";
    }
    return self;
}

@end
