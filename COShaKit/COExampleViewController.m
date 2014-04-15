//
//  COExampleViewController.m
//  COShaKit
//
//  Created by Jeff Kim on 4/14/14.
//  Copyright (c) 2014 Coursera. All rights reserved.
//

#import "COExampleViewController.h"
#import "COShaKitManager.h"

@interface COExampleViewController ()

@end

@implementation COExampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showShaKit:(id)sender {
    // Display ShaKitView from anywhere
    [[COShaKitManager sharedManager] showShaKitViewController];
}

@end
