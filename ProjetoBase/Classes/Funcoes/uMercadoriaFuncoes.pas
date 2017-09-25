unit uMercadoriaFuncoes;

interface

uses uFuncoesBase, uMercadoria, uMercadoriaAcessoDados, FireDAC.Comp.Client;

type
  { TMercadoriaFuncoes }
  TMercadoriaFuncoes = class(TFuncoesBase)
  private
    { private declarations }
    FMercadoriaAcessoDados: TMercadoriaAcessoDados;
  public
    { public declarations }
    constructor Create(FDCustomConnection: TFDCustomConnection);
    destructor Destroy; override;

    function Obter(Codigo: Integer): TMercadoria;
    procedure Inserir(Mercadoria: TMercadoria);
    procedure Atualizar(Mercadoria: TMercadoria);
    procedure Excluir(Codigo: Integer);
    procedure SubtrairEstoque(CodigoMercadoria, Quantidade: Integer);
  end;

implementation

uses SysUtils;

{ TMercadoriaFuncoes }

constructor TMercadoriaFuncoes.Create(FDCustomConnection: TFDCustomConnection);
begin
  FMercadoriaAcessoDados := TMercadoriaAcessoDados.Create(FDCustomConnection);
end;

destructor TMercadoriaFuncoes.Destroy;
begin
  if (Assigned(FMercadoriaAcessoDados)) then
    FreeAndNil(FMercadoriaAcessoDados);

  inherited;
end;

procedure TMercadoriaFuncoes.Inserir(Mercadoria: TMercadoria);
begin
  FMercadoriaAcessoDados.Inserir(Mercadoria);
end;

procedure TMercadoriaFuncoes.Atualizar(Mercadoria: TMercadoria);
begin
  FMercadoriaAcessoDados.Atualizar(Mercadoria);
end;

function TMercadoriaFuncoes.Obter(Codigo: Integer): TMercadoria;
begin
  Result := FMercadoriaAcessoDados.Obter(Codigo);
end;

procedure TMercadoriaFuncoes.SubtrairEstoque(CodigoMercadoria, Quantidade: Integer);
begin
  FMercadoriaAcessoDados.SubtrairEstoque(CodigoMercadoria, Quantidade);
end;

procedure TMercadoriaFuncoes.Excluir(Codigo: Integer);
begin
  FMercadoriaAcessoDados.Excluir(Codigo);
end;

end.
