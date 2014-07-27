//
//  TRPhotoBrowserDelegate.h
//  TimeRecord
//
//  Created by ocean tang on 14-7-24.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MWPhotoBrowser.h>

@interface TRPhotoBrowserDelegate : NSObject <MWPhotoBrowserDelegate>

// MWPhoto
@property (strong, nonatomic) NSMutableArray *photos;

@end
