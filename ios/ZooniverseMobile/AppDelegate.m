/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "AppDelegate.h"

#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import <React/RCTPushNotificationManager.h>
#import "ZooniverseMobile-Swift.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

  NSURL *jsCodeLocation;

  #ifdef DEBUG
    jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
  #else
    jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
  #endif

  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"ZooniverseMobile"
                                               initialProperties:nil
                                                   launchOptions:launchOptions];
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];

  UIView* launchScreen =  [[[NSBundle mainBundle] loadNibNamed:@"LaunchScreen" owner:self options:nil] objectAtIndex:0];
  launchScreen.frame = [UIScreen mainScreen].bounds;
  rootView.loadingView = launchScreen;
  rootView.loadingViewFadeDelay = 0.30;
  rootView.loadingViewFadeDuration = 0.30;

  [FirebaseManager.shared configureFirebase];
  [application registerForRemoteNotifications];
  
  return YES;
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
  [RCTPushNotificationManager didRegisterUserNotificationSettings:notificationSettings];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  [RCTPushNotificationManager didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)notification {
  [RCTPushNotificationManager didReceiveRemoteNotification:notification];
}


//For iOS >= 10 - Called when a notification is delivered to a foreground app.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
  completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
}

//For iOS >= 10 - Called to let your app know which action was selected by the user for a given notification.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
  [RCTPushNotificationManager didReceiveRemoteNotification:response.notification.request.content.userInfo];
  completionHandler();
}

@end
