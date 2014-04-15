//
//  DAAppDelegate.m
//  DoubanAlbum
//
//  Created by Tonny on 12-12-8.
//  Copyright (c) 2012年 SlowsLab. All rights reserved.
//

#import "DAAppDelegate.h"
#import "DAHtmlRobot.h"
#import "JSONKit.h"

@implementation DAAppDelegate

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (void) onReq:(BaseReq*)req{
    if([req isKindOfClass:[SendMessageToWXResp class]])
    {
        SLLog(@"strMsg %@", req);
    }
}

- (void) onResp:(BaseResp*)resp{
    SLLog(@"resp %@", resp);
    
    if([resp isMemberOfClass:[SendMessageToWXResp class]])
    {
        if (resp.errCode == 0) {
            UIViewController *vc = [[[UIApplication sharedApplication] keyWindow] rootViewController];
            [vc showSuccessTips:NSLocalizedString(@"分享成功", nil)];
        }
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [WXApi registerApp:@"Your Weixin app id"];
    
//#warning
#ifdef DEBUG
    [self writeDoubanAlbumDataToJSON];
#endif
    return YES;
}

#ifdef DEBUG
- (void)writeDoubanAlbumDataToJSON{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DoubanAlbumData_Local" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    path = [APP_CACHES_PATH stringByAppendingPathComponent:@"JSON"];
    
    NSString *text = [dic JSONString];
    [text writeToFile:path
           atomically:YES
             encoding:NSUTF8StringEncoding
                error:nil];
}
#endif
							
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


@end
