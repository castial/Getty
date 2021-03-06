//
//  HYPlan.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/9.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYPlan : NSObject

@property (nonatomic, assign) NSInteger planId;

@property (nonatomic, copy) NSString *planName;

@property (nonatomic, strong) NSDate *startTime;

@property (nonatomic, strong) NSDate *endTime;

@property (nonatomic, strong) NSDate *createDate;

@property (nonatomic, strong) NSDate *updateDate;

@property (nonatomic, assign) NSInteger durationTime;

@property (nonatomic, assign) NSInteger durationDays;

@property (nonatomic, assign) BOOL isDelete;

@end
