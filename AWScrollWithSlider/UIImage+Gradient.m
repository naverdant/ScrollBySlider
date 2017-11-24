//
//  UIImage+Gradient.m
//  AWScrollWithSlider
//
//  Created by Perfect on 2017/11/24.
//  Copyright © 2017年 Alex. All rights reserved.
//

#import "UIImage+Gradient.h"

@implementation UIImage (Gradient)

+ (UIImage *)imageHorizontalGradientWithSize:(CGSize)size colorset:(NSArray *)colors locations:(CGFloat [])locations
{
    UIGraphicsBeginImageContext(size);
    
    // 建立一個 RGB 的顏色空間
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSMutableArray *gradientColors = [NSMutableArray array];;
    for (UIColor *color in colors) {
        if ([color isKindOfClass:[UIColor class]]) {
            [gradientColors addObject:(id)color.CGColor];
        }
    }
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)gradientColors, locations);
    
    // 建立漸層的起點與終點
    CGPoint beginPoint = CGPointMake(0, size.height / 2);
    CGPoint endPoint = CGPointMake(size.width, size.height / 2);
    
    CGContextDrawLinearGradient(context, gradient, beginPoint, endPoint, 0);
    CGContextSaveGState(context);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 結束 context，並且釋放記憶體
    UIGraphicsEndImageContext();
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    
    return image;
}

@end
