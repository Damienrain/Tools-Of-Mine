//
//  UIImage+image.h
//  截屏
//
//  Created by 阿仁欧巴 on 16/4/16.
//  Copyright © 2016年 aren. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
    实现圆形裁剪
    实现控件裁剪
 */

@interface UIImage (image)

//圆形裁剪
+ (UIImage *)imageWithClipImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color;

//控件截屏
+ (UIImage *)imageWithCapture:(UIView *)view;

    





@end
