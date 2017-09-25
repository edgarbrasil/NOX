unit uVendaItemFuncoes;

interface

uses uFuncoesBase, uVendaItem, uVendaItens, uVendaItemAcessoDados, FireDAC.Comp.Client;

type
  { TVendaItemFuncoes }
  TVendaItemFuncoes = class(TFuncoesBase)
  private
    { private declarations }
    FVendaItemAcessoDados: TVendaItemAcessoDados;
    FFDCustomConnection: TFDCustomConnection;
  public
    { public declarations }
    constructor Create(FDCustomConnection: TFDCustomConnection);
    destructor Destroy; override;

    function ExisteSaldo(VendaItem: TVendaItem): Boolean;
    function Obter(CodigoVenda: Integer): TVendaItens;
    procedure Inserir(VendaItem: TVendaItem);
    procedure Atualizar(VendaItem: TVendaItem);
    procedure Excluir(Codigo: Integer);
    procedure ExcluirVendaItens(CodigoVenda: Integer);
  end;

implementation

uses SysUtils, uMercadoriaFuncoes, uMercadoria;

{ TVendaItemFuncoes }

constructor TVendaItemFuncoes.Create(FDCustomConnection: TFDCustomConnection);
begin
  FFDCustomConnection := FDCustomConnection;
  FVendaItemAcessoDados := TVendaItemAcessoDados.Create(FDCustomConnection);
end;

destructor TVendaItemFuncoes.Destroy;
begin
  if (Assigned(FVendaItemAcessoDados)) then
    FreeAndNil(FVendaItemAcessoDados);

  inherited;
end;

procedure TVendaItemFuncoes.Inserir(VendaItem: TVendaItem);
begin
  FVendaItemAcessoDados.Inserir(VendaItem);
end;

procedure TVendaItemFuncoes.Atualizar(VendaItem: TVendaItem);
begin
  FVendaItemAcessoDados.Atualizar(VendaItem);
end;

function TVendaItemFuncoes.Obter(CodigoVenda: Integer): TVendaItens;
begin
  Result := FVendaItemAcessoDados.Obter(CodigoVenda);
end;

procedure TVendaItemFuncoes.Excluir(Codigo: Integer);
begin
  FVendaItemAcessoDados.Excluir(Codigo);
end;

procedure TVendaItemFuncoes.ExcluirVendaItens(CodigoVenda: Integer);
begin
  FVendaItemAcessoDados.ExcluirVendaItens(CodigoVenda);
end;

function TVendaItemFuncoes.ExisteSaldo(VendaItem: TVendaItem): Boolean;
var
  Mercadoria: TMercadoria;
  MercadoriaFuncoes: TMercadoriaFuncoes;
begin
  MercadoriaFuncoes := TMercadoriaFuncoes.Create(FFDCustomConnection);
  try
    Mercadoria := MercadoriaFuncoes.Obter(VendaItem.CodigoMercadoria);
    try
      Result := (Mercadoria.QuantidadeEstoque >= VendaItem.Quantidade);
    finally
      FreeAndNil(Mercadoria);
    end;
  finally
    FreeAndNil(MercadoriaFuncoes);
  end;
end;

end.
