//  OtherViewController.m
//  DelegationDemo
//  Created by Dan Lopez on 2/20/15.
//  Copyright (c) 2015 DevHut. All rights reserved.

#import "OtherViewController.h"
#import "FormViewController.h"
#import "PeopleModel.h"

@interface OtherViewController () {
    PeopleModel *_peopleModel;
}

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *employerLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation OtherViewController

- (void)logWithMessage:(NSString*)message {
    NSLog(@"%@ %@", self.class, message);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // register this object as an observer for profile changes
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(receiviedProfileUpdate:)
                                                name:@"ProfileChanged"
                                              object:nil];
    [self logWithMessage:@"viewDidLoad"];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    [self.nameLabel sizeToFit];
    [self.locationLabel sizeToFit];
    [self.employerLabel sizeToFit];
    
    CGFloat height = self.employerLabel.frame.origin.y+
                     self.employerLabel.frame.size.height+
                     self.tabBarController.tabBar.frame.size.height;
    // I purposely put the lables at the bottom to demonstrate the scroll view in action
    self.scrollView.contentSize = CGSizeMake(320, height);
    [self logWithMessage:@"viewDidLayoutSubviews"];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)receiviedProfileUpdate:(NSNotification*)notification {
    // passing the FormViewController object would have been useful as well
    _peopleModel = notification.object;
    NSLog(@"%@ notification.object --> %@ %@",self.class, _peopleModel.name, _peopleModel.location);
    NSLog(@"%@ userInfo dictionary --> %@", self.class, notification.userInfo);
    self.nameLabel.text = _peopleModel.name;
    self.locationLabel.text = _peopleModel.location;
    self.employerLabel.text = _peopleModel.employer;
}

@end
