unit uUtil;

interface

function ObterProximoSequence(NomeSequence: String): Integer;

implementation

uses SysUtils, uConexaoBD, FireDAC.Comp.Client;

function ObterProximoSequence(NomeSequence: String): Integer;
var
  FDQuery: TFDQuery;
begin
  Result := 0;
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := FDConnection;
    FDQuery.SQL.Text := 'SELECT NEXT VALUE FOR ' + NomeSequence +' as VALOR';
    FDQuery.Open;
    if (not FDQuery.Eof) then
      Result := FDQuery.FieldByName('VALOR').AsInteger
  finally
    FreeAndNil(FDQuery);
  end;

end;

end.
