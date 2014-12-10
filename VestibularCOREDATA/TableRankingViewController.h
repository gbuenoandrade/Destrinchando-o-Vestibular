//
//  TableRankingViewController.h
//  EstatisticasFUVEST
//
//  Created by Guilherme Andrade on 10/30/13.
//  Copyright (c) 2013 Eldorado. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "QuestoesViewController.h"



/**
 * A classe TableRankingViewController é responsavel de ser o controller da tela que apresentará a frequencia
 * dos topicos na procura escolhida pelo usuario.
 */
@interface TableRankingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>



@property (strong,nonatomic) NSString* materiaSelecionada; //Propriedade de materia escolhida setada pela tela anterior.
@property (strong,nonatomic) NSArray* arrayFases; //Array com fases escolhidas setada pela tela anterior.
@property (strong,nonatomic) NSArray* arrayPeriodo; //Array com periodos setada pela tela anterior.
@property (strong, nonatomic) NSString *selectedExam;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end



