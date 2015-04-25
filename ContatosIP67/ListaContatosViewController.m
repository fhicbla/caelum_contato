//
//  ListaContatosViewController.m
//  ContatosIP67
//
//  Created by ios5065 on 18/04/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListaContatosViewController.h"
#import "FormularioContatoViewController.h"

@implementation ListaContatosViewController : UITableViewController

- (id)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"Contatos";
        UIBarButtonItem *botaoExibirFormulario = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeFormulario)];
        self.navigationItem.rightBarButtonItem = botaoExibirFormulario;
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        self.dao = [ContatoDao contatoDaoInstance];
        self.linhaDestaque = 1;
    }
    return self;
}

- (void) exibeFormulario {
    //NSLog(@"Aqui vamos exibir o formulário");
    //UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Formulário" message:@"Aqui vamos exibir o formulário" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    //[alert show];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FormularioContatoViewController *form = [storyboard
                                             instantiateViewControllerWithIdentifier:@"Form-Contato"];
    form.delegate = self;
    if (self.contatoSelecionado) {
        form.contato = self.contatoSelecionado;
    }
    [self.navigationController pushViewController:form animated:YES];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dao.contatos count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:cellIdentifier];
    }
    
    Contato *contato = [self.dao buscaContatoDaPosicao:indexPath.row];
    cell.textLabel.text = contato.nome;
    
    return cell;
}

- (void) viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILongPressGestureRecognizer *longPress =
        [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(exibeMaisAcoes:)];
    
    [self.tableView addGestureRecognizer:longPress];
}

- (void)viewDidAppear:(BOOL)animated {
    if (self.linhaDestaque >= 0 && self.dao.contatos.count > 0) {
        NSIndexPath *indexPath = [NSIndexPath
                                  indexPathForRow:self.linhaDestaque inSection:0];
        [self.tableView
            selectRowAtIndexPath:indexPath animated:YES
            scrollPosition:UITableViewScrollPositionNone];
        [self.tableView
            scrollToRowAtIndexPath:indexPath
            atScrollPosition:UITableViewScrollPositionNone animated:YES];
        
        self.linhaDestaque = -1;
    }
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dao removeContatoDaPosicao:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.contatoSelecionado = [self.dao buscaContatoDaPosicao:indexPath.row];
    [self exibeFormulario];
    self.contatoSelecionado = nil;
}

- (void)contatoAtualizado:(Contato *)contato {
    self.linhaDestaque = [self.dao buscaPosicaoDoContato:contato];
}

- (void)contatoAdicionado:(Contato *)contato {
    self.linhaDestaque = [self.dao buscaPosicaoDoContato:contato];
}

- (void)exibeMaisAcoes:(UIGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        CGPoint ponto  = [gesture locationInView:self.tableView];
        NSIndexPath *index = [self.tableView indexPathForRowAtPoint:ponto];
        if (index) {
            self.contatoSelecionado = [self.dao buscaContatoDaPosicao:index.row];
            _gerenciador = [[GerenciadorDeAcoes alloc] initWithContato:self.contatoSelecionado];
            [self.gerenciador acoesDoController:self];
        }
    }
}

@end
