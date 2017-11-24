//
//  ViewController.m
//  AWScrollWithSlider
//
//  Created by Perfect on 2017/11/24.
//  Copyright © 2017年 Alex. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Gradient.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIScrollView *sceneScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *labelScrollView;
@property (nonatomic, strong) NSArray *scenes;
@property (nonatomic, strong) NSArray *labels;
@property (nonatomic) CGSize mainSreenSize;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Using self.view.bounds might not get the acual size in viewDidLoad.
    self.mainSreenSize = [UIScreen mainScreen].bounds.size;

    [self sliderSetting];
    [self sceneScrollViewSetting];
    [self labelScrollViewSetting];
    
    // Make horizontal animation by changing its frame instead of setting contentOffset of scrollview,
    [UIView animateWithDuration:12.0 animations:^{
        CGRect sceneScrollViewFrame = self.sceneScrollView.frame;
        sceneScrollViewFrame.origin.x = self.mainSreenSize.width - sceneScrollViewFrame.size.width;
        self.sceneScrollView.frame = sceneScrollViewFrame;
    }];
}

- (void)sliderSetting {
    self.slider.value = 0;
    self.slider.maximumTrackTintColor = [UIColor clearColor];
    self.slider.minimumTrackTintColor = [UIColor yellowColor];
    // Make slider vertical.
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI_2);
    self.slider.transform = trans;
}

- (void)sceneScrollViewSetting {
    /*
     1. To make the images not transformed and the height equals to screen height, the width/height ratio of image is needed.
     2. Changing image size to fit the screen height with ratio unchanged, which means image width is much wider than screen width.
     3. The width of scrollView's contentSize is equal to the width of the image, so that sceneScrollView cannot scroll in horizontal direction.
     4. The height of scrollView's contentSize is equal to the height of mainScreen times count of images.
     */
    
    UIImage *sceneImage = [self.scenes firstObject];
    float imageRatio = sceneImage.size.width / sceneImage.size.height;
    float sceneScrollViewWidth = imageRatio * self.mainSreenSize.height;
    
    self.sceneScrollView.contentSize = CGSizeMake(sceneScrollViewWidth, self.mainSreenSize.height * self.scenes.count);
    self.sceneScrollView.frame = CGRectMake(0, 0, sceneScrollViewWidth, self.mainSreenSize.height);
    
    for(int i = 0; i < self.scenes.count; i++) {
        UIImageView *sceneImageView = [[UIImageView alloc] initWithImage:self.scenes[i]];
        sceneImageView.frame = CGRectMake(0, self.mainSreenSize.height * i, sceneScrollViewWidth, self.mainSreenSize.height);

        [self.sceneScrollView addSubview:sceneImageView];
    }
    
    // Scrolling in scrollView controled by slider only.
    self.sceneScrollView.userInteractionEnabled = NO;
}

- (void)labelScrollViewSetting {
    self.labelScrollView.contentSize = CGSizeMake(self.mainSreenSize.width, self.mainSreenSize.height * self.labels.count);
    for(int i = 0; i < self.labels.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.mainSreenSize.height * i, self.mainSreenSize.width, 50)];
        label.text = self.labels[i];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:20 + i * 2];
        [self.labelScrollView addSubview:label];
    }
    self.labelScrollView.userInteractionEnabled = NO;
}

#pragma mark - Action

- (IBAction)valueChanged:(UISlider *)sender {
    float sceneScrollViewOffsetY = sender.value * (self.sceneScrollView.contentSize.height - self.mainSreenSize.height);
    [self.sceneScrollView setContentOffset:CGPointMake(0, sceneScrollViewOffsetY) animated:NO];
    
    [self.labelScrollView setContentOffset:CGPointMake(0, sceneScrollViewOffsetY) animated:NO];
}

#pragma mark - Data preparing

- (NSArray *)scenes {
    if(!_scenes) {
        UIImage *blue = [UIImage imageNamed:@"blue"];
        UIImage *brown = [UIImage imageNamed:@"brown"];
        UIImage *light = [UIImage imageNamed:@"light"];
        UIImage *dark = [UIImage imageNamed:@"dark"];
        _scenes = @[blue, brown, light, dark];
    }
    return _scenes;
}

- (NSArray *)labels {
    if(!_labels) {
        _labels = @[@"Taipei, Taiwan", @"Taipei, Taiwan", @"Taipei, Taiwan", @"Taipei, Taiwan"];
    }
    return _labels;
}

@end
