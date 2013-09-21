//
//  AppDelegate.m
//  Books
//
//  Created by Misato Tina Alexandre on 8/19/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuTVC.h"





@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
    UINavigationController *nav=(UINavigationController *)self.window.rootViewController;
    MenuTVC *mtvc=(MenuTVC *)[[nav viewControllers]objectAtIndex:0];
                   mtvc.managedObjectContext=self.managedObjectContext;

   UIImage *navImage=[UIImage imageNamed:@"34495e.png"];
   
    [[UINavigationBar appearance]setBackgroundImage:navImage forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    
    
   NSDictionary *navbarTitleTextAttributes =
    [NSDictionary dictionaryWithObjectsAndKeys:
    
     [UIColor whiteColor],NSForegroundColorAttributeName,nil];
    
   [[UINavigationBar appearance]setTitleTextAttributes:navbarTitleTextAttributes];

    
   /* UITabBarController *tabBarController =(UITabBarController *)self.window.rootViewController;
    UINavigationController *bookListTVCnav=[[tabBarController viewControllers]objectAtIndex:0];
    UINavigationController *collectionListTVCnav=[[tabBarController viewControllers]objectAtIndex:1];
    UINavigationController *genreListTVCnav=[[tabBarController viewControllers]objectAtIndex:2];
    UINavigationController *dashboardVCnav=[[tabBarController viewControllers]objectAtIndex:3];*/
    
    /*BookListTVC *bltvc=[[bookListTVCnav viewControllers]objectAtIndex:0];
    bltvc.managedObjectContext=self.managedObjectContext;
    bltvc.title=@"Title";
  
    
    CollectionListTVC *cltvc=[[collectionListTVCnav viewControllers]objectAtIndex:0];
    cltvc.managedObjectContext=self.managedObjectContext;
    
    GenreListTVC *gltvc=[[genreListTVCnav viewControllers]objectAtIndex:0];
    gltvc.managedObjectContext=self.managedObjectContext;
    
    DashboardVC *dashboard=[[dashboardVCnav viewControllers]objectAtIndex:0];
    dashboard.managedObjectContext=self.managedObjectContext;
    //[self customTab];*/
                   
    //styling the nav bar
    
     //[[UITabBar appearance]setBarTintColor:[UIColor whiteColor]];
    /*[[UITabBar appearance]setBackgroundColor:[UIColor clearColor]];
    UIImage *transparentImage=[UIImage imageNamed:@".png"];
    [[UINavigationBar appearance]setBackgroundImage:transparentImage forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                               [UIColor whiteColor],UITextAttributeTextColor,
                                               [UIColor blackColor], UITextAttributeTextShadowColor, nil];
    [[UINavigationBar appearance]setTitleTextAttributes:navbarTitleTextAttributes];*/
   
    
    
    
  
   

    
    return YES;
}
/*-(void)customTab{
    [[UITabBar appearance]setBackgroundColor:[UIColor clearColor]];
}*/

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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Books" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Books.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
