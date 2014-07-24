//
//  TRImagePicker.h
//  TimeRecord
//
//  Created by ocean tang on 14-7-23.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRImagePicker : NSObject

- (void)presentInViewController:(UIViewController *)controller;

@end

@interface TRSystemAlbumPicker : TRImagePicker

+ (instancetype)pickerWithImagePickerController:(UIImagePickerController *)imagePickerController;

@end
