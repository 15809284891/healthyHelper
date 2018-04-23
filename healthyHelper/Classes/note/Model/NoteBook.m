//
//  NoteBook.m
//  healthyHelper
//
//  Created by snow on 2018/1/6.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "NoteBook.h"

@implementation NoteBook


- (id)copyWithZone:(NSZone *)zone
{
    NoteBook* newTestObject = [[NoteBook allocWithZone:zone] init];
    newTestObject.NoteBookName = self.NoteBookName;
    newTestObject.NoteBookId = self.NoteBookId;
    newTestObject.NoteCount = self.NoteCount;
    return newTestObject;
}
@end
