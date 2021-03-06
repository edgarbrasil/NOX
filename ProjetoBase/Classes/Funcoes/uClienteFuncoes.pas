unit uClienteFuncoes;

interface

uses uCliente, uClienteAcessoDados;

type
  TClienteFuncoes = class
  private
    { private declarations }
    FClienteAcessoDados: TClienteAcessoDados;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    function Obter(Codigo: Integer): TCliente;
    procedure Inserir(Cliente: TCliente);
    procedure Atualizar(Cliente: TCliente);
    procedure Excluir(Codigo: Integer);

    {
    demais m�todos que controlam o cliente
    }
  end;

implementation

uses SysUtils;

{ TClienteFuncoes }

constructor TClienteFuncoes.Create;
begin
  FClienteAcessoDados := TClienteAcessoDados.Create;
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
