//
//  ViewController.m
//  ContatosIP67
//
//  Created by ios5065 on 11/04/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "FormularioContatoViewController.h"
#import "Contato.h"
#import "ContatoDao.h"

@interface FormularioContatoViewController ()

@end

@implementation FormularioContatoViewController

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _contatoDao = [ContatoDao contatoDaoInstance];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pegaDadosDoFormulario {
    Contato *contato = [[Contato alloc] init];
    contato.nome = [self.nome text];
    contato.telefone = [self.telefone text];
    contato.endereco = [self.endereco text];
    contato.email = [self.email text];
    contato.site = [self.site text];
    
    [self.contatoDao adicionaContato:contato];
    
    NSLog(@"Dados: %@", [[[self.contatoDao contatos] lastObject] description]);
}

@end
