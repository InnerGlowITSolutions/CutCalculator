//
//  DBModel.m
//  WorkGoalDemo
//
//  Created by dckap_newmac3 on 5/3/13.
//  Copyright (c) 2013 DCKAP. All rights reserved.
//

#import "DBModel.h"

@implementation DBModel

@synthesize app_delegate;

sqlite3_stmt *SqliteStatement;
sqlite3 *compiledatabase;

-(NSMutableArray *)fetchDiaArr:(NSString *)millsID materialID:(NSString *)matID mtypeID:(NSString *)typrID;
{
    app_delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];

    NSMutableArray *diaDetailsArr=[[NSMutableArray alloc]init];
    
    NSString *sql_str;

    //sql_str = [NSString stringWithFormat:@"Select diameter from side_table Where millsid=%d, materialid=%d,mtypeid=%d",millsID,matID,typrID];
    sql_str = [NSString stringWithFormat:@"Select diameter from side_table Where millsid=%@ AND metrialid=%@ AND mtypeid=%@",millsID,matID,typrID];
    
    if (sqlite3_open([[app_delegate appdDatabasePath] UTF8String], &compiledatabase) == SQLITE_OK){
        const char *sqlQuery_Select = (char *)[sql_str UTF8String];
        if (sqlite3_prepare_v2(compiledatabase, sqlQuery_Select, -1, &SqliteStatement, NULL)==SQLITE_OK)
        {
            NSMutableSet *setDia=[[NSMutableSet alloc]init];
            //int count= sqlite3_column_count(SqliteStatement);
            while(sqlite3_step(SqliteStatement) == SQLITE_ROW)
            {
                for (int i=0; i<1; i++)
                {
                    //NSLog(@"log %@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(SqliteStatement, i)]);
                    [setDia addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(SqliteStatement, i)]];
                }
            }
            //NSLog(@"set dia %@",setDia);
            for (NSString *obj in setDia) {
                [diaDetailsArr addObject:obj];
            }
        }
        else{
            NSLog(@"Error while reading Employee Name -->%s",sqlite3_errmsg(compiledatabase));
        }
    }
    return diaDetailsArr;
}

-(NSMutableArray *)fetchFluteArr:(NSString *)millsID diameter:(NSString *)dia mtypeID:(NSString *)typeID material:(NSString *)matId;
{
    app_delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSMutableArray *fluteDetailsArr=[[NSMutableArray alloc]init];
    
    NSString *sql_str;
    
    
    //sql_str = [NSString stringWithFormat:@"Select diameter from side_table Where millsid=%d, materialid=%d,mtypeid=%d",millsID,matID,typrID];
    sql_str = [NSString stringWithFormat:@"Select flutcount from side_table Where millsid=%@ AND metrialid=%@ AND diameter=%@ AND mtypeid=%@",millsID,matId,dia,typeID];
    
    if (sqlite3_open([[app_delegate appdDatabasePath] UTF8String], &compiledatabase) == SQLITE_OK){
        const char *sqlQuery_Select = (char *)[sql_str UTF8String];
        if (sqlite3_prepare_v2(compiledatabase, sqlQuery_Select, -1, &SqliteStatement, NULL)==SQLITE_OK)
        {
            //int count= sqlite3_column_count(SqliteStatement);
            while(sqlite3_step(SqliteStatement) == SQLITE_ROW)
            {
                for (int i=0; i<1; i++)
                {
                    //NSLog(@"log %@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(SqliteStatement, i)]);
                    [fluteDetailsArr addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(SqliteStatement, i)]];
                }
            }
            //NSLog(@"flute  %@",fluteDetailsArr);
            
        }
        else{
            NSLog(@"Error while reading Employee Name -->%s",sqlite3_errmsg(compiledatabase));
        }
    }
    return fluteDetailsArr;
}


-(NSMutableArray *)fetchSliderValues:(NSString *)millsID mtypeID:(NSString *)typeID material:(NSString *)matId diameter:(NSString *)dia fluteCount:(NSString *)fCount;
{
    app_delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSString *sql_str;
    
    NSLog(@"millsID %@ mtypeID %@ material %@ diameter %@ fluteCount %@",millsID,typeID,matId,dia,fCount);
   
    NSMutableArray *sliderDetailsArr=[[NSMutableArray alloc]init];
    //millsIDstr=@"2";
    if([millsID isEqualToString:@"2"]){
        sql_str = [NSString stringWithFormat:@"Select rev,speed from side_table Where millsid=%@ AND metrialid=%@ AND diameter=%@ AND mtypeid=%@",millsID,matId,dia,typeID];
    }
    else
    {
        sql_str = [NSString stringWithFormat:@"Select rev,speed,cutingdepth from side_table Where millsid=%@ AND metrialid=%@ AND diameter=%@ AND mtypeid=%@ AND flutcount=%@",millsID,matId,dia,typeID,fCount];
    }
    if (sqlite3_open([[app_delegate appdDatabasePath] UTF8String], &compiledatabase) == SQLITE_OK){
        const char *sqlQuery_Select = (char *)[sql_str UTF8String];
        if (sqlite3_prepare_v2(compiledatabase, sqlQuery_Select, -1, &SqliteStatement, NULL)==SQLITE_OK)
        {
            int count= sqlite3_column_count(SqliteStatement);
            while(sqlite3_step(SqliteStatement) == SQLITE_ROW)
            {
                for (int i=0; i<count; i++)
                {
                    //NSLog(@"log %@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(SqliteStatement, i)]);
                    [sliderDetailsArr addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(SqliteStatement, i)]];
                }
            }
            
        }
        else
        {
            NSLog(@"Error while reading Employee Name -->%s",sqlite3_errmsg(compiledatabase));
        }
    }
    return sliderDetailsArr;
}

@end
