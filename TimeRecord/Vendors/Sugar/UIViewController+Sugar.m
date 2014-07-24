//
//  UIViewController+Sugar.m
//  TimeRecord
//
//  Created by ocean tang on 14-7-23.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import "UIViewController+Sugar.h"

@implementation UIViewController (Sugar)

+ (instancetype)instantiate
{
    return [[self alloc] initWithNibName:nil bundle:nil];
}

@end
