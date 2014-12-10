//
//  Question+MetaInformation.m
//  VestibularCOREDATA
//
//  Created by Guilherme Andrade on 3/12/14.
//  Copyright (c) 2014 Eldorado. All rights reserved.
//

#import "Question+MetaInformation.h"
#import "Topic.h"
#import "Subject.h"
#import "Test.h"

@implementation Question (MetaInformation)

- (NSDictionary*)getPrintableStringAndTopics{
    
    NSMutableArray* topics = [NSMutableArray arrayWithArray:[self.topicsIBelong allObjects]];
    [topics sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString* name1 = ((Topic*)obj1).name;
        NSString* name2 = ((Topic*)obj2).name;
        return [name1 localizedCaseInsensitiveCompare:name2];
    }];
    
    Subject* subject = [[topics firstObject] subjectIBelong];
    Test* test = [subject testIBelong];
    NSInteger phase = [test.phase integerValue];
    NSString *stringToReturn;
    if (phase == 1) {
       stringToReturn = [NSString stringWithFormat:@"Ano: %@ - 1ª Fase - Q.%@",test.year,self.number];
    }
    else{
        stringToReturn = [NSString stringWithFormat:@"Ano: %@ - 2ª Fase - dia %@ - %c.%@",test.year,test.day,[subject.name characterAtIndex:0],self.number];
    }
    return [NSDictionary dictionaryWithObjectsAndKeys:topics,@"topics",stringToReturn,@"string",nil];
}

@end


