//
//  TRTimeManager.m
//  TimeRecord
//
//  Created by ocean tang on 14-7-24.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import "TRTimeManager.h"

@implementation TRTimeManager

+ (instancetype)sharedInstance
{
    static TRTimeManager *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TRTimeManager alloc] init];
        instance.allTime = [NSMutableArray array];
    });
    
    return instance;
}

- (TRTimeModel *)createEmptyTime
{
    TRTimePhotoModel *homePhoto = [[TRTimePhotoModel alloc] init];
    homePhoto.photoTitle = @"hello time!";
    
    TRTimeModel *timeModel = [[TRTimeModel alloc] init];
    timeModel.timeID = @"1";
    timeModel.timeHomePhoto = homePhoto;
    timeModel.timePhotos = [NSMutableArray array];
    
    [self.allTime insertObject:timeModel atIndex:0];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NAME_CREATE_TIME_COMPLETE
                                                        object:self
                                                      userInfo:nil];
    
    return timeModel;
}

@end
