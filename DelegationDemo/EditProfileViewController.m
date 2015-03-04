//  EditProfileViewController.m
//  DelegationDemo
//  Created by Dan Lopez on 2/20/15.
//  Copyright (c) 2015 DevHut. All rights reserved.

#import "EditProfileViewController.h"

@interface EditProfileViewController () {
    PeopleModel *_peopleModel;
}

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *locationField;
@property (weak, nonatomic) IBOutlet UITextField *employerField;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

- (IBAction)cancelTapped:(id)sender;
- (IBAction)saveTapped:(id)sender;

@end

@implementation EditProfileViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
                     withPerson:(PeopleModel*)person {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _peopleModel = person;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameField.text = _peopleModel.name;
    self.locationField.text = _peopleModel.location;
    self.employerField.text = _peopleModel.employer;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelTapped:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
    }];
}
- (IBAction)saveTapped:(id)sender {
    _peopleModel.name = self.nameField.text;
    _peopleModel.location = self.locationField.text;
    _peopleModel.employer = self.employerField.text;
    /* the _peopleModel object will be changed in memory, 
     so we just pass it through the delegate method for luxury */
    [self.delegate updatedProfileInfo:_peopleModel];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
    }];
}
@end
