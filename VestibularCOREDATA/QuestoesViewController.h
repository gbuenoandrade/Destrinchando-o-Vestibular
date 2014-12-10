//
//  QuestoesViewController.h
//  EstatisticasFUVEST
//
//  Created by Guilherme Andrade on 10/30/13.
//  Copyright (c) 2013 Eldorado. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImagemQuestaoViewController.h"

/* Ess classe é responsável por ser o controler da tela que apresenta informaçoes sobre
 * o topico selecionado na lista de frequencia dos mesmo.
 */
@interface QuestoesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSDictionary* topicDict;

@end