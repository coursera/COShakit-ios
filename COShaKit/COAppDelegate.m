//
//  COAppDelegate.m
//  COShaKit
//
//  Created by Jeff Kim on 4/14/14.
//  Copyright (c) 2014 Coursera. All rights reserved.
//

#import "COAppDelegate.h"
#import "COExampleViewController.h"

@implementation COAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[COShaKitManager sharedManager] configureShaKitWithAlertTitle:@"Is everything Ok?" alertMessage:@"Seems like you are shaking your device, do you want to send feedback to Coursera" toRecipients:@[@"mobile_support@example.com"] ccRecipients:@[@"eng_ios@example.com"] subject:nil messageBody:nil];
    [[COShaKitManager sharedManager] setDelegate:self];
    
    COExampleViewController *exampleViewController = [[COExampleViewController alloc] init];
    self.window.rootViewController = exampleViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - COShaKitDelegate
- (void)willPresentShaKitView:(COShaKitManager *)shaKitManager {
    // Setup
    NSString *buildString = [NSString stringWithFormat:@"Build %@ (%@)", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    shaKitManager.subject = [NSString stringWithFormat:@"ShaKit: %@",buildString];
    shaKitManager.messageBody = [NSString stringWithFormat:@"Feedback: \n\n\n"];
    //Include extra files and debug information such as log files in here.
}

- (void)didPresentShaKitView:(COShaKitManager *)shaKitManager {
    // Successful ShaKitView Presentation
}

- (void)didFinishSendingShaKitEvent:(COShaKitManager *)shaKitManager {
    // Successful ShaKit Event
}

- (void)didFailSendingShaKitEvent:(COShaKitManager *)shaKitManager error:(NSError *)error {
    NSLog(@"%@",error);
}

@end
