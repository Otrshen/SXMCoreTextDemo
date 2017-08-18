//
//  MyTestView.m
//  CoreTextDemo
//
//  Created by 申铭 on 2017/8/17.
//  Copyright © 2017年 shenming. All rights reserved.
//

#import "MyTestView.h"

@implementation MyTestView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext(); // 获取绘制上下文
    
    // 翻转画布
    CGContextSetTextMatrix(context, CGAffineTransformIdentity); // 设置字形的变换矩阵为不做图形变换
    CGContextTranslateCTM(context, 0, self.bounds.size.height); // 平移方法，将画布向上平移一个屏幕高
    CGContextScaleCTM(context, 1.0, -1.0); // 缩放方法，x轴缩放系数为1，则不变，y轴缩放系数为-1，则相当于以x轴为轴旋转180度
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:@"\n这里在测试图文混排，\n我是一个富文本"];
    
    /*
     设置一个回调结构体，告诉代理该回调那些方法
     */
    CTRunDelegateCallbacks callBacks; // 创建一个回调结构体，设置相关参数
    memset(&callBacks, 0, sizeof(CTRunDelegateCallbacks)); // memset将已开辟内存空间 callbacks 的首 n 个字节的值设为值 0, 相当于对CTRunDelegateCallbacks内存空间初始化
    callBacks.version = kCTRunDelegateVersion1; // 设置回调版本，默认这个
    callBacks.getAscent = ascentCallBacks; // 设置图片顶部距离基线的距离
    callBacks.getDescent = descentCallBacks; // 设置图片底部距离基线的距离
    callBacks.getWidth = widthCallBacks; // 设置图片宽度
    
    /*
     创建一个代理
     */
    NSDictionary *dicPic = @{@"height" : @129 , @"width" : @300}; // 创建一个图片尺寸的字典，初始化代理对象需要
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callBacks, (__bridge void *)dicPic); // 创建代理
    
    
}

#pragma mark - 回调方法

static CGFloat ascentCallBacks(void *ref)
{
    return [(NSNumber *)[(__bridge NSDictionary *)ref valueForKey:@"height"] floatValue];
}

static CGFloat descentCallBacks(void * ref)
{
    return 0;
}

static CGFloat widthCallBacks(void * ref)
{
    return [(NSNumber *)[(__bridge NSDictionary *)ref valueForKey:@"width"] floatValue];
}

@end
