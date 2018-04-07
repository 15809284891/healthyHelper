//
//  AddCourseController.m
//  healthyHelper
//
//  Created by snow on 2018/1/9.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "AddCourseController.h"
#import "AddCourseView.h"
#import "CourseModel.h"
@interface AddCourseController ()
@property (nonatomic,copy)NSArray *cellItems;

@end

@implementation AddCourseController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellItems = @[@"book",@"book",@"book",@"book"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    AddCourseView *addCourseView = [[AddCourseView alloc]initWithFrame:CGRectMake(0, 64,self.view.frame.size.width,screenH-64-49)];
    addCourseView.courseModel = [[CourseModel alloc]init];
    addCourseView.backgroundColor= bacColor;
    addCourseView.saveBlk = ^(CourseModel *courseModel) {
        if ((courseModel.courseName.length!=0 )&&(courseModel.teacher.length!=0)&&(courseModel.datetimeBegin.length!=0)&&(courseModel.address.length!=0)) {
            NSArray *arr = [PlistTool getPlistDataWithName:@"course"];
            int flag = 0;
            CourseModel *cM ;
            for (int i = 0; i<arr.count; i++) {
                NSMutableDictionary *dic = arr[i];
                cM = [CourseModel mj_objectWithKeyValues:dic];
                if ([cM.date isEqualToString:courseModel.date] && [cM.datetimeBegin isEqualToString:courseModel.datetimeBegin]&&[cM.datetimeEnd isEqualToString:courseModel.datetimeEnd]) {
                    flag = 1;
                }
            }
            if (flag == 1) {
                UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:@"该时间段已经安排课程，重新安排点击继续" preferredStyle: UIAlertControllerStyleAlert];
                UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"继续" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [PlistTool deleteDataInPlist:@"course" byID:cM.courseId];
                    courseModel.courseId= [NSString stringWithFormat:@"%u",arc4random() % 100 ];
                    NSMutableDictionary *newsDict = [NSMutableDictionary dictionary];
                    newsDict = courseModel.mj_keyValues;
                    /**
                     如果调用了该 block，就把值传过去
                     */
                    [PlistTool addDataInPlist:@"course" withData:newsDict];
                    if (self.ACBlk) {
                        self.ACBlk(courseModel);
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alertVc addAction:cancleAction];
                [alertVc addAction:okAction];
                [self presentViewController:alertVc animated:YES completion:nil];
            }else{
            courseModel.courseId= [NSString stringWithFormat:@"%u",arc4random() % 100 ];
            NSMutableDictionary *newsDict = [NSMutableDictionary dictionary];
            newsDict = courseModel.mj_keyValues;
            /**
             如果调用了该 block，就把值传过去
             */
            [PlistTool addDataInPlist:@"course" withData:newsDict];
            if (self.ACBlk) {
                self.ACBlk(courseModel);
            }
            [self.navigationController popViewControllerAnimated:YES];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"请将信息补充完整"];
        }
       
    };
    [self.view addSubview:addCourseView];
    _addCourseView = addCourseView;
    
}
@end
