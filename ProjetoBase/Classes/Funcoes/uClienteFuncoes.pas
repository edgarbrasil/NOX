unit uClienteFuncoes;

interface

uses uFuncoesBase, uCliente, uClienteAcessoDados, FireDAC.Comp.Client;

type
  TClienteFuncoes = class(TFuncoesBase)
  private
    { private declarations }
    FClienteAcessoDados: TClienteAcessoDados;
  public
    { public declarations }
    constructor Create(FDCustomConnection: TFDCustomConnection);
    destructor Destroy; override;

    function Obter(Codigo: Integer): TCliente;
    procedure Inserir(Cliente: TCliente);
    procedure Atualizar(Cliente: TCliente);
    procedure Excluir(Codigo: Integer);
  end;

implementation

uses SysUtils;

{ TClienteFuncoes }

constructor TClienteFuncoes.Create(FDCustomConnection: TFDCustomConnection);
begin
  FClienteAcessoDados := TClienteAcessoDados.Create(FDCustomConnection);
end;

destructor TClienteFuncoes.Destroy;
begin
  if (Assigned(FClienteAcessoDados)) then
    FreeAndNil(FClienteAcessoDados);

  inherited;
end;

procedure TClienteFuncoes.Inserir(Cliente: TCliente);
begin
  FClienteAcessoDados.Inserir(Cliente);
end;

procedure TClienteFuncoes.Atualizar(Cliente: TCliente);
begin
  FClienteAcessoDados.Atualizar(Cliente);
end;

procedure TClienteFuncoes.Excluir(Codigo: Integer);
begin
  FClienteAcessoDados.Excluir(Codigo);
end;

function TClienteFuncoes.Obter(Codigo: Integer): TCliente;
begin
  Result := FClienteAcessoDados.Obter(Codigo);
end;

end.
