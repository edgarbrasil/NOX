unit uAcessoDadosBase;

interface

uses FireDAC.Comp.Client, FireDAC.Comp.DataSet, uConexaoBD;

type
  TAcessoDadosBase = class
  private
    { private declarations }
    FFDCustomConnection: TFDCustomConnection;
  protected
    { protected declarations }
    function CriarDataSet: TFDQuery;
    function ObterConnection: TFDCustomConnection;
    procedure DestruirDataSet(FDQuery: TFDQuery);
  public
    { public declarations }
    constructor Create(FDCustomConnection: TFDCustomConnection);
    destructor Destroy; override;
  end;

implementation

uses SysUtils;

{ TAcessoDadosBase }

constructor TAcessoDadosBase.Create(FDCustomConnection: TFDCustomConnection);
begin
  if (not Assigned(FDCustomConnection)) then
    raise Exception.Create('Parâmetro FDCustomConnection está nulo.');
  if (not (FDCustomConnection.Connected)) then
    raise Exception.Create('Não existe conexão ativa com o bando de dados.');

  FFDCustomConnection := FDCustomConnection;
end;

destructor TAcessoDadosBase.Destroy;
begin

  inherited;
end;


function TAcessoDadosBase.CriarDataSet: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := ObterConnection;
end;

function TAcessoDadosBase.ObterConnection: TFDCustomConnection;
begin
  Result := FFDCustomConnection;
end;

procedure TAcessoDadosBase.DestruirDataSet(FDQuery: TFDQuery);
begin
  if (not Assigned(FDQuery)) then Exit;

  FDQuery.Close;
  FreeAndNil(FDQuery);
end;

end.
