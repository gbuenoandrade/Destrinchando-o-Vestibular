//
//  InicialViewController.h
//  EstatisticasFUVEST
//
//  Created by Guilherme Andrade on 10/30/13.
//  Copyright (c) 2013 Eldorado. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InicialViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *myPickerView;

@property (nonatomic, strong) NSArray *itemsArray;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
