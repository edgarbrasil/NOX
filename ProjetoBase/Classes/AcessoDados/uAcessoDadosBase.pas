unit uAcessoDadosBase;

interface

uses FireDAC.Comp.Client, FireDAC.Comp.DataSet, uConexaoBD;

type
  TAcessoDadosBase = class
  private
    { private declarations }
  protected
    { protected declarations }
    function CriarDataSet: TFDQuery;
    function ObterConnection: TFDCustomConnection;
    procedure DestruirDataSet(FDQuery: TFDQuery);
  public
    { public declarations }
  end;

implementation

uses SysUtils;

{ TAcessoDadosBase }

function TAcessoDadosBase.CriarDataSet: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := ObterConnection;
end;

function TAcessoDadosBase.ObterConnection: TFDCustomConnection;
begin
  Result := FDConnection;
end;

procedure TAcessoDadosBase.DestruirDataSet(FDQuery: TFDQuery);
begin
  if (not Assigned(FDQuery)) then Exit;

  FDQuery.Close;
  FreeAndNil(FDQuery);
end;

end.
