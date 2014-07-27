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

- (void)saveTimeForTimeID:(NSString *)timeID photos:(NSMutableArray *)photosArray;
{
    TRTimeModel *time = [self timeForTimeID:timeID];
    time.timePhotos = [NSMutableArray arrayWithArray:photosArray];
}

- (TRTimeModel *)timeForTimeID:(NSString *)timeID
{
    for (int i = 0;i < self.allTime.count;i++) {
        TRTimeModel *model = self.allTime[i];
        if ([model.timeID isEqualToString:timeID]) {
            return model;
        }
    }
    return nil;
}

@end
