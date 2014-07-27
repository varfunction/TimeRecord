//
//  TRPhotoPicker.h
//  TimeRecord
//
//  Created by ocean tang on 14-7-24.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TRPhotoPicker : NSObject

- (void)presentInViewController:(UIViewController *)controller;

@end

@interface TRSystemAlbumPicker : TRPhotoPicker

+ (instancetype)pickerWithImagePickerController:(UIImagePickerController *)imagePickerController;

@end

