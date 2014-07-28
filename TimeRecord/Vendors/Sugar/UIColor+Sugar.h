//
//  UIColor+Sugar.h
//  TimeRecord
//
//  Created by ocean tang on 14-7-28.
//  Copyright (c) 2014年 ocean tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Sugar)

/**
 * 通过十六进制颜色字符串生成对应的UIColor对象
 *
 * 支持RGB、ARGB、RRGGBB、AARRGGBB这四种格式，前面的#不可以省略
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

/**
 * 通过int生成对应的UIColor对象, alpha 默认为1
 *
 * int颜色的生成规则为：(OxFF<<24) | (red<<16) | (green<<8) | blue
 */
+ (UIColor *)colorWithIntValue:(int)intValue;

@end
