unit uConexaoBD;

interface

uses
  uConstantes,
  FireDAC.Comp.Client, FireDAC.Stan.Def, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef,
  FireDAC.Comp.UI, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, Data.DB, FireDAC.DApt, FireDAC.VCLUI.Wait;

function ObterCaminhoArquivoConfiguracao: String;
procedure CarregarConfiguracoesIni;
procedure ConectarBD;

var
  FDConnection: TFDConnection;
  UsuarioBD,
  SenhaBD,
  ServidorBD,
  NomeBaseBD: String;

implementation

uses SysUtils, IniFiles;

procedure CarregarConfiguracoesIni;
var
  IniFile: TIniFile;
  CaminhoArquivoConfiguracao: String;
begin
  try
    CaminhoArquivoConfiguracao := ObterCaminhoArquivoConfiguracao;
    if (not FileExists(CaminhoArquivoConfiguracao)) then
      raise Exception.CreateFmt('Arquivo %s de configura��o da aplica��o n�o encontrado.', [CaminhoArquivoConfiguracao]);

    IniFile := TIniFile.Create(CaminhoArquivoConfiguracao);
    try
      UsuarioBD := IniFile.ReadString('BD', 'USUARIO', EmptyStr);
      SenhaBD := IniFile.ReadString('BD', 'SENHA', EmptyStr);
      ServidorBD := IniFile.ReadString('BD', 'SERVIDOR', EmptyStr);
      NomeBaseBD := IniFile.ReadString('BD', 'BASE', EmptyStr);
    finally
      IniFile.Free;
    end;
  except
    on E: Exception do
      raise Exception.CreateFmt('Falha ao carregar configura��es da aplica��o. %s', [E.Message]);
  end;
end;

function ObterCaminhoArquivoConfiguracao: String;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFileDir(ParamStr(0))) + NOME_ARQUIVO_CONFIGURACAO;
end;

procedure ConectarBD;
begin
  try
    if (Assigned(FDConnection)) then
      Exit;

    FDConnection := TFDConnection.Create(nil);
    FDConnection.Params.Clear;
    FDConnection.Params.DriverID := 'MSSQL';
    FDConnection.Params.UserName := UsuarioBD;
    FDConnection.Params.Password := SenhaBD;
    FDConnection.Params.Database := NomeBaseBD;
    FDConnection.Params.Values['Server'] := ServidorBD;
    FDConnection.Connected := True;
  except
    on E: Exception do
      raise Exception.CreateFmt('Falha ao conectar no bando de dados', [e.Message]);
  end;
end;

procedure DestruirConexaoBD;
begin
  if (not Assigned(FDConnection)) then Exit;

  FDConnection.Connected := False;
  FreeAndNil(FDConnection);
end;

initialization
  CarregarConfiguracoesIni;
  ConectarBD;

finalization
  DestruirConexaoBD;

end.
