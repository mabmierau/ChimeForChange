//
//  CCAppDelegate.m
//  GlobeFun
//
//  Created by Mary Ann Brennan on 12/7/13.
//  Copyright (c) 2013 Mary Ann Brennan. All rights reserved.
//

#import "CCAppDelegate.h"

@implementation CCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    CCViewController *viewController = [[CCViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];

    self.window.rootViewController = navigationController;
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];

    // appearance
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        // #552A46
//        85, 42, 70
//        63,32,52
//        navigationController.navigationBar.barTintColor = [UIColor colorWithRed:85/255.0 green:42/255.0 blue:70/255.0 alpha:0.25];
        navigationController.navigationBar.barTintColor = [UIColor colorWithRed:63/255.0 green:32/255.0 blue:52/255.0 alpha:1];
        navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor colorWithRed:248/255.0 green:174/255.0 blue:52/255.0 alpha:1.0]};
        navigationController.navigationBar.translucent = NO;

        navigationController.navigationBar.tintColor = [UIColor colorWithRed:248/255.0 green:174/255.0 blue:52/255.0 alpha:1.0];
    }else {
        navigationController.navigationBar.tintColor = [UIColor redColor];
    }
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

@end
