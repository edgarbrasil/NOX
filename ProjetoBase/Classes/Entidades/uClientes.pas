unit uClientes;

interface

uses Contnrs, uCliente;

type
  { TClientes }
  TClientes = class
  private
    { private declarations }
    FColecao: TObjectList;
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    procedure AdicionarCliente(Cliente: TCliente);
    function Quantidade: Integer;
    function ObterCliente(Indice: Integer): TCliente;
  end;

implementation

uses SysUtils;

{ TClientes }

constructor TClientes.Create;
begin
  FColecao := TObjectList.Create(True);
end;

destructor TClientes.Destroy;
begin
  if (Assigned(FColecao)) then
    FreeAndNIl(FColecao);
  inherited;
end;

procedure TClientes.AdicionarCliente(Cliente: TCliente);
begin
  if (Assigned(Cliente)) then
    FColecao.Add(Cliente);
end;

function TClientes.ObterCliente(Indice: Integer): TCliente;
begin
  Result := nil;
  if (Assigned(FColecao)) then
    Result := TCliente(FColecao[Indice]);
end;

function TClientes.Quantidade: Integer;
begin
  Result := 0;
  if (Assigned(FColecao)) then
    Result := FColecao.Count;
end;

end.
