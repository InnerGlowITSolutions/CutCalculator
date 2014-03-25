//
//  AppDelegate.m
//  CutCalculator
//
//  Created by Rajesh on 17/03/14.
//  Copyright (c) 2014 Innerglow IT Solutions. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize appdDatabasePath,appdDatabaseName,appddocumentpath,appdfilemanager,appdpath;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
   
    /*ViewController *viewController = [[ViewController alloc]     init];
     
    UINavigationController *nav = [[UINavigationController alloc]  initWithRootViewController:viewController];
     self.window.rootViewController = nav;
     */
    
    //search for DB
    self.appdDatabaseName = @"cutcalcdb.sqlite";
	self.appdpath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
	NSLog(@"appdpath %@",self.appdpath);
	
	self.appddocumentpath=[appdpath objectAtIndex:0];
    
	self.appdDatabasePath=[appddocumentpath stringByAppendingPathComponent:appdDatabaseName];
	
	NSLog(@"DatabasePath %@",appdDatabasePath);
	
	[self checkAndCreateDatabase];

     ////
    CalculationViewController *viewController = [[CalculationViewController alloc]init];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}

#pragma mark-DB creation
-(void)checkAndCreateDatabase
{
	// Check if the SQL database has already been saved to the users phone, if not then copy it over
	BOOL success;
    
    NSError *error;
    
	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required
	//	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	self.appdfilemanager=[NSFileManager defaultManager];
	
	// Check if the database has already been created in the users filesystem
	success = [appdfilemanager fileExistsAtPath:appdDatabasePath];
	
	// If the database already exists then return without doing anything
	if(success)
		return;
	
	// If not then proceed to copy the database from the application to the users filesystem
	
	// Get the path to the database in the application package
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:appdDatabaseName];
	NSLog(@"databasepathfromapp %@",databasePathFromApp);
	// Copy the database from the package to the users filesystem
	[appdfilemanager copyItemAtPath:databasePathFromApp toPath:self.appdDatabasePath error:&error];
    //NSLog(@"error %@",error);
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
