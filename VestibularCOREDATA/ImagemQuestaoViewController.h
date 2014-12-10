//
//  ImagemQuestaoViewController.h
//  EstatisticasFUVEST
//
//  Created by Guilherme Andrade on 10/30/13.
//  Copyright (c) 2013 Eldorado. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Question;

/* Essa classe é responsável por ser o controler da tela que apresenta informaçoes sobre
 * a questao  selecionada na lista de questoes de um certo topico.
 */
@interface ImagemQuestaoViewController : UIViewController <UIScrollViewDelegate>


@property (nonatomic, strong) Question* question;
@property (nonatomic, strong) NSString* currentTopic;

@end



