//
//  DBManager.h
//  clone2048
//
//  Created by Ilya Boltnev on 10/12/14.
//  Copyright (c) 2014 Ilya Boltnev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject

-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename;

@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFilename;
@property (nonatomic, strong) NSMutableArray *arrResults;
@property (nonatomic, strong) NSMutableArray *arrColumnNames;
@property (nonatomic) int affectedRows;
@property (nonatomic) long long lastInsertedRowID;

-(void)copyDatabaseIntoDocumentsDirectory;

-(void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable;

@end
