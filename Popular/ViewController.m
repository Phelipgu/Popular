//
//  ViewController.m
//  Popular
//
//  Created by Felipe on 5/2/14.
//  Copyright (c) 2014 Ec013. All rights reserved.
//

#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "ViewControllerResultsOneViewController.h"


@interface ViewController () <FBLoginViewDelegate>

@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (nonatomic) int count;
@property (nonatomic) int max;
@property (nonatomic) int photosNumber;
@property (nonatomic) NSString *image;
@property (nonatomic) NSString *url;
@property (strong, nonatomic) NSMutableArray *friends;
@property (nonatomic) BOOL logged;

@end

@implementation ViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.

    self.logged = NO;
    self.count = 0;
    self.max = 0;
    self.photosNumber = 0;
    FBLoginView *loginView =
    [[FBLoginView alloc] initWithReadPermissions:
     @[@"public_profile", @"email", @"user_friends", @"user_photos", @"user_about_me"]];
    loginView.delegate = self;
    [self.view addSubview:loginView];
    
    self.profilePictureView =  [[FBProfilePictureView alloc] initWithFrame: self.view.frame];
    
    // Align the button in the center horizontally
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 40);
    [self.view addSubview:loginView];
    
    self.friends = [[NSMutableArray alloc] init];

    
    
}

- (void)facebookRequests{
    [FBRequestConnection startWithGraphPath:@"/me"
                                 parameters:nil
                                 HTTPMethod:@"GET"
                          completionHandler:^(
                                              FBRequestConnection *connection,
                                              id result,
                                              NSError *error
                                              ) {
                              /* handle the result */
                              NSLog(@"aquiiiii");
                          }];
    
    [FBRequestConnection startWithGraphPath:@"me/profile?fields=pic_large"
                                 parameters:nil
                                 HTTPMethod:@"GET"
                          completionHandler:^(
                                              FBRequestConnection *connection,
                                              id result,
                                              NSError *error
                                              ) {
                              /* handle the result */
                              if ([result objectForKey:@"data"]){
                                  NSMutableArray *data = [[NSMutableArray alloc] init];
                                  data = [result objectForKey:@"data"];
                                  self.url = [data[0] objectForKey:@"pic_large"];
                                  NSLog(@"lllllllll%@", self.url);
                              }
                              if ([result objectForKey:@"pic_large"]){
                                  self.url = [result objectForKey:@"pic_large"];
                                  
                              }
                              
                          }];
    
    
    [FBRequestConnection startWithGraphPath:@"me/photos?fields=likes.limit(1000),source"
                                 parameters:nil
                                 HTTPMethod:@"GET"
                          completionHandler:^(
                                              FBRequestConnection *connection,
                                              id result,
                                              NSError *error
                                              ) {
                              /* handle the result */
                              int likesCount[5000];
                              if ([result objectForKey:@"data"]){
                                  NSMutableArray *t = [[NSMutableArray alloc] init];
                                  t = [result objectForKey:@"data"];
                                  
                                  for (FBGraphObject *i in t){
                                      if ([i objectForKey: @"likes"]){
                                          NSDictionary *uo = [[NSDictionary alloc] initWithDictionary: [i objectForKey: @"likes"]];
                                          
                                          NSMutableArray *ola = [[NSMutableArray alloc] init];
                                          
                                          ola = [uo objectForKey: @"data"];
                                          self.count += [ola count];
                                          
                                          if ([ola count] > self.max){
                                              self.image = [[NSString alloc] initWithString: [i objectForKey: @"source"]];
                                              self.max = [ola count];
                                          }
                                          
                                          /*for (FBGraphObject *obj in ola){
                                           if (![self.friends containsObject: [obj objectForKey: @"name"]]){
                                           [self.friends addObject: [obj objectForKey: @"name"]];
                                           }
                                           int i = [self.friends indexOfObjectIdenticalTo: [obj objectForKey: @"name"]];
                                           likesCount[i]++;
                                           }*/
                                          
                                      }
                                      
                                  }
                                  self.photosNumber = [t count];
                              }
                              
                              /* int max = 0;
                               NSString *name = [[NSString alloc] init];
                               for (int i = 0; i <= [self.friends count]; i++){
                               if (likesCount[i] > max){
                               max = likesCount[i];
                               name = [self.friends objectAtIndex: i];
                               
                               }
                               }*/
                              
                              NSLog(@"total %d, %@, %d", self.count, self.image, self.photosNumber);
                              [self performSegueWithIdentifier: @"results" sender: nil];
                              
                          }];
    
    
    
    /*
     [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
     if (!error) {
     // Success! Include your code to handle the results here
     NSLog(@"user info: %@", result);
     } else {
     // An error occurred, we need to handle the error
     // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
     NSLog(@"error %@", error.description);
     }
     }];
     */
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"results"])
        {
            ViewControllerResultsOneViewController *vc = [segue destinationViewController];
            
            vc.starsNumber = self.count/self.photosNumber;
            vc.linkImage = self.url;
            vc.url =  self.image;
            NSLog(@"%d", vc.starsNumber);
        }

}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    self.profilePictureView.profileID = user.id;
    self.nameLabel.text = user.name;
    [self facebookRequests];
    
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    self.statusLabel.text = @"You're logged in as";
    NSLog(@"aaaaaaaaaaaaaaaaaaa");
    
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.profilePictureView.profileID = nil;
    self.nameLabel.text = @"";
    self.statusLabel.text= @"You're not logged in!";
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
