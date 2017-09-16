unit uMercadorias;

interface

uses Classes, Contnrs, uColecaoBase, uMercadoria;

type
  TMercadorias = class(TColecaoBase)
  private
    { private declarations }
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    procedure AdicionarMercadoria(Mercadoria: TMercadoria);
    function ObterMercadoria(Indice: Integer): TMercadoria;
  end;

implementation

{ TMercadorias }

constructor TMercadorias.Create;
begin
  inherited Create;
end;

destructor TMercadorias.Destroy;
begin

  inherited;
end;

procedure TMercadorias.AdicionarMercadoria(Mercadoria: TMercadoria);
begin
  if (Assigned(Mercadoria)) then
    FColecao.Add(Mercadoria);
end;

function TMercadorias.ObterMercadoria(Indice: Integer): TMercadoria;
begin
  Result := nil;
  if (Assigned(FColecao)) then
    Result := TMercadoria(FColecao[Indice]);
end;

end.
