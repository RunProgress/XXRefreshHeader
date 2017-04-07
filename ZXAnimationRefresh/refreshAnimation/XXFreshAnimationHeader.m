//
//  XXFreshHeader.m
//  ZXAnimationRefresh
//
//  Created by zhang on 2017/4/7.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import "XXFreshAnimationHeader.h"

#define topPointColor    [UIColor colorWithRed:90 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1.0].CGColor
#define leftPointColor   [UIColor colorWithRed:250 / 255.0 green:85 / 255.0 blue:78 / 255.0 alpha:1.0].CGColor
#define bottomPointColor [UIColor colorWithRed:92 / 255.0 green:201 / 255.0 blue:105 / 255.0 alpha:1.0].CGColor
#define rightPointColor  [UIColor colorWithRed:253 / 255.0 green:175 / 255.0 blue:75 / 255.0 alpha:1.0].CGColor

const CGFloat XXRefreshSize = 35.0f;
const CGFloat XXRefreshPointRadius = 5.0f;
const CGFloat XXRefreshMaxPullLength = 55.0f;
const CGFloat XXRefreshTransitionRang = 5.0f;

@interface XXFreshAnimationHeader ()

@property (nonatomic, weak)UIScrollView *observeScrollView;

@property (nonatomic, strong)CAShapeLayer *topPointLayer;
@property (nonatomic, strong)CAShapeLayer *leftPointLayer;
@property (nonatomic, strong)CAShapeLayer *bottomPointLayer;
@property (nonatomic, strong)CAShapeLayer *rightPointLayer;
@property (nonatomic, strong)CAShapeLayer *pointLineLayer;

@property (nonatomic, assign)CGPoint topPoint;
@property (nonatomic, assign)CGPoint leftPoint;
@property (nonatomic, assign)CGPoint bottomPoint;
@property (nonatomic, assign)CGPoint rightPoint;

@property (nonatomic, assign)CGFloat progress; // 下拉刷新的幅度

@end

@implementation XXFreshAnimationHeader

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, XXRefreshSize, XXRefreshSize)];
    if (self) {
        [self setupPointLayerAndLiner];
    }
    return self;
}

- (void)setupPointLayerAndLiner{
    [self addFourPoint];
    [self addLineBetweenPoint];
    _pointLineLayer.strokeStart = 0;
    _pointLineLayer.strokeEnd = 0;
}

// --- 初始化界面 生成shapelayer ---
- (void)addFourPoint {
    CGFloat centerPosition = XXRefreshSize / 2.0;
    
    self.topPoint = CGPointMake(centerPosition, XXRefreshPointRadius);
    self.topPointLayer = [self createPointShapeLayerByCenterPoint:_topPoint length:XXRefreshPointRadius * 2 color:topPointColor];
    [self.layer addSublayer:_topPointLayer];
    
    self.leftPoint = CGPointMake(XXRefreshPointRadius, centerPosition);
    self.leftPointLayer = [self createPointShapeLayerByCenterPoint:_leftPoint length:XXRefreshPointRadius * 2 color:leftPointColor];
    [self.layer addSublayer:_leftPointLayer];
    
    self.bottomPoint = CGPointMake(centerPosition, XXRefreshSize - XXRefreshPointRadius);
    self.bottomPointLayer = [self createPointShapeLayerByCenterPoint:_bottomPoint length:XXRefreshPointRadius * 2 color:bottomPointColor];
    [self.layer addSublayer:_bottomPointLayer];
    
    self.rightPoint = CGPointMake(XXRefreshSize - XXRefreshPointRadius, centerPosition);
    self.rightPointLayer = [self createPointShapeLayerByCenterPoint:_rightPoint length:XXRefreshPointRadius * 2 color:rightPointColor];
    [self.layer addSublayer:_rightPointLayer];
    
}

- (void)addLineBetweenPoint {
    _pointLineLayer = [CAShapeLayer layer];
    _pointLineLayer.lineJoin = kCALineJoinRound;
    _pointLineLayer.lineCap = kCALineCapRound;
    _pointLineLayer.frame = self.bounds;
    _pointLineLayer.lineWidth = XXRefreshPointRadius * 2;
    _pointLineLayer.fillColor = topPointColor;
    _pointLineLayer.strokeColor = topPointColor;
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:_topPoint];
    [linePath addLineToPoint:_leftPoint];
    [linePath moveToPoint:_leftPoint];
    [linePath addLineToPoint:_bottomPoint];
    [linePath moveToPoint:_bottomPoint];
    [linePath addLineToPoint:_rightPoint];
    [linePath moveToPoint:_rightPoint];
    [linePath addLineToPoint:_topPoint];
    _pointLineLayer.path = linePath.CGPath;
    
    [self.layer addSublayer:_pointLineLayer];
}

- (CAShapeLayer *)createPointShapeLayerByCenterPoint:(CGPoint)center
                                               length:(CGFloat)length
                                                color:(CGColorRef)color {
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    shapLayer.frame = CGRectMake(center.x - length/2, center.y - length/2, length, length);
    shapLayer.fillColor = color;
    shapLayer.strokeColor = color;
    shapLayer.lineCap = kCALineCapRound;
    shapLayer.lineJoin = kCALineJoinRound;
    shapLayer.path = [self pointShapeLayerPathWithRadius:length/2];
    return shapLayer;
}

- (CGPathRef)pointShapeLayerPathWithRadius:(CGFloat)radius {
    UIBezierPath *circleBezier = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius startAngle:0 endAngle:(2*M_PI) clockwise:YES];
    return  circleBezier.CGPath;
}

// 当视图添加到 scrollView 上的时候 添加对 srollView 的监听
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        if ([newSuperview isKindOfClass:[UIScrollView class]]) {
            
        }
    }
    else {
        @try {
            [self.observeScrollView removeObserver:self forKeyPath:@"contentOffset"];
        } @catch (NSException *exception) {
            
        } @finally {
            NSLog(@"移除观察者失败");
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
