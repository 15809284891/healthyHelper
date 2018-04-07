//
//  EditCourseController.m
//  healthyHelper
//
//  Created by snow on 2018/1/21.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "EditCourseController.h"
#import "CourseModel.h"
#import "AddCourseView.h"
#import "AddCourseItemView.h"
#import "TimeSelecterTool.h"
@interface EditCourseController ()

@end

@implementation EditCourseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initwithRightItem];
    
    // Do any additional setup after loading the view.
    self.addCourseView.courseNameItemV.tfContent = self.courseModel.courseName;
    self.addCourseView.teacherNameItemV.tfContent = self.courseModel.teacher;
    self.addCourseView.addressItemV.tfContent = self.courseModel.address;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"weekDay" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *weeks = dic[@"weeks"];
    NSArray *begins = dic[@"begins"];
    NSArray *ends = dic[@"ends"];
    [self.addCourseView.timeV.pickerV selectRow:[weeks indexOfObject:self.courseModel.date] inComponent:0 animated:YES];
    [self.addCourseView.timeV.pickerV selectRow:[begins indexOfObject:self.courseModel.datetimeBegin] inComponent:1 animated:YES];
    [self.addCourseView.timeV.pickerV selectRow:[ends indexOfObject:self.courseModel.datetimeEnd] inComponent:3 animated:YES];
    NSLog(@"viewDidLoad %@",self.courseModel.mj_keyValues);
    __weak typeof(self) weakSelf = self;
    self.addCourseView.saveBlk = ^(CourseModel *courseModel) {
        NSMutableDictionary *newsDict = [NSMutableDictionary dictionary];
        courseModel.courseId = self.courseModel.courseId;
        newsDict = courseModel.mj_keyValues;
        NSLog(@"数据 i--------%@",newsDict);
        [PlistTool deleteDataInPlist:@"course" byID:courseModel.courseId];
        [PlistTool addDataInPlist:@"course" withData:newsDict];
        if (self.ACBlk) {
            self.ACBlk(nil);
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
        NSLog(@"hello");
    };
}
-(void)initwithRightItem{
    UIButton *deleteCourseBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteCourseBt setImage:[UIImage imageNamed:@"del"] forState:UIControlStateNormal];
    [deleteCourseBt addTarget:self action:@selector(delCourse) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:deleteCourseBt];
}
-(void)delCourse{
     [PlistTool deleteDataInPlist:@"course" byID:self.courseModel.courseId];
    if (self.delBlk) {
        self.delBlk();
    }
   
    [self.navigationController popViewControllerAnimated:YES];
}
@end
