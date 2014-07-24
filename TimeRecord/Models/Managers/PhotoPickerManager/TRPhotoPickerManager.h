//
//  TRPhotoPickerManager.h
//  TimeRecord
//
//  Created by ocean tang on 14-7-24.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRTimeModel.h"
#import "TRTimePhotoModel.h"

@interface TRPhotoPickerManager : NSObject

- (void)saveSystemAlbumImage:(NSURL *)url;

@end
