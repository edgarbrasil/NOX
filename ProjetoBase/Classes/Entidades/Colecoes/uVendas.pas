unit uVendas;

interface

uses Classes, Contnrs, uColecaoBase, uVenda;

type
  TVendas = class(TColecaoBase)
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    procedure AdicionarVenda(Venda: TVenda);
    function ObterVenda(Indice: Integer): TVenda;
  end;

implementation

{ TVendas }

constructor TVendas.Create;
begin
  inherited Create;
end;

destructor TVendas.Destroy;
begin

  inherited;
end;

procedure TVendas.AdicionarVenda(Venda: TVenda);
begin
  if (Assigned(Venda)) then
    FColecao.Add(Venda);
end;

function TVendas.ObterVenda(Indice: Integer): TVenda;
begin
  Result := nil;
  if (Assigned(FColecao)) then
    Result := TVenda(FColecao[Indice]);
end;

end.
