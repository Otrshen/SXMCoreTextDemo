//
//  CoreTextDemo-Prefix.h
//  CoreTextDemo
//
//  Created by 申铭 on 2017/8/15.
//  Copyright © 2017年 shenming. All rights reserved.
//

#ifndef CoreTextDemo_Prefix_h
#define CoreTextDemo_Prefix_h

#ifdef __OBJC__
    #import <UIKit/UIKit.h>
    #import <Foundation/Foundation.h>
    #import "CoreText/CoreText.h"
    #import "UIView+frameAdjust.h"
#endif

#ifdef DEBUG
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define debugLog(...)
#define debugMethod()
#endif

#define RGB(A, B, C)    [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:1.0]

#endif /* CoreTextDemo_Prefix_h */
