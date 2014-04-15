//
//  COShaKitManager.m
//  ShaKit
//
//  Created by Jeff Kim on 4/9/14.
//  Copyright (c) 2014 Coursera. All rights reserved.
//

#import "COShaKitManager.h"

@interface COShaKitManager ()
@property (nonatomic, strong) MFMailComposeViewController *mailViewController;
@end

@implementation COShaKitManager

+ (COShaKitManager *)sharedManager {
    static COShaKitManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[COShaKitManager alloc] init];
    });
    return sharedManager;   
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _shouldIncludeScreenshot = YES;
    }
    return self;
}

- (void)configureShaKitWithAlertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage toRecipients:(NSArray *)toRecipients ccRecipients:(NSArray *)ccRecipients subject:(NSString *)subject messageBody:(NSString *)messageBody {
    self.alertTitle = alertTitle;
    self.alertMessage = alertMessage;
    self.toRecipients = toRecipients;
    self.ccRecipients = ccRecipients;
    self.subject = subject;
    self.messageBody = messageBody;
}

#pragma mark - AlertView
- (void)showShaKitAlert
{
    UIAlertView *alertView = [[UIAlertView alloc] init];
    alertView.delegate = self;
    
    alertView.title = self.alertTitle ? self.alertTitle:@"Seems like you are shaking your device.";
    alertView.message = self.alertMessage ? self.alertMessage:@"Do you want to send feedback?";
    [alertView addButtonWithTitle:@"Cancel"];
    [alertView addButtonWithTitle:@"Yes"];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self showShaKitViewController];
    }
    return;
}

#pragma mark - ShaKitViewController
- (void)showShaKitViewController {
    if ([MFMailComposeViewController canSendMail]) {
        self.mailViewController = [[MFMailComposeViewController alloc] init];
        self.mailViewController.mailComposeDelegate = self;
        
        if ([self.delegate respondsToSelector:@selector(willPresentShaKitView:)]) {
            [self.delegate willPresentShaKitView:self];
        }
        
        [self.mailViewController setToRecipients:self.toRecipients];
        [self.mailViewController setCcRecipients:self.ccRecipients];
        [self.mailViewController setSubject:self.subject];
        [self.mailViewController setMessageBody:self.messageBody isHTML:NO];
        
        if (self.shouldIncludeScreenshot) {
            [self.mailViewController addAttachmentData:[self takeScreenshot] mimeType:@"image/png" fileName:@"ShaKit.png"];
        }
        
        [[self currentViewController] presentViewController:self.mailViewController animated:YES completion:nil];
        if ([self.delegate respondsToSelector:@selector(didPresentShaKitView:)]) {
            [self.delegate didPresentShaKitView:self];
        }
    }
}

- (void)addAttachmentData:(NSData *)attachmentData mimeType:(NSString *)mimeType fileName:(NSString *)filename {
    [self.mailViewController addAttachmentData:attachmentData mimeType:mimeType fileName:filename];
}

- (UIViewController *)currentViewController {
    UIViewController *currentViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    UIViewController *viewController;
    
    if ([currentViewController isKindOfClass:[UINavigationController class]]) {
        viewController = ((UINavigationController *)currentViewController).topViewController;
    } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
        viewController = ((UITabBarController *)currentViewController).selectedViewController;
    } else {
        viewController = currentViewController;
    }
    
    return viewController;
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [[self currentViewController] dismissViewControllerAnimated:YES completion:nil];
    if (result == MFMailComposeResultCancelled) {
        if ([self.delegate respondsToSelector:@selector(didFailSendingShaKitEvent:error:)]) {
            [self.delegate didFailSendingShaKitEvent:self error:error];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(didFinishSendingShaKitEvent:)]) {
            [self.delegate didFinishSendingShaKitEvent:self];
        }
    }
}

#pragma mark - Screenshot
- (NSData *)takeScreenshot {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(window.bounds.size);
    
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *data = UIImagePNGRepresentation(image);
    
    return data;
}

@end
