//
//  ViewController.m
//  WHC_GestureUnlockScreenDemo
//
//  Created by 吴海超 on 15/6/18.
//  Copyright (c) 2015年 吴海超. All rights reserved.
//

/*
 *  qq:712641411
 *  iOSqq群:302157745
 *  gitHub:https://github.com/netyouli
 *  csdn:http://blog.csdn.net/windwhc/article/category/3117381
 */

#import "ViewController.h"
#import "WHC_GestureUnlockScreenVC.h"
#import "GridView.h"
#define viewW 20
@interface ViewController (){
    WHC_GestureUnlockScreenVC  * vc;
    UIButton *_centerButton;
    UIButton *_preButton;
    NSInteger _buttonIndex;
    UIPanGestureRecognizer *_selectPanGestureRecognizer;
    BOOL _isLeftTop;
    BOOL _isRightTop;
    BOOL _isLeftDown;
    BOOL _isRightDown;
    BOOL _isAlwaysLeft;
    
    BOOL _fromLeft;
    BOOL _fromRight;
    BOOL _fromTop;
    BOOL _fromBottom;
    UIButton *_oneButton;
    UIButton *_twoButton;
    UIButton *_threeButton;
    UIButton *_fourButton;
    UIButton *_fiveButton;
    UIButton *_sixButton;
    UIButton *_sevenButton;
    UIButton *_eightButton;
    UIButton *_nineButton;
    UIButton *_tenButton;
}
@property (nonatomic , strong)IBOutlet UIButton * btn1;     //设置数字解锁按钮
@property (nonatomic , strong)IBOutlet UIButton * btn2;     //设置手势路径解锁按钮

@property (nonatomic , strong)IBOutlet UIButton * btn3;     //修改手势密码按钮
@property (nonatomic , strong)IBOutlet UIButton * btn4;     //删除手势密码锁

@property (strong, nonatomic) IBOutlet GridView *backgroundView;
@property (weak, nonatomic) UIButton *selectPreButton;
@property (weak, nonatomic) UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (strong, nonatomic) CAShapeLayer *lineLayer;
@property (strong, nonatomic) NSMutableArray *pointsButtons;
@end

@implementation ViewController

- (NSMutableArray *)pointsButtons{
    
    if (!_pointsButtons) {
        _pointsButtons = [NSMutableArray array];
    }
    return _pointsButtons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"WHC";
    _btn1.layer.cornerRadius = 10;
    _btn2.layer.cornerRadius = 10;
    _btn3.layer.cornerRadius = 10;
    _btn4.layer.cornerRadius = 10;
    _buttonIndex = 1;
    _isLeftTop = NO;
    _isRightTop = NO;
    _isLeftDown = NO;
    _isRightDown = NO;
    _isAlwaysLeft = NO;
    
    _fromLeft = NO;
    _fromRight = NO;
    _fromTop = NO;
    _fromBottom = NO;
    
    self.backgroundView.backgroundColor = [UIColor grayColor];
    _centerButton = [[UIButton alloc] init];
    _centerButton.backgroundColor = [UIColor whiteColor];
    _centerButton.width = viewW;
    _centerButton.height = viewW;
    _centerButton.x = 0.5*(self.backgroundView.width - _centerButton.width);
    _centerButton.y = 0.5*(self.backgroundView.height - _centerButton.height);
    _centerButton.layer.cornerRadius = 10;
    _centerButton.layer.masksToBounds = YES;
    [self.backgroundView addSubview:_centerButton];
    [self.pointsButtons addObject:_centerButton];
    [self setUpButtons];
}

-(void)doMoveAction:(UIPanGestureRecognizer *)recognizer{
    
    
    // Figure out where the user is trying to drag the view.
    
    CGPoint translation = [recognizer translationInView:self.view];
    CGPoint newCenter = CGPointMake(recognizer.view.center.x+ translation.x,
                                    recognizer.view.center.y + translation.y);
    //    限制屏幕范围：
    newCenter.y = MAX(recognizer.view.frame.size.height/2-0.5*viewW, newCenter.y);
    newCenter.y = MIN(self.backgroundView.frame.size.height+0.5*viewW - recognizer.view.frame.size.height/2, newCenter.y);
    newCenter.x = MAX(recognizer.view.frame.size.width/2-0.5*viewW, newCenter.x);
    newCenter.x = MIN(self.backgroundView.frame.size.width - recognizer.view.frame.size.width/2+0.5*viewW,newCenter.x);
    recognizer.view.center = newCenter;
    [recognizer setTranslation:CGPointZero inView:self.backgroundView];
    self.locationLabel.text = [NSString stringWithFormat:@"选中位置:(%.1f,%.1f)",self.selectButton.centerX,self.selectButton.centerY];
    [self linedraw:_preButton isMove:YES];
    
}

