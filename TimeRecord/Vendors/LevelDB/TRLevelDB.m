//
//  TRLevelDB.m
//  TimeRecord
//
//  Created by ocean on 14-7-24.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import "TRLevelDB.h"
#import <LevelDB.h>

@interface TRLevelDB ()

@property (nonatomic, strong) LevelDB *db;

@end

@implementation TRLevelDB

+ (instancetype)sharedInstance
{
    static TRLevelDB *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TRLevelDB alloc] init];
        instance.db = [LevelDB databaseInLibraryWithName:@"test.ldb"];
    });
    
    return instance;
}

- (void)saveObject:(id)obj forKey:(NSString *)key
{
    [self.db setObject:obj forKey:key];
}

- (id)loadObjectForKey:(NSString *)key
{
    return [self.db objectForKey:key];
}

@end
