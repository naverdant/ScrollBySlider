//
//  UIImage+Gradient.h
//  AWScrollWithSlider
//
//  Created by Perfect on 2017/11/24.
//  Copyright © 2017年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Gradient)

+ (UIImage *)imageHorizontalGradientWithSize:(CGSize)size colorset:(NSArray *)colors locations:(CGFloat [])locations;

@end
