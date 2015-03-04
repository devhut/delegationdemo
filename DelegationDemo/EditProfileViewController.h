//  EditProfileViewController.h
//  DelegationDemo
//  Created by Dan Lopez on 2/20/15.
//  Copyright (c) 2015 DevHut. All rights reserved.

#import <UIKit/UIKit.h>
#import "PeopleModel.h"

@protocol EditProfileDelegate <NSObject>
- (void)updatedProfileInfo:(PeopleModel*)personObject;
@end

@interface EditProfileViewController : UIViewController

@property id <EditProfileDelegate> delegate;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                     withPerson:(PeopleModel*)person;

@end
