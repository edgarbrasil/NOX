unit uVendaFuncoes;

interface

uses uFuncoesBase, uVenda, uVendaItem, uVendaItens, uVendaItemAcessoDados, uVendaAcessoDados, FireDAC.Comp.Client;

type
  { TVendaFuncoes }
  TVendaFuncoes = class(TFuncoesBase)
  private
    { private declarations }
    FVendaAcessoDados: TVendaAcessoDados;
    FFDCustomConnection: TFDCustomConnection;
    procedure ValidarVenda(Venda: TVenda);
    procedure ValidarExisteSaldoItens(VendaItens: TVendaItens);
  public
    { public declarations }
    constructor Create(FDCustomConnection: TFDCustomConnection);
    destructor Destroy; override;

    function Obter(Codigo: Integer): TVenda;
    procedure Inserir(Venda: TVenda);
    procedure Excluir(Codigo: Integer);
  end;

implementation

uses SysUtils, uCOnstantes, uVendaItemFuncoes;

{ TVendaFuncoes }

constructor TVendaFuncoes.Create(FDCustomConnection: TFDCustomConnection);
begin
  FFDCustomConnection := FDCustomConnection;
  FVendaAcessoDados := TVendaAcessoDados.Create(FDCustomConnection);
end;

destructor TVendaFuncoes.Destroy;
begin
  if (Assigned(FVendaAcessoDados)) then
    FreeAndNil(FVendaAcessoDados);

  inherited;
end;

procedure TVendaFuncoes.Inserir(Venda: TVenda);
begin
  ValidarVenda(Venda);
  FVendaAcessoDados.Inserir(Venda);
end;

procedure TVendaFuncoes.ValidarVenda(Venda: TVenda);
begin
  if (not Assigned(Venda)) then
    raise Exception.CreateFmt(MSG_PARAMETRO_ESTA_NULO, ['Venda']);
  if (not Assigned(Venda.Cliente)) then
    raise Exception.CreateFmt(MSG_PARAMETRO_ESTA_NULO, ['Venda.Cliente']);
  if (Venda.Cliente.Codigo <= 0) then
    raise Exception.Create('Código do Cliente está zerado.');
  if (not Assigned(Venda.VendaItens)) then
    raise Exception.CreateFmt(MSG_PARAMETRO_ESTA_NULO, ['Venda.VendaItens']);
  if (Venda.VendaItens.Quantidade <= 0) then
    raise Exception.Create('Para venda é obrigatório ao menos um ítem.');
  ValidarExisteSaldoItens(Venda.VendaItens);
end;

procedure TVendaFuncoes.ValidarExisteSaldoItens(VendaItens: TVendaItens);
var
  i: Integer;
  VendaItemFuncoes: TVendaItemFuncoes;
begin
  VendaItemFuncoes := TVendaItemFuncoes.Create(FFDCustomConnection);
  try
    for i := 0 to VendaItens.Quantidade - 1 do
    begin
      if (not VendaItemFuncoes.ExisteSaldo(VendaItens.ObterVendaItem(i))) then
        raise Exception.CreateFmt('Não existe saldo suficiente para venda do ítem %s.', [VendaItens.ObterVendaItem(i).CodigoMercadoria]);
    end;
  finally
    FreeAndNil(VendaItemFuncoes);
  end;
end;

function TVendaFuncoes.Obter(Codigo: Integer): TVenda;
begin
  Result := FVendaAcessoDados.Obter(Codigo);
end;

procedure TVendaFuncoes.Excluir(Codigo: Integer);
begin
  FVendaAcessoDados.Excluir(Codigo);
end;

end.
