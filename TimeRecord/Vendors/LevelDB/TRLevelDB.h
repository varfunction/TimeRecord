//
//  TRLevelDB.h
//  TimeRecord
//
//  Created by ocean on 14-7-24.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRLevelDB : NSObject

+ (instancetype)sharedInstance;

// 获取一个时光，队列的每一个元素是 TRTimeModel
- (NSArray *)getTimeForKey:(NSString *)key;
- (NSArray *)saveTimeForKey:(NSString *)key;

- (void)saveObject:(id)obj forKey:(NSString *)key;
- (id)loadObjectForKey:(NSString *)key;

@end
