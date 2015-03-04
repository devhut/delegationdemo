//  FormViewController.m
//  DelegationDemo
//  Created by Dan Lopez on 2/20/15.
//  Copyright (c) 2015 DevHut. All rights reserved.

#import "FormViewController.h"
#import "EditProfileViewController.h"

@interface FormViewController () <EditProfileDelegate>
{
    PeopleModel *_peopleModel;
}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *employerLabel;

- (IBAction)editTapped:(id)sender;

@end

@implementation FormViewController

- (void)logWithMessage:(NSString*)message {
    NSLog(@"%@ %@", self.class, message);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* The objective of this project is to demonstrate the use of delegation with protocols, system notifications with NSNotificationCenter, and persisting small data with NSUserDefaults. I know it doesn't look the prettiest! */
    
    // option for singleton
    //_peopleModel = [PeopleModel sharedModel];
    _peopleModel = [[PeopleModel alloc]init];
    
    /* check to see if user has setup their profile fist */
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL userInfoExists = [userDefaults boolForKey:@"HasProfileInfo"];
    if (userInfoExists) {
        [self updateUIAndPerson];
    } else {
        [self logWithMessage:@"USER HAS NOT CREATED A PROFILE YET"];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)editTapped:(id)sender {
    EditProfileViewController *editVC = [[EditProfileViewController alloc]
        initWithNibName:@"EditProfileViewController"
                 bundle:[NSBundle mainBundle]
             withPerson:_peopleModel];
    editVC.delegate = self;
    editVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:editVC animated:YES completion:^{
    }];
}
- (void)updatedProfileInfo:(PeopleModel *)personObject {
    
    // save the changes to user defaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    // since personObject is the same as _peopleModel, we could reference that too
    [userDefaults setObject:_peopleModel.name forKey:@"UserName"];
    [userDefaults setObject:_peopleModel.location forKey:@"UserLocation"];
    [userDefaults setObject:_peopleModel.employer forKey:@"UserEmployer"];
    [userDefaults setBool:YES forKey:@"HasProfileInfo"];
    BOOL saved = [userDefaults synchronize];
    if (saved) {
        [self updateUIAndPerson];
        // userInfo is a naming convention, has nothing to do with this being an actual user's info
        NSDictionary *userInfo = @{@"website_url" : @"www.devhut.me",
                                          @"name" : _peopleModel.name,
                                      @"location" : _peopleModel.location,
                                      @"employer" : _peopleModel.employer};
        /* the userInfo param provides the opportunity to pass a dicitonary.
         the object param gives you the option to pass an object: self, _peopleModel, etc...*/
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ProfileChanged"
                                                           object:_peopleModel
                                                         userInfo:userInfo];
    }
}

- (void)updateUIAndPerson {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.nameLabel.text = [userDefaults objectForKey:@"UserName"];
    self.locationLabel.text = [userDefaults objectForKey:@"UserLocation"];
    self.employerLabel.text = [userDefaults objectForKey:@"UserEmployer"];
    /* _peopleModel is the same object (in memory) as personObject
     being passed in via the delegate method */
    _peopleModel.name = [userDefaults objectForKey:@"UserName"];
    _peopleModel.location = [userDefaults objectForKey:@"UserLocation"];
    _peopleModel.employer = [userDefaults objectForKey:@"UserEmployer"];
}

@end
