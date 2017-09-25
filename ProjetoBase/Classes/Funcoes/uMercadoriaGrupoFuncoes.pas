unit uMercadoriaGrupoFuncoes;

interface

uses uFuncoesBase, uMercadoriaGrupo, uMercadoriaGrupoAcessoDados, FireDAC.Comp.Client;

type
  { TMercadoriaGrupoFuncoes }
  TMercadoriaGrupoFuncoes = class(TFuncoesBase)
  private
    { private declarations }
    FMercadoriaGrupoAcessoDados: TMercadoriaGrupoAcessoDados;
  public
    { public declarations }
    constructor Create(FDCustomConnection: TFDCustomConnection);
    destructor Destroy; override;

    function Obter(Codigo: Integer): TMercadoriaGrupo;
    procedure Inserir(MercadoriaGrupo: TMercadoriaGrupo);
    procedure Atualizar(MercadoriaGrupo: TMercadoriaGrupo);
    procedure Excluir(Codigo: Integer);
  end;

implementation

uses SysUtils;

{ TMercadoriaGrupoFuncoes }

constructor TMercadoriaGrupoFuncoes.Create(FDCustomConnection: TFDCustomConnection);
begin
  FMercadoriaGrupoAcessoDados := TMercadoriaGrupoAcessoDados.Create(FDCustomConnection);
end;

destructor TMercadoriaGrupoFuncoes.Destroy;
begin
  if (Assigned(FMercadoriaGrupoAcessoDados)) then
    FreeAndNil(FMercadoriaGrupoAcessoDados);
  inherited;
end;

procedure TMercadoriaGrupoFuncoes.Inserir(MercadoriaGrupo: TMercadoriaGrupo);
begin
  FMercadoriaGrupoAcessoDados.Inserir(MercadoriaGrupo);
end;

procedure TMercadoriaGrupoFuncoes.Atualizar(MercadoriaGrupo: TMercadoriaGrupo);
begin
  FMercadoriaGrupoAcessoDados.Atualizar(MercadoriaGrupo);
end;

function TMercadoriaGrupoFuncoes.Obter(Codigo: Integer): TMercadoriaGrupo;
begin
  Result := FMercadoriaGrupoAcessoDados.Obter(Codigo);
end;

procedure TMercadoriaGrupoFuncoes.Excluir(Codigo: Integer);
begin
  FMercadoriaGrupoAcessoDados.Excluir(Codigo);
end;

end.
