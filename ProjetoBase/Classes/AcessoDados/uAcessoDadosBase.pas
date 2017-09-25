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
    procedure Commit;
    procedure Rollback;
    procedure StartTransaction;
  public
    { public declarations }
    constructor Create(FDCustomConnection: TFDCustomConnection);
    destructor Destroy; override;
  end;

implementation

uses SysUtils, uConstantes;

{ TAcessoDadosBase }

constructor TAcessoDadosBase.Create(FDCustomConnection: TFDCustomConnection);
begin
  if (not Assigned(FDCustomConnection)) then
      raise Exception.CreateFmt(MSG_PARAMETRO_ESTA_NULO, ['FDCustomConnection']);

  if (not (FDCustomConnection.Connected)) then
  begin
    try
      FDCustomConnection.Connected := True;
    except
      on E: Exception do
        raise Exception.CreateFmt('Não foi possivel ativar a conexão com o bando de dados. %s', [E.Message]);
    end;

  end;

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

procedure TAcessoDadosBase.Commit;
begin
  while FFDCustomConnection.InTransaction do
    FFDCustomConnection.Commit;
end;

procedure TAcessoDadosBase.Rollback;
begin
  while FFDCustomConnection.InTransaction do
    FFDCustomConnection.Rollback;
end;

procedure TAcessoDadosBase.StartTransaction;
begin
  if not FFDCustomConnection.InTransaction then
    FFDCustomConnection.Rollback;
end;

procedure TAcessoDadosBase.DestruirDataSet(FDQuery: TFDQuery);
begin
  if (not Assigned(FDQuery)) then Exit;

  FDQuery.Close;
  FreeAndNil(FDQuery);
end;

end.
