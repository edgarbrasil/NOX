unit uClientes;

interface

uses Classes, Contnrs, uColecaoBase, uCliente;

type
  { TClientes }
  TClientes = class(TColecaoBase)
  private
    { private declarations }
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    procedure AdicionarCliente(Cliente: TCliente);
    function ObterCliente(Indice: Integer): TCliente;
  end;

implementation

uses SysUtils;

{ TClientes }

constructor TClientes.Create;
begin
  inherited Create;
end;

destructor TClientes.Destroy;
begin
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

end.
