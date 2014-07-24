//
//  TRPhotoPickerDelegate.m
//  TimeRecord
//
//  Created by ocean tang on 14-7-24.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import "TRPhotoPickerDelegate.h"
@import AssetsLibrary;
@import CoreLocation;

@implementation TRPhotoPickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"info UIImagePickerControllerReferenceURL= %@", info);
    [picker dismissViewControllerAnimated:YES completion:NULL];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSURL *url = [info objectForKey:UIImagePickerControllerReferenceURL];
    NSDate *date = [NSDate date];
    [[[ALAssetsLibrary alloc] init] assetForURL:url resultBlock:^(ALAsset *asset) {
//        date = [asset valueForProperty:ALAssetPropertyDate];

        CLLocation *location = [asset valueForProperty:ALAssetPropertyLocation];
        if (location) {
            [[[CLGeocoder alloc] init] reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NAME_PICK_PHOTO_COMPLETE object:self userInfo:@{NOTIFICATION_USERINFO_PICK_PHOTO: image,NOTIFICATION_USERINFO_PICK_PHOTO_LOCATION: placemarks, NOTIFICATION_USERINFO_PICK_PHOTO_URL:url }];
            }];
        }
        NSLog(@"location = %@", location);
        NSLog(@"date = %@", date);
        
//        ALAsset im
    } failureBlock:^(NSError *error) {
        
    }];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NAME_PICK_PHOTO_COMPLETE object:self userInfo:@{NOTIFICATION_USERINFO_PICK_PHOTO: image, NOTIFICATION_USERINFO_PICK_PHOTO_URL:url, NOTIFICATION_USERINFO_PICK_PHOTO_DATE: date }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
