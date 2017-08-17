//
//  OPView.m
//  CoreTextDemo
//
//  Created by 申铭 on 2017/8/17.
//  Copyright © 2017年 shenming. All rights reserved.
//

#import "OPView.h"
#import "UIImage+DWImageUtils.h"

@interface OPView ()
{
    CTFrameRef _frame;
    NSInteger _length;
    CGRect _imgFrm;
    NSMutableArray * arrText;
}
@end

@implementation OPView

//- (void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
//    CGContextTranslateCTM(context, 0, self.bounds.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddRect(path, NULL, self.bounds);
//
//    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"Hello World! 晚来风急哦啊欧奥尔良娃娃家饿哦高温金融啊文件发件佛玩案件为佛案件围殴ifAug破泰囧二恶烷融易通而我竟然公开你到时开发工具噢is工商局的疯狂购金额org就上课了发达国家"];
//    CTFramesetterRef framesetter =  CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
//    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attString length]), path, NULL);
//
//    CTFrameDraw(frame, context);
//
//    CFRelease(frame);
//    CFRelease(path);
//    CFRelease(framesetter);
//}

/** --------------------- */

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    arrText = [NSMutableArray array];
    NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc] initWithString:@"123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, attributeStr.length)];
    CTRunDelegateCallbacks callBacks;
    memset(&callBacks, 0, sizeof(CTRunDelegateCallbacks));
    callBacks.version = kCTRunDelegateVersion1;         callBacks.getAscent = ascentCallBacks;        callBacks.getDescent = descentCallBacks;        callBacks.getWidth = widthCallBacks;
    NSDictionary * dicPic = @{@"height":@90,@"width":@160};
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callBacks, (__bridge void *)dicPic);
    unichar placeHolder = 0xFFFC;
    NSString * placeHolderStr = [NSString stringWithCharacters:&placeHolder length:1];
    NSMutableAttributedString * placeHolderAttrStr =     [[NSMutableAttributedString alloc] initWithString:placeHolderStr];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)placeHolderAttrStr, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);    CFRelease(delegate);
    [attributeStr insertAttributedString:placeHolderAttrStr atIndex:300];
    NSDictionary * activeAttr = @{NSForegroundColorAttributeName:[UIColor redColor],@"click":NSStringFromSelector(@selector(click))};
    [attributeStr addAttributes:activeAttr range:NSMakeRange(100, 30)];
    
    [attributeStr addAttributes:activeAttr range:NSMakeRange(400, 100)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributeStr);
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:self.bounds];
    UIBezierPath * cirP = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 100, 200)];
    [path appendPath:cirP];
    _length = attributeStr.length;
    _frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, _length), path.CGPath, NULL);
    CTFrameDraw(_frame, context);
    
    UIImage * image = [UIImage imageNamed:@"12.jpg"];
    [self handleActiveRectWithFrame:_frame];
    CGContextDrawImage(context,_imgFrm, image.CGImage);
    
    CGContextDrawImage(context, cirP.bounds, [[UIImage imageNamed:@"12.jpg"] dw_ClipImageWithPath:cirP mode:(DWContentModeScaleAspectFill)].CGImage);
    CFRelease(_frame);
    CFRelease(frameSetter);
}

static CGFloat ascentCallBacks(void * ref)
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


-(void)handleActiveRectWithFrame:(CTFrameRef)frame
{
    NSArray * arrLines = (NSArray *)CTFrameGetLines(frame);
    NSInteger count = [arrLines count];
    CGPoint points[count];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), points);
    for (int i = 0; i < count; i ++) {
        CTLineRef line = (__bridge CTLineRef)arrLines[i];
        NSArray * arrGlyphRun = (NSArray *)CTLineGetGlyphRuns(line);
        for (int j = 0; j < arrGlyphRun.count; j ++) {
            CTRunRef run = (__bridge CTRunRef)arrGlyphRun[j];
            NSDictionary * attributes = (NSDictionary *)CTRunGetAttributes(run);
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[attributes valueForKey:(id)kCTRunDelegateAttributeName];
            CGPoint point = points[i];
            if (delegate == nil) {
                NSString * string = attributes[@"click"];
                if (string) {
                    [arrText addObject:[NSValue valueWithCGRect:[self getLocWithFrame:frame CTLine:line CTRun:run origin:point]]];
                }
                continue;
            }
            NSDictionary * metaDic = CTRunDelegateGetRefCon(delegate);
            if (![metaDic isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            _imgFrm = [self getLocWithFrame:frame CTLine:line CTRun:run origin:point];
        }
    }
}

-(CGRect)getLocWithFrame:(CTFrameRef)frame CTLine:(CTLineRef)line CTRun:(CTRunRef)run origin:(CGPoint)origin
{
    CGFloat ascent;
    CGFloat descent;
    CGRect boundsRun;
    boundsRun.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
    boundsRun.size.height = ascent + descent;
    CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
    boundsRun.origin.x = origin.x + xOffset;
    boundsRun.origin.y = origin.y - descent;
    CGPathRef path = CTFrameGetPath(frame);
    CGRect colRect = CGPathGetBoundingBox(path);
    CGRect deleteBounds = CGRectOffset(boundsRun, colRect.origin.x, colRect.origin.y);
    return deleteBounds;
}

-(CGRect)convertRectFromLoc:(CGRect)rect
{
    return CGRectMake(rect.origin.x, self.bounds.size.height - rect.origin.y - rect.size.height, rect.size.width, rect.size.height);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    CGRect imageFrmToScreen = [self convertRectFromLoc:_imgFrm];
    if (CGRectContainsPoint(imageFrmToScreen, location)) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"你点击了图片" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil] show];
        return;
    }
    [arrText enumerateObjectsUsingBlock:^(NSValue * rectV, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect textFrmToScreen = [self convertRectFromLoc:[rectV CGRectValue]];
        if (CGRectContainsPoint(textFrmToScreen, location)) {
            [self click];
            *stop = YES;
        }
    }];
}

