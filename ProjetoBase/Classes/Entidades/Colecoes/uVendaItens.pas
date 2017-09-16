unit uVendaItens;

interface

uses Classes, Contnrs, uColecaoBase, uVendaItem;

type
  TVendaItens = class(TColecaoBase)
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    procedure AdicionarVendaItem(VendaItem: TVendaItem);
    function ObterVendaItem(Indice: Integer): TVendaItem;
  end;

implementation

{ TVendaItens }

constructor TVendaItens.Create;
begin
  inherited Create;
end;

destructor TVendaItens.Destroy;
begin

  inherited;
end;

procedure TVendaItens.AdicionarVendaItem(VendaItem: TVendaItem);
begin
  if (Assigned(VendaItem)) then
    FColecao.Add(VendaItem);
end;

function TVendaItens.ObterVendaItem(Indice: Integer): TVendaItem;
begin
  Result := nil;
  if (Assigned(FColecao)) then
    Result := TVendaItem(FColecao[Indice]);
end;

end.
