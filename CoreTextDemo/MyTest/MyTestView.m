//
//  MyTestView.m
//  CoreTextDemo
//
//  Created by 申铭 on 2017/8/17.
//  Copyright © 2017年 shenming. All rights reserved.
//

#import "MyTestView.h"

@interface MyTestView ()

@property (nonatomic, assign) CGRect imageFrame;
@end

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
    
    /*
     图片插入
     */
    unichar placeHolder = 0xFFFC; // 创建空白字符
    NSString *placeHolderStr = [NSString stringWithCharacters:&placeHolder length:1]; // 为空白字符生成字符串
    NSMutableAttributedString *placeHolderAttrStr = [[NSMutableAttributedString alloc] initWithString:placeHolderStr]; // 用字符串初始化占位符的富文本
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)placeHolderAttrStr, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate); // 给字符串中的范围中字符串设置代理
    CFRelease(delegate); // 释放（__bridge进行C与OC数据类型的转换，C为非ARC，需要手动管理）
    
    [attributeStr insertAttributedString:placeHolderAttrStr atIndex:14]; // 将占位符插入原富文本
    
    /*
     绘制文本
     */
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributeStr); // 一个frame的工厂，负责生成frame
    CGMutablePathRef path = CGPathCreateMutable(); // 创建绘制区域
    CGPathAddRect(path, NULL, self.bounds); // 添加绘制尺寸
    NSInteger length = attributeStr.length;
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, length), path, NULL); // 工厂根据绘制区域及富文本（可选范围，多次设置）设置frame
    CTFrameDraw(frame, context); // 根据frame绘制文字
    
    /*
     绘制图片
     */
    UIImage *image = [UIImage imageNamed:@"12.jpg"];
    CGRect imgFrm = [self calculateImageRectWithFrame:frame];
    CGContextDrawImage(context,imgFrm, image.CGImage);
    
    CFRelease(frame);
    CFRelease(path);
    CFRelease(frameSetter);
}

// 点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [self systemPointFromScreenPoint:[touch locationInView:self]]; // 获取点击位置的系统坐标
    if (CGRectContainsPoint(self.imageFrame, location)) { //检查是否点击在图片上，如果在，优先响应图片事件
        NSLog(@"点击了图片");
        return;
    }
    
    
}


#pragma mark - 辅助方法

// 计算图片的frame
-(CGRect)calculateImageRectWithFrame:(CTFrameRef)frame
{
    NSArray *arrLines = (NSArray *)CTFrameGetLines(frame); // 根据frame获取需要绘制的线的数组
    NSInteger count = [arrLines count]; // 获取线的数量
    CGPoint points[count]; // 建立起点的数组（cgpoint类型为结构体，故用C语言的数组）
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), points); // 获取起点
    for (int i = 0; i < count; i ++) { // 遍历线的数组
        CTLineRef line = (__bridge CTLineRef)arrLines[i];
        NSArray *arrGlyphRun = (NSArray *)CTLineGetGlyphRuns(line); // 获取GlyphRun数组（GlyphRun：高效的字符绘制方案）
        for (int j = 0; j < arrGlyphRun.count; j ++) { // 遍历CTRun数组
            CTRunRef run = (__bridge CTRunRef)arrGlyphRun[j]; // 获取CTRun
            NSDictionary * attributes = (NSDictionary *)CTRunGetAttributes(run); // 获取CTRun的属性
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[attributes valueForKey:(id)kCTRunDelegateAttributeName]; // 获取代理
            if (delegate == nil) {
                continue;
            }
            NSDictionary * dic = CTRunDelegateGetRefCon(delegate);
            if (![dic isKindOfClass:[NSDictionary class]]) { // 判断代理字典
                continue;
            }
            CGPoint point = points[i]; // 获取一个起点
            CGFloat ascent; // 获取上距
            CGFloat descent; // 获取下距
            CGRect boundsRun; // 创建一个frame
            boundsRun.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
            boundsRun.size.height = ascent + descent; // 取得高
            CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL); //获取x偏移量
            boundsRun.origin.x = point.x + xOffset; // point是行起点位置，加上每个字的偏移量得到每个字的x
            boundsRun.origin.y = point.y - descent; // 计算原点
            CGPathRef path = CTFrameGetPath(frame); // 获取绘制区域
            CGRect colRect = CGPathGetBoundingBox(path); // 获取剪裁区域边框
            CGRect imageBounds = CGRectOffset(boundsRun, colRect.origin.x, colRect.origin.y);
            self.imageFrame = imageBounds;
            return imageBounds;
        }
    }
    return CGRectZero;
}

/* 坐标转换,将屏幕坐标转换为系统坐标 */
-(CGPoint)systemPointFromScreenPoint:(CGPoint)origin
{
    return CGPointMake(origin.x, self.bounds.size.height - origin.y);
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
