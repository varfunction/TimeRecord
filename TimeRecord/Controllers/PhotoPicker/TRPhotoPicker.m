//
//  TRPhotoPicker.m
//  TimeRecord
//
//  Created by ocean tang on 14-7-24.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import "TRPhotoPicker.h"

@implementation TRPhotoPicker

- (void)showPickerInViewController:(UIViewController *)controller {}

- (void)presentInViewController:(UIViewController *)controller
{
    [self showPickerInViewController:controller];
}

@end

@interface TRSystemAlbumPicker ()

@property (nonatomic, strong) UIImagePickerController *picker;

@end

@implementation TRSystemAlbumPicker

+ (instancetype)pickerWithImagePickerController:(UIImagePickerController *)imagePickerController
{
    TRSystemAlbumPicker *picker = [[TRSystemAlbumPicker alloc] init];
    picker.picker = imagePickerController;
    return picker;
}

- (void)showPickerInViewController:(UIViewController *)controller
{
    [controller presentViewController:self.picker animated:YES completion:NULL];
}

@end