-(void)click
{
    [[[UIAlertView alloc] initWithTitle:nil message:@"你点击了文字" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil] show];
}

/**--------- ---------------------------------------------   ---------*/

/*
 
 -(void)drawRect:(CGRect)rect
 {
 [super drawRect:rect];
 CGContextRef context = UIGraphicsGetCurrentContext();
 CGContextSetTextMatrix(context, CGAffineTransformIdentity);    CGContextTranslateCTM(context, 0, self.bounds.size.height);
 CGContextScaleCTM(context, 1.0, -1.0);
 NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc] initWithString:@"\n这里在测试图文混排，\n我是一个富文本"];
 CTRunDelegateCallbacks callBacks;
 memset(&callBacks,0,sizeof(CTRunDelegateCallbacks));
 callBacks.version = kCTRunDelegateVersion1;
 callBacks.getAscent = ascentCallBacks;
 callBacks.getDescent = descentCallBacks;
 callBacks.getWidth = widthCallBacks;
 NSDictionary * dicPic = @{@"height":@129,@"width":@300};
 CTRunDelegateRef delegate = CTRunDelegateCreate(&callBacks, (__bridge void *)dicPic);
 unichar placeHolder = 0xFFFC;
 NSString * placeHolderStr = [NSString stringWithCharacters:&placeHolder length:1];
 NSMutableAttributedString * placeHolderAttrStr = [[NSMutableAttributedString alloc] initWithString:placeHolderStr];
 CFAttributedStringSetAttribute((CFMutableAttributedStringRef)placeHolderAttrStr, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
 CFRelease(delegate);
 [attributeStr insertAttributedString:placeHolderAttrStr atIndex:12];
 CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributeStr);
 CGMutablePathRef path = CGPathCreateMutable();
 CGPathAddRect(path, NULL, self.bounds);
 NSInteger length = attributeStr.length;
 CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, length), path, NULL);
 CTFrameDraw(frame, context);
 
 UIImage * image = [UIImage imageNamed:@"12.jpg"];
 CGRect imgFrm = [self calculateImageRectWithFrame:frame];
 CGContextDrawImage(context,imgFrm, image.CGImage);
 CFRelease(frame);
 CFRelease(path);
 CFRelease(frameSetter);
 }
 static CGFloat ascentCallBacks(void * ref)
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
 
 
 -(CGRect)calculateImageRectWithFrame:(CTFrameRef)frame
 {
 NSArray * arrLines = (NSArray *)CTFrameGetLines(frame);
 NSInteger count = [arrLines count];
 CGPoint points[count];
 CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), points);
 for (int i = 0; i < count; i ++) {
 CTLineRef line = (__bridge CTLineRef)arrLines[i];
 NSArray * arrGlyphRun = (NSArray *)CTLineGetGlyphRuns(line);
 for (int j = 0; j < arrGlyphRun.count; j ++) {
 CTRunRef run = (__bridge CTRunRef)arrGlyphRun[j];
 NSDictionary * attributes = (NSDictionary *)CTRunGetAttributes(run);            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[attributes valueForKey:(id)kCTRunDelegateAttributeName];
 if (delegate == nil) {
 continue;
 }
 NSDictionary * dic = CTRunDelegateGetRefCon(delegate);
 if (![dic isKindOfClass:[NSDictionary class]]) {
 continue;
 }
 CGPoint point = points[i];
 CGFloat ascent;
 CGFloat descent;
 CGRect boundsRun;
 boundsRun.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
 boundsRun.size.height = ascent + descent;
 CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
 boundsRun.origin.x = point.x + xOffset;
 boundsRun.origin.y = point.y - descent;
 CGPathRef path = CTFrameGetPath(frame);
 CGRect colRect = CGPathGetBoundingBox(path);
 CGRect imageBounds = CGRectOffset(boundsRun, colRect.origin.x, colRect.origin.y);
 return imageBounds;
 }
 }
 return CGRectZero;
 }
 */


/**--------- ---------------------------------------------   ---------*/
/*
 -(void)drawRect:(CGRect)rect
 {
 [super drawRect:rect];
 
 CGContextRef context = UIGraphicsGetCurrentContext();
 
 CGContextSetTextMatrix(context, CGAffineTransformIdentity);    CGContextTranslateCTM(context, 0, self.bounds.size.height);
 CGContextScaleCTM(context, 1.0, -1.0);
 
 NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc] initWithString:@"\n这里在测试图文混排，\n我是一个富文本"];
 
 CTRunDelegateCallbacks callBacks;
 callBacks.version = kCTRunDelegateVersion1;
 callBacks.getAscent = ascentCallBacks;
 callBacks.getDescent = descentCallBacks;
 callBacks.getWidth = widthCallBacks;
 
 NSDictionary * dicPic = @{@"height":@200,@"width":@217};
 CTRunDelegateRef delegate = CTRunDelegateCreate(& callBacks, (__bridge void *)dicPic);
 
 unichar placeHolder = 0xFFFC; // 创建空白字符
 NSString * placeHolderStr = [NSString stringWithCharacters:&placeHolder length:1]; // 以空白字符生成字符串
 NSMutableAttributedString * placeHolderAttrStr = [[NSMutableAttributedString alloc] initWithString:placeHolderStr]; // 用字符串初始化占位符的富文本
 CFAttributedStringSetAttribute((CFMutableAttributedStringRef)placeHolderAttrStr, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate); // 给字符串中的范围中字符串设置代理
 CFRelease(delegate); // 释放（__bridge进行C与OC数据类型的转换，C为非ARC，需要手动管理）
 
 [attributeStr insertAttributedString:placeHolderAttrStr atIndex:12]; // 将占位符插入原富文本
 
 CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributeStr);// 一个frame的工厂，负责生成frame
 CGMutablePathRef path = CGPathCreateMutable(); // 创建绘制区域
 CGPathAddRect(path, NULL, self.bounds); // 添加绘制尺寸
 NSInteger length = attributeStr.length;
 CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, length), path, NULL); // 工厂根据绘制区域及富文本（可选范围，多次设置）设置frame
 CTFrameDraw(frame, context); // 根据frame绘制文字
 
 UIImage * image = [UIImage imageNamed:@"12.jpg"];
 CGRect imgFrm = [self calculateImageRectWithFrame:frame];
 CGContextDrawImage(context, imgFrm, image.CGImage); // 绘制图片
 
 CFRelease(frame);
 CFRelease(path);
 //    CFRelease(frameSetter);
 }
 
 static CGFloat ascentCallBacks(void * ref)
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
 
 
 -(CGRect)calculateImageRectWithFrame:(CTFrameRef)frame
 {
 NSArray * arrLines = (NSArray *)CTFrameGetLines(frame); // 根据frame获取需要绘制的线的数组
 NSInteger count = [arrLines count]; // 获取线的数量
 CGPoint points[count]; // 建立起点的数组（cgpoint类型为结构体，故用C语言的数组）
 CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), points); // 获取起点
 for (int i = 0; i < count; i ++) { // 遍历线的数组
 CTLineRef line = (__bridge CTLineRef)arrLines[i];
 NSArray * arrGlyphRun = (NSArray *)CTLineGetGlyphRuns(line); // 获取GlyphRun数组（GlyphRun：高效的字符绘制方案）
 for (int j = 0; j < arrGlyphRun.count; j ++) { // 遍历CTRun数组
 CTRunRef run = (__bridge CTRunRef)arrGlyphRun[j]; // 获取CTRun
 NSDictionary * attributes = (NSDictionary *)CTRunGetAttributes(run); // 获取CTRun的属性
 CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[attributes valueForKey:(id)kCTRunDelegateAttributeName]; // 获取代理
 if (delegate == nil) {
 continue;
 }
 NSDictionary * dic = CTRunDelegateGetRefCon(delegate); // 判断代理字典
 if (![dic isKindOfClass:[NSDictionary class]]) {
 continue;
 }
 CGPoint point = points[i]; // 获取一个起点
 CGFloat ascent; // 获取上距
 CGFloat descent; // 获取下距
 CGRect boundsRun; // 创建一个frame
 boundsRun.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
 boundsRun.size.height = ascent + descent; // 取得高
 CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL); // 获取x偏移量
 boundsRun.origin.x = point.x + xOffset; // point是行起点位置，加上每个字的偏移量得到每个字的x
 boundsRun.origin.y = point.y - descent; // 计算原点
 CGPathRef path = CTFrameGetPath(frame); // 获取绘制区域
 CGRect colRect = CGPathGetBoundingBox(path); // 获取剪裁区域边框
 CGRect imageBounds = CGRectOffset(boundsRun, colRect.origin.x, colRect.origin.y);
 return imageBounds;
 }
 }
 return CGRectZero;
 }
 */

@end
