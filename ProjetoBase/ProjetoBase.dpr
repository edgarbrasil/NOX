program ProjetoBase;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uAcessoDadosBase in 'Classes\AcessoDados\uAcessoDadosBase.pas',
  uFuncoesBase in 'Classes\Funcoes\uFuncoesBase.pas',
  uParametrosBase in 'Classes\Parametros\uParametrosBase.pas',
  uEntidadeBase in 'Classes\Entidades\uEntidadeBase.pas',
  uConexaoBD in 'Util\Global\uConexaoBD.pas',
  uConstantes in 'Util\uConstantes.pas',
  uCliente in 'Classes\Entidades\uCliente.pas',
  uClienteAcessoDados in 'Classes\AcessoDados\uClienteAcessoDados.pas',
  uClienteFuncoes in 'Classes\Funcoes\uClienteFuncoes.pas',
  uIEntidadeBase in 'Interfaces\Entidade\uIEntidadeBase.pas',
  uEnumeradores in 'Util\uEnumeradores.pas',
  uMercadoriaGrupo in 'Classes\Entidades\uMercadoriaGrupo.pas',
  uMercadoria in 'Classes\Entidades\uMercadoria.pas',
  uVenda in 'Classes\Entidades\uVenda.pas',
  uVendaItem in 'Classes\Entidades\uVendaItem.pas',
  uMercadoriaAcessoDados in 'uMercadoriaAcessoDados.pas',
  uClientes in 'Classes\Entidades\Colecoes\uClientes.pas',
  uColecaoBase in 'Classes\Entidades\Colecoes\uColecaoBase.pas',
  uFactoryEntidade in 'Factory\uFactoryEntidade.pas',
  uMercadorias in 'Classes\Entidades\Colecoes\uMercadorias.pas',
  uMercadoriaGrupos in 'Classes\Entidades\Colecoes\uMercadoriaGrupos.pas',
  uVendas in 'Classes\Entidades\Colecoes\uVendas.pas',
  uVendaItens in 'Classes\Entidades\Colecoes\uVendaItens.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