- (IBAction)addBtnClick:(UIButton *)sender {
    
    
    [self setUpButtons];
    
}

- (void)setUpButtons{
    _buttonIndex ++;
    
    if (_buttonIndex == 10) {
        self.addButton.enabled = NO;
    }
    
    CGFloat bottomLimit = self.backgroundView.height - viewW;
    CGFloat rightLimit = self.backgroundView.width - viewW;
    
    CGFloat midBackgroundH = 0.5*self.backgroundView.height;
    CGFloat midBackgroundW = 0.5*self.backgroundView.width;
    CGFloat compareValue = 0.5*viewW;
    
    _preButton = [[UIButton alloc] init];
    if (2 == _buttonIndex) {
        _preButton = _centerButton;
    }else{
        _preButton = self.selectButton;
    }
    
    CGFloat preButtonMaxX = CGRectGetMaxX(_preButton.frame);
    CGFloat preButtonMaxY = CGRectGetMaxY(_preButton.frame);
    CGFloat preButtonMinX = CGRectGetMinX(_preButton.frame);
    CGFloat preButtonMinY = CGRectGetMinY(_preButton.frame);
    CGFloat preButtonCenterX = _preButton.centerX;
    CGFloat preButtonCenterY = _preButton.centerY;
    
    UIButton *tempButton = [[UIButton alloc] init];
    tempButton.backgroundColor = [UIColor whiteColor];
    tempButton.width = viewW;
    tempButton.height = viewW;
    
    if (preButtonCenterY <= midBackgroundH) {
        
        
        if (preButtonCenterY<viewW && preButtonCenterX > rightLimit) {
            tempButton.x = preButtonMinX - viewW - 1;
            tempButton.y = preButtonMinY;
        }else{
            tempButton.x = preButtonMinX;
            tempButton.y = preButtonMinY - viewW - 1;
        }
    }else if (preButtonCenterY > midBackgroundH){
        tempButton.x = preButtonMinX;
        tempButton.y = preButtonMinY + viewW + 1;
    }
    
    
    
    
//    CGFloat selectButtonMaxX = CGRectGetMaxX(self.selectButton.frame);
//    CGFloat selectButtonMaxY = CGRectGetMaxY(self.selectButton.frame);
//    CGFloat selectButtonMinX = CGRectGetMinX(self.selectButton.frame);
//    CGFloat selectButtonMinY = CGRectGetMinY(self.selectButton.frame);
//    CGFloat selectButtonCenterX = self.selectButton.centerX;
//    CGFloat selectButtonCenterY = self.selectButton.centerY;


//    NSLog(@"%f--%f",selectButtonMinY,midBackgroundH);
    
    
    
    if (preButtonCenterX<viewW && preButtonCenterY<viewW) {
        [self selectButtonTurnRight:tempButton];
    }else if (preButtonCenterX<rightLimit && preButtonCenterY<viewW){
        [self selectButtonTurnRight:tempButton];
    }else if (preButtonCenterX>rightLimit && preButtonCenterY<viewW){
        _isRightTop = YES;
        if (_fromBottom) {
            [self selectButtonTurnLeft:tempButton];
        }else{
            [self selectButtonTurnBottom:tempButton];
        }
        
    }else if (preButtonCenterX>rightLimit && preButtonCenterY>bottomLimit){//右下
        _isRightDown = YES;
        
        
    }else if (preButtonCenterX>rightLimit && preButtonCenterY<viewW){
        _isAlwaysLeft = YES;
        [self selectButtonTurnLeft:tempButton];
    }else if (preButtonCenterX>viewW && preButtonCenterY>bottomLimit){
        
        [self selectButtonTurnRight:tempButton];
    }else if (preButtonCenterX<viewW && preButtonCenterY>bottomLimit){
        
        [self selectButtonTurnRight:tempButton];
    }
    
//    if (selectButtonCenterX<viewW && selectButtonCenterY<viewW) {
//        [self selectButtonTurnRight:tempButton];
//    }else if (selectButtonCenterX<rightLimit && selectButtonCenterY<viewW){
//        [self selectButtonTurnRight:tempButton];
//    }else if (selectButtonCenterX>rightLimit && selectButtonCenterY<viewW){
//        _isRightTop = YES;
//        [self selectButtonTurnBottom:tempButton];
//    }else if (selectButtonCenterX>rightLimit && selectButtonCenterY>bottomLimit){
//        _isRightDown = YES;
//        [self selectButtonTurnBottom:tempButton];
//    }else if (selectButtonCenterX>rightLimit && selectButtonCenterY>viewW){
//        _isAlwaysLeft = YES;
//        [self selectButtonTurnLeft:tempButton];
//    }

    if(_isRightTop){
        [self selectButtonTurnBottom:tempButton];
    }
    if(_isRightDown){
//        [self selectButtonTurnLeft:tempButton];
//        [self selectButtonTurnTop:tempButton];
        if (_fromTop) {
            [self selectButtonTurnLeft:tempButton];
        }else {
            [self selectButtonTurnTop:tempButton];
        }
    }
    if (_isAlwaysLeft) {
        [self selectButtonTurnLeft:tempButton];
    }
    if (10 == _buttonIndex) {
        _isLeftTop = NO;
        _isRightTop = NO;
        _isLeftDown = NO;
        _isRightDown = NO;
        _isAlwaysLeft = NO;
    }
    tempButton.layer.cornerRadius = 10;
    tempButton.layer.masksToBounds = YES;
    tempButton.userInteractionEnabled = YES;
    [tempButton setTitle:[NSString stringWithFormat:@"%ld",(long)_buttonIndex] forState:UIControlStateNormal];
    [tempButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    tempButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    tempButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.backgroundView addSubview:tempButton];
    
    self.selectButton = tempButton;
    if (2 == _buttonIndex) {
        _twoButton = tempButton;
    }else if (3 == _buttonIndex){
        _threeButton = tempButton;
    }else if (4 == _buttonIndex){
        _fourButton = tempButton;
    }else if (5 == _buttonIndex){
        _fiveButton = tempButton;
    }else if (6 == _buttonIndex){
        _sixButton = tempButton;
    }else if (7 == _buttonIndex){
        _sevenButton = tempButton;
    }else if (8 == _buttonIndex){
        _eightButton = tempButton;
    }else if (9 == _buttonIndex){
        _nineButton = tempButton;
    }else if (10 == _buttonIndex){
        _tenButton = tempButton;
    }
    
    [tempButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    if (2 == _buttonIndex) {
        [self selectButtonClick:tempButton];
    }

    [self linedraw:_preButton isMove:NO];
}

- (void)selectButtonClick:(UIButton *)selectButton{
    for (UIButton *tempButton in self.pointsButtons) {
        if (tempButton.selected) {
            tempButton.selected = NO;
        }
        NSLog(@"selectButtonClick>> %@ -- %d",tempButton,tempButton.selected);
    }
    self.selectButton = selectButton;
    [self.pointsButtons addObject:selectButton];
    [selectButton setBackgroundColor:[UIColor blueColor]];
    
    UIPanGestureRecognizer *selectPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doMoveAction:)];
    [self.selectButton addGestureRecognizer:selectPanGestureRecognizer];
}

