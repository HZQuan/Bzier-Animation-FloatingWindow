//
//  FloatingWindow.h
//  FloatingWindwoAmination
//
//  Created by huangzengquan on 16/5/25.
//  Copyright © 2016年 huangzengquan. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FloatingWindowTouchDelegate <NSObject>
//悬浮窗点击事件
- (void)assistiveTocuhs;
@end

@interface FloatingWindow : UIWindow
{
    UIImageView *_imageView;
}
@property(nonatomic ,assign)NSInteger time;
@property(nonatomic ,assign)BOOL isShowMenu;
@property(nonatomic ,strong)UIImage *showImage;
@property(nonatomic ,strong)UIImageView *showImageView;
@property(nonatomic ,assign)CGRect startFrame;
@property(nonatomic ,assign)BOOL isCannotTouch;


@property(nonatomic ,strong)id<FloatingWindowTouchDelegate> floatDelegate;
- (id)initWithFrame:(CGRect)frame imageName:(NSString*)name;
- (void)close;
- (void)startWithTime:(NSInteger) time presentview:(UIView *)presentView inRect:(CGRect) rect;
- (UIImage *)clipcircleImageFromView:(UIView *)view inRect:(CGRect) frame;
@end




