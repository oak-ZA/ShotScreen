//
//  ShotScreenView.m
//  ShotScreen
//
//  Created by 张奥 on 2020/1/10.
//  Copyright © 2020 张奥. All rights reserved.
//

#import "ShotScreenView.h"
#import "Masonry.h"
#define SCREEN_Width [UIScreen mainScreen].bounds.size.width
#define SCREEN_Height [UIScreen mainScreen].bounds.size.height
#define SCREEN_Width [UIScreen mainScreen].bounds.size.width
#define SCREEN_Height [UIScreen mainScreen].bounds.size.height

static float scale = 0.8;

@interface ShotScreenView()
@property (nonatomic,strong) UIImageView *shotImageView;
@end

@implementation ShotScreenView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIImageView *)shotImageView{
    if (!_shotImageView) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width * scale;
        CGFloat height = [UIScreen mainScreen].bounds.size.height *scale;
        _shotImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_Width - width)/2, 0, width, height)];
    }
    return _shotImageView;
}

+(void)showShotScreenPhoto:(UIImage *)shotImage{
    ShotScreenView *shotView = [[ShotScreenView alloc] initWithShotImage:shotImage];
    shotView.frame = CGRectMake(0, 0, SCREEN_Width, SCREEN_Height);
    shotView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:shotView];
}

-(instancetype)initWithShotImage:(UIImage *)shotImage{
    self = [super init];
    if (self) {
        self.shotImageView.image = shotImage;
        [self addSubview:self.shotImageView];
        [self shareButton];
    }
    return self;
}

-(void)shareButton{
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareShotImage) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.backgroundColor = [UIColor redColor];
    [self addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom);
        make.leading.trailing.equalTo(self);
        make.height.mas_equalTo(@50);
    }];

    [UIView animateWithDuration:0.5 animations:^{
        [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_bottom).with.offset(-50);
            make.leading.trailing.equalTo(self);
            make.height.mas_equalTo(@50);
        }];
        [self layoutIfNeeded];
    }];
    
}


-(void)shareShotImage{
    NSLog(@"分享成功");
    [self removeFromSuperview];
}

@end
