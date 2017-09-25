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
  uEnumeradores in 'Util\uEnumeradores.pas',
  uMercadoriaGrupo in 'Classes\Entidades\uMercadoriaGrupo.pas',
  uMercadoria in 'Classes\Entidades\uMercadoria.pas',
  uVenda in 'Classes\Entidades\uVenda.pas',
  uVendaItem in 'Classes\Entidades\uVendaItem.pas',
  uClientes in 'Classes\Entidades\Colecoes\uClientes.pas',
  uColecaoBase in 'Classes\Entidades\Colecoes\uColecaoBase.pas',
  uMercadorias in 'Classes\Entidades\Colecoes\uMercadorias.pas',
  uMercadoriaGrupos in 'Classes\Entidades\Colecoes\uMercadoriaGrupos.pas',
  uVendas in 'Classes\Entidades\Colecoes\uVendas.pas',
  uVendaItens in 'Classes\Entidades\Colecoes\uVendaItens.pas',
  uMercadoriaAcessoDados in 'Classes\AcessoDados\uMercadoriaAcessoDados.pas',
  uMercadoriaFuncoes in 'Classes\Funcoes\uMercadoriaFuncoes.pas',
  uMercadoriaGrupoAcessoDados in 'Classes\AcessoDados\uMercadoriaGrupoAcessoDados.pas',
  uMercadoriaGrupoFuncoes in 'Classes\Funcoes\uMercadoriaGrupoFuncoes.pas',
  uVendaItemAcessoDados in 'Classes\AcessoDados\uVendaItemAcessoDados.pas',
  uVendaItemFuncoes in 'Classes\Funcoes\uVendaItemFuncoes.pas',
  uUtil in 'Util\uUtil.pas',
  uVendaAcessoDados in 'Classes\AcessoDados\uVendaAcessoDados.pas',
  uVendaFuncoes in 'Classes\Funcoes\uVendaFuncoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
