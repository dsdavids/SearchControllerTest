//
//  AppDelegate.m
//  Search Test
//
//  Created by Dean S. Davids on 9/13/16.
//  Copyright © 2016 Dean S. Davids. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    splitViewController.delegate = self;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    
    BOOL detailControllerIsNavController = [secondaryViewController isKindOfClass:[UINavigationController class]];
    UIViewController *visibleDetailViewController;
    if (detailControllerIsNavController) {
        visibleDetailViewController = [(UINavigationController *)secondaryViewController topViewController];
    }
    BOOL displayingDetailView = [visibleDetailViewController isKindOfClass:[DetailViewController class]];
    
    BOOL detailViewHasEmptySelection = NO;
    if (displayingDetailView) {
        detailViewHasEmptySelection = [(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil;
    }
    
    if (detailControllerIsNavController && displayingDetailView && detailViewHasEmptySelection) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
}

-(UIViewController *)splitViewController:(UISplitViewController *)splitViewController separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController
{
    if ([self isDisplayingDetailORMapViewWithPrimaryViewController:primaryViewController]) {
        // Keep it
        return nil;
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UINavigationController *detailNav = [storyboard instantiateViewControllerWithIdentifier:@"detailNavControllerIdentifier"];
    
    return detailNav;
}

- (UISplitViewControllerDisplayMode)targetDisplayModeForActionInSplitViewController:(UISplitViewController *)svc {
    // Makes the master view controller toggle in landscape on iPad rather than always visible on the left
    if (svc.displayMode == UISplitViewControllerDisplayModePrimaryOverlay || svc.displayMode == UISplitViewControllerDisplayModePrimaryHidden) {
        return UISplitViewControllerDisplayModeAllVisible;
    }
    return UISplitViewControllerDisplayModePrimaryHidden;
}

-(BOOL)isDisplayingDetailORMapViewWithPrimaryViewController:(UIViewController *)primaryViewController
{
    if ([primaryViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = (UINavigationController *)primaryViewController;
        
        if (navController.viewControllers.count > 1) {
            UIViewController *detailController = (UINavigationController *)navController.topViewController;
            if ([detailController isKindOfClass:[UINavigationController class]]) {
                UINavigationController *detailNavController = (UINavigationController *)detailController;
                id visibleDetailViewController = detailNavController.viewControllers.firstObject;
                
                return YES;
                /*
                if (![visibleDetailViewController isKindOfClass:[MasterViewController class]]) {
                    return YES;
                }
            } else {
                if (![detailController isKindOfClass:[MasterViewController class]]) {
                    return YES;
                }
                 */
            }
        }
    }
    
    return NO;
}


@end
