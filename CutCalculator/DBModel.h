//
//  DBModel.h
//  WorkGoalDemo
//
//  Created by dckap_newmac3 on 5/3/13.
//  Copyright (c) 2013 DCKAP. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <sqlite3.h>

#import "AppDelegate.h"

@class AppDelegate;
@interface DBModel : NSObject

@property(nonatomic,strong) AppDelegate *app_delegate;

//
//-(NSMutableArray *)fetchDiaArr:(int)millsID materialID:(int)matID mtypeID:(int)typrID;
//-(NSMutableArray *)fetchFluteArr:(int)millsID diameter:(int)dia mtypeID:(int)typeID material:(int)matId;
//-(NSMutableArray *)fetchSliderValues:(int)millsID mtypeID:(int)typeID material:(int)matId diameter:(int)dia fluteCount:(int)fCount;
//-(NSMutableArray *)fetchFluteArr:(int)millsID diameter:(NSString *)dia mtypeID:(int)typeID material:(int)matId;
//-(NSMutableArray *)fetchSliderValues:(int)millsID mtypeID:(int)typeID material:(int)matId diameter:(float)dia fluteCount:(float)fCount;


-(NSMutableArray *)fetchDiaArr:(NSString *)millsID materialID:(NSString *)matID mtypeID:(NSString *)typrID;
-(NSMutableArray *)fetchFluteArr:(NSString *)millsID diameter:(NSString *)dia mtypeID:(NSString *)typeID material:(NSString *)matId;
-(NSMutableArray *)fetchSliderValues:(NSString *)millsID mtypeID:(NSString *)typeID material:(NSString *)matId diameter:(NSString *)dia fluteCount:(NSString *)fCount;

-(NSMutableArray *)fetchDiameterArr:(NSString *)millsID mtypeID:(NSString *)typrID;



//


@end
