unit uMercadoriaGrupos;

interface

uses Classes, Contnrs, uColecaoBase, uMercadoriaGrupo;

type
  TMercadoriaGrupos = class(TColecaoBase)
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    procedure AdicionarMercadoriaGrupo(MercadoriaGrupo: TMercadoriaGrupo);
    function ObterMercadoriaGrupo(Indice: Integer): TMercadoriaGrupo;
  end;

implementation

{ TMercadoriaGrupos }

constructor TMercadoriaGrupos.Create;
begin
  inherited Create;
end;

destructor TMercadoriaGrupos.Destroy;
begin

  inherited;
end;

procedure TMercadoriaGrupos.AdicionarMercadoriaGrupo(
  MercadoriaGrupo: TMercadoriaGrupo);
begin
  if (Assigned(MercadoriaGrupo)) then
    FColecao.Add(MercadoriaGrupo);
end;

function TMercadoriaGrupos.ObterMercadoriaGrupo(
  Indice: Integer): TMercadoriaGrupo;
begin
  Result := nil;
  if (Assigned(FColecao)) then
    Result := TMercadoriaGrupo(FColecao[Indice]);
end;

end.
