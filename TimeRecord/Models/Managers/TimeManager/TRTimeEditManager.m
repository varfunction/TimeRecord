//
//  TRTimeEditManager.m
//  TimeRecord
//
//  Created by ocean tang on 14-7-25.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import "TRTimeEditManager.h"

@implementation TRTimeEditManager

+ (instancetype)sharedInstance
{
    static TRTimeEditManager *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TRTimeEditManager alloc] init];
        instance.editPhotos = [NSMutableArray array];
    });
    
    return instance;
}

@end
