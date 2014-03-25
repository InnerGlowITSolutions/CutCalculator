//
//  AppDelegate.h
//  CutCalculator
//
//  Created by Rajesh on 17/03/14.
//  Copyright (c) 2014 Innerglow IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <sqlite3.h>

#import "ViewController.h"
//#import "CalculationViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,retain) NSString *appdDatabasePath,*appdDatabaseName,*appddocumentpath;

@property (nonatomic,retain) NSFileManager *appdfilemanager;

@property (nonatomic, retain) NSArray *appdpath;

-(void)checkAndCreateDatabase;

@end
