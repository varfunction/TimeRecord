//
//  TRTimeEditManager.h
//  TimeRecord
//
//  Created by ocean tang on 14-7-25.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRTimeEditManager : NSObject

// TRTimePhotoModel
@property (nonatomic, strong) NSMutableArray *editPhotos;

+ (instancetype)sharedInstance;

@end
