//
//  TimeSelecterTool.m
//  healthyHelper
//
//  Created by snow on 2018/1/11.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "TimeSelecterTool.h"
@interface TimeSelecterTool()<UIPickerViewDelegate,UIPickerViewDataSource>


@end
@implementation TimeSelecterTool
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"weekDay" ofType:@"plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        _weeks = dic[@"weeks"];
        _begins = dic[@"begins"];
        _ends = dic[@"ends"];
        _timeDic = [NSMutableDictionary dictionary];
        _timeDic[@"week"] = _weeks[0];
        _timeDic[@"begin"] = _begins[0];
        _timeDic[@"end"] = _ends[0];
        _timeStr = [NSMutableString string];
        _timeStr = [NSMutableString stringWithFormat:@"%@%@%@",_timeDic[@"week"],_timeDic[@"begin"],_timeDic[@"end"]];
        self.backgroundColor = [UIColor whiteColor];
        UILabel *infoLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, self.frame.size.height)];
        infoLb.text = @"时间";
        [self addSubview:infoLb];

        _pickerV = [[UIPickerView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(infoLb.frame), 0, self.frame.size.width-CGRectGetMaxX(infoLb.frame)-10,self.frame.size.height)];
        _pickerV.delegate= self;
        _pickerV.dataSource = self;
        [_pickerV selectRow:0 inComponent:0 animated:YES];
        [_pickerV selectRow:0 inComponent:1 animated:YES];
        [_pickerV selectRow:0 inComponent:3 animated:YES];
        [self addSubview:_pickerV];
    }
    return self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 4;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return _weeks.count;
    }else if(component == 1){
        return _begins.count;
    }else if(component == 2){
        return 1;
    }
    else{
        return _ends.count;
    }
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return [_weeks objectAtIndex:row];
    }else if(component == 1){
        return [_begins objectAtIndex:row];
    }else if(component == 2){
        return @"到";
    }
    else{
        return [_ends objectAtIndex:row];
    }
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 60;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        _timeDic[@"week"] = _weeks[row];
    }else if(component == 1){
        _timeDic[@"begin"] = _begins[row];
        [pickerView selectRow:[_timeDic[@"begin"]intValue] inComponent:3 animated:YES];
        [self pickerView:pickerView didSelectRow:[_timeDic[@"end"]intValue] inComponent:3];
    }else if(component == 3){
        _timeDic[@"end"] = _ends[row];
    }
    if (self.timeBlk) {
        self.timeBlk(_timeDic);
    }
}
@end
