//
//  COShaKitManager.h
//  RageShake
//
//  Created by Jeff Kim on 4/9/14.
//  Copyright (c) 2014 Coursera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
@protocol COShaKitDelegate;

@interface COShaKitManager : NSObject <MFMailComposeViewControllerDelegate, UIAlertViewDelegate>
@property (nonatomic, weak) id <COShaKitDelegate> delegate;
@property (nonatomic, assign) BOOL isShaKitEnabled;
@property (nonatomic, assign) BOOL shouldIncludeScreenshot;
@property (nonatomic, strong) NSArray *toRecipients;
@property (nonatomic, strong) NSArray *ccRecipients;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *messageBody;
@property (nonatomic, strong) NSString *alertTitle;
@property (nonatomic, strong) NSString *alertMessage;

+ (COShaKitManager *)sharedManager;
- (void)configureShaKitWithAlertTitle:(NSString *)alertTitle alertMessage:(NSString *)alertMessage toRecipients:(NSArray *)toRecipients ccRecipients:(NSArray *)ccRecipients subject:(NSString *)subject messageBody:(NSString *)messageBody;
- (void)showShaKitAlert;
- (void)showShaKitViewController;
- (void)addAttachmentData:(NSData *)attachmentData mimeType:(NSString *)mimeType fileName:(NSString *)filename;
@end

@protocol COShaKitDelegate <NSObject>
@optional
- (void)willPresentShaKitView:(COShaKitManager *)shaKitManager;
- (void)didPresentShaKitView:(COShaKitManager *)shaKitManager;
- (void)didFinishSendingShaKitEvent:(COShaKitManager *)shaKitManager;
- (void)didFailSendingShaKitEvent:(COShaKitManager *)shaKitManager error:(NSError *)error;
@end
