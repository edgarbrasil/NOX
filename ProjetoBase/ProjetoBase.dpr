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
  uFactoryEntidade in 'Classes\Entidades\uFactoryEntidade.pas',
  uEnumeradores in 'Util\uEnumeradores.pas',
  uMercadoriaGrupo in 'Classes\Entidades\uMercadoriaGrupo.pas',
  uMercadoria in 'Classes\Entidades\uMercadoria.pas',
  uVenda in 'Classes\Entidades\uVenda.pas',
  uVendaItem in 'Classes\Entidades\uVendaItem.pas',
  uMercadoriaAcessoDados in 'uMercadoriaAcessoDados.pas',
  Unit1 in 'Unit1.pas' {Form1},
  uClientes in 'Classes\Entidades\uClientes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
