//
//  PersonView.m
//  图书管理
//
//  Created by lixue on 16/7/15.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "Masonry.h"
#import "PersonView.h"
#import "XMGLoginRegisterViewController.h"
#import "personModel.h"
@implementation PersonView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initHeadViewName];
    }
    return self;
}


-(void)initHeadViewName{
    UILabel *nameLb = [[UILabel alloc]init];
    nameLb.font = [UIFont systemFontOfSize:20];
    [self addSubview:nameLb];
    self.nameLb = nameLb;
    UILabel *numLb = [[UILabel alloc]init];
    numLb.font = [UIFont systemFontOfSize:18.0];
    [self addSubview:numLb];
    self.numLb = numLb;
    
    UILabel *majorLb = [[UILabel alloc]init];
    majorLb.font = numLb.font;
    [self addSubview:majorLb];
    self.majorLb = majorLb;
    
    UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageButton setBackgroundImage:[UIImage imageNamed:@"头像" ]forState:UIControlStateNormal];
    imageButton.layer.masksToBounds = YES;
    imageButton.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor lightGrayColor]);
    imageButton.backgroundColor = [UIColor redColor];
    [self addSubview:imageButton];
    self.ImageButton = imageButton;

  }
-(void)setPerson:(personModel *)person{
//    NSLog(@"hahahah          person %@",person.Name);
    _person = person;
    [self.ImageButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    if (_person==nil) {
        NSLog(@"登录");
        self.nameLb.text = @"登录";
        self.numLb.text  = nil;
        self.majorLb.text = nil;
        self.ImageButton.tag = 0;
        [self.ImageButton setBackgroundImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];

        return;
    }
    else{
    self.ImageButton.tag =1;
    /*从沙盒获取头像*/
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currenImage.png"];
    UIImage *saveImage = [UIImage imageWithContentsOfFile:fullPath];
    /*如果沙盒没有，设置默认*/
    if (!saveImage) {
        [self.ImageButton setBackgroundImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
    }
    /*否则设置沙盒中的*/
    else{
        [self.ImageButton setBackgroundImage:saveImage forState:UIControlStateNormal];
    }
    

//    self.nameLb.text = _person.Name;
//    self.numLb.text  = _person.ID;
//    self.majorLb.text = _person.Department;
    }

}
-(void)layoutSubviews{
    [super layoutSubviews];

    [self.ImageButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(self.top).offset(5);
        make.bottom.equalTo(self.bottom).offset(-5);
        make.width.equalTo(self.ImageButton.height);
    }];
    self.ImageButton.layer.cornerRadius = self.ImageButton.frame.size.width/2.0;
    [self.nameLb makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ImageButton.top).offset(5);
        make.left.equalTo(self.ImageButton.right).offset(10);
        make.right.equalTo(self.right).offset(-5);
        make.height.equalTo(self.ImageButton.height).multipliedBy(0.5);
    }];

    [self.numLb makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.ImageButton.bottom);
        make.left.equalTo(self.ImageButton.right).offset(10);
        make.width.equalTo(100);
        make.top.equalTo(self.nameLb.bottom);
    }];
    [self.majorLb makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.numLb.bottom);
        make.left.equalTo(self.numLb.right).offset(5);
        make.width.equalTo(100);
        make.height.equalTo(self.numLb.height);
    }];
    
}
-(void)click:(UIButton *)sender{
    [self.delegate loginorChange:sender];
}

@end
