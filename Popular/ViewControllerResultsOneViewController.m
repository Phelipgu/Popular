//
//  ViewControllerResultsOneViewController.m
//  Popular
//
//  Created by Felipe on 5/3/14.
//  Copyright (c) 2014 Ec013. All rights reserved.
//

#import "ViewControllerResultsOneViewController.h"
#import <FacebookSDK/FacebookSDK.h>



@interface ViewControllerResultsOneViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *star1;
@property (weak, nonatomic) IBOutlet UIImageView *star2;
@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet UIImageView *star4;
@property (weak, nonatomic) IBOutlet UIImageView *star5;
@property (weak, nonatomic) IBOutlet UIWebView *photo;

@property (weak, nonatomic) IBOutlet UIWebView *web;

@property (weak, nonatomic) IBOutlet UIButton *button;

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewControllerResultsOneViewController

- (IBAction)change:(id)sender {
    self.button.hidden = YES;
    self.web.hidden = YES;
    self.star1.hidden = YES;
    self.star1.hidden = YES;
    self.star2.hidden = YES;
    self.star4.hidden = YES;
    self.star5.hidden = YES;
    self.photo.hidden = NO;
    [self.view bringSubviewToFront: self.label];
    self.label.text = @"My most popular photo";
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    self.photo.hidden = YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: self.linkImage]]];
    self.web.scalesPageToFit = YES;
    
    [self.photo loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: self.url]]];
    self.photo.scalesPageToFit = YES;

    
    
}

-(void) updateView{
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: self.linkImage]]];
}

- (void)viewDidAppear:(BOOL)animated{
                if (self.starsNumber <= 25){
            self.star1.image = [UIImage imageNamed: @"star2.png"];
            } else if (self.starsNumber > 26 && self.starsNumber <= 50){
                self.star1.image = [UIImage imageNamed: @"star2.png"];
                self.star2.image = [UIImage imageNamed: @"star2.png"];
            }  else if (self.starsNumber > 51 && self.starsNumber <= 75){
                self.star1.image = [UIImage imageNamed: @"star2.png"];
                self.star2.image = [UIImage imageNamed: @"star2.png"];
                self.star3.image = [UIImage imageNamed: @"star2.png"];
            } else if (self.starsNumber > 76 && self.starsNumber <= 100){
            self.star1.image = [UIImage imageNamed: @"star2.png"];
            self.star2.image = [UIImage imageNamed: @"star2.png"];
            self.star3.image = [UIImage imageNamed: @"star2.png"];
            self.star4.image = [UIImage imageNamed: @"star2.png"];
            } else {
                self.star1.image = [UIImage imageNamed: @"star2.png"];
            self.star2.image = [UIImage imageNamed: @"star2.png"];
            self.star3.image = [UIImage imageNamed: @"star2.png"];
            self.star4.image = [UIImage imageNamed: @"star2.png"];
                self.star5.image = [UIImage imageNamed: @"star2.png"];
            }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
