//
//  ALPushAssist.m
//  Applozic
//
//  Created by Divjyot Singh on 07/01/16.
//  Copyright © 2016 applozic Inc. All rights reserved.
//

#import "ALPushAssist.h"

#import "ALPushNotificationService.h"
#import "ALMessageDBService.h"
#import "ALUserDetail.h"
#import "ALUserDefaultsHandler.h"
#import "ALChatViewController.h"
#import "ALMessagesViewController.h"
#import "ALAppLocalNotifications.h"


@implementation ALPushAssist

-(void)assist:(NSString*)notiMsg and :(NSMutableDictionary*)dict ofUser:(NSString*)userId{

    if (!self.isChatViewOnTop) {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showNotificationAndLaunchChat"
                                                             object:notiMsg
                                                           userInfo:dict];
    }

}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:@"showNotificationAndLaunchChat"];
}


-(BOOL) isChatViewOnTop{
    return ( [self.topViewController isKindOfClass:[ALMessagesViewController class]]||[self.topViewController isKindOfClass:[ALChatViewController class]]);
}

- (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
        
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
        
    } else if (rootViewController.presentedViewController) {
        
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
        
    } else {
        return rootViewController;
    }
}

@end