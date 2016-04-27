//
//  UIImage+image.m
//  截屏
//
//  Created by 阿仁欧巴 on 16/4/16.
//  Copyright © 2016年 aren. All rights reserved.
//

#import "UIImage+image.h"

@implementation UIImage (image)

//画圆截图
+ (UIImage *)imageWithClipImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color
{
    //图片的宽高
    CGFloat imageWH = image.size.width;
    //设置圆环的宽度和高度
    CGFloat border = borderWidth;
    //圆形的宽高
    CGFloat ovalWH = imageWH + 2 * border;
    
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ovalWH, ovalWH), NO, 0);
    
    //2.画大圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalWH, ovalWH)];
    [color set];
    [path fill];
    
    //3.设置裁剪的区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(border, border, imageWH, imageWH)];
    [clipPath addClip];
    
    //4.绘制图片
    [image drawAtPoint:CGPointMake(border, border)];
    //5.获取图片
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    //6.关闭上下文
    UIGraphicsEndImageContext();
    
    return clipImage;
    
}

//控件截图
+ (UIImage *)imageWithCapture:(UIView *)view
{
    //1.开启位图上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    //2.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //3.把控件上的图层渲染到上下文 layer 只能渲染
    [view.layer renderInContext:ctx];
    //4.生成一张图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭上下文
    UIGraphicsEndImageContext();
    return image;
    
    
}



@end