//往上走
- (void)selectButtonTurnTop:(UIButton *)tempButton{
    _fromBottom = YES;
    tempButton.x = self.selectButton.x;
    tempButton.y = self.selectButton.y - viewW - 1;
}
//往左走
- (void)selectButtonTurnLeft:(UIButton *)tempButton{
    _fromRight = YES;
    tempButton.x = self.selectButton.x - viewW - 1;
    tempButton.y = self.selectButton.y;
}
//往下走
- (void)selectButtonTurnBottom:(UIButton *)tempButton{
    _fromTop = YES;
    tempButton.x = self.selectButton.x;
    tempButton.y = self.selectButton.y + viewW + 1;
}
//往右走
- (void)selectButtonTurnRight:(UIButton *)tempButton{
    _fromLeft = YES;
    tempButton.x = self.selectButton.x + viewW + 1;
    tempButton.y = self.selectButton.y;
}

- (void)linedraw:(UIButton *)tempButton isMove:(BOOL)isMove{
    if (isMove) {
        [self.lineLayer removeFromSuperlayer];
    }
    
    
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
//    CGPoint startPoint = CGPointMake(self.selectButton.centerX, <#CGFloat y#>)
    [linePath moveToPoint:tempButton.center];
    // 其他点
    [linePath addLineToPoint:self.selectButton.center];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    self.lineLayer = lineLayer;
    lineLayer.lineWidth = 2;
    lineLayer.strokeColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3].CGColor;
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor = nil; // 默认为blackColor
    
    
    [self.backgroundView.layer addSublayer:lineLayer];
    [self.backgroundView setNeedsDisplay];
}

- (IBAction)deleteBtnClick:(UIButton *)sender {
}

- (void)alert:(NSString *)msg{
    UIAlertView  * alert = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)clickBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 0://设置数字解锁
            [WHC_GestureUnlockScreenVC setUnlockScreenWithType:ClickNumberType];
            break;
        case 1://设置手势路径解锁
            [WHC_GestureUnlockScreenVC setUnlockScreenWithType:GestureDragType];
            break;
        case 2://修改手势密码
            if(![WHC_GestureUnlockScreenVC modifyUnlockPasswrodWithVC:self]){
                [self alert:@"先设置手势密码再修改"];
            }
            break;
        case 3://删除手势密码锁
            if(![WHC_GestureUnlockScreenVC removeGesturePasswordWithVC:self]){
                [self alert:@"先设置手势密码再删除"];
            }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
