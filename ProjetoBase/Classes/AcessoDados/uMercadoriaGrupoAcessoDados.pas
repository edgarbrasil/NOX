unit uMercadoriaGrupoAcessoDados;

interface

uses FireDAC.Stan.Param, FireDAC.Comp.Client, FireDAC.DApt, uAcessoDadosBase, uMercadoriaGrupo;

type
  { TMercadoriaGrupoAcessoDados }
  TMercadoriaGrupoAcessoDados = class(TAcessoDadosBase)
  private
    { private declarations }
    procedure ValidarParametroMercadoriaGrupoNulo(MercadoriaGrupo: TMercadoriaGrupo);
  public
    { public declarations }
    constructor Create(FDCustomConnection: TFDCustomConnection);
    destructor Destroy; override;

    function Obter(Codigo: Integer): TMercadoriaGrupo;
    procedure Inserir(MercadoriaGrupo: TMercadoriaGrupo);
    procedure Atualizar(MercadoriaGrupo: TMercadoriaGrupo);
    procedure Excluir(Codigo: Integer);
  end;

implementation

uses StrUtils, SysUtils, uConstantes;

{ TMercadoriaGrupoAcessoDados }

constructor TMercadoriaGrupoAcessoDados.Create(FDCustomConnection: TFDCustomConnection);
begin
  inherited Create(FDCustomConnection);
end;

destructor TMercadoriaGrupoAcessoDados.Destroy;
begin

  inherited;
end;

procedure TMercadoriaGrupoAcessoDados.Inserir(MercadoriaGrupo: TMercadoriaGrupo);
var
  FDQuery: TFDQuery;
begin
  try
    ValidarParametroMercadoriaGrupoNulo(MercadoriaGrupo);

    FDQuery := CriarDataSet;
    try
      FDQuery.SQL.Text :=
        'INSERT INTO MERCADORIA_GRUPO '+
        '       (SEQ_MERCADORIA_GRUPO '+
        '       ,DS_NOME '+
        '       ,FG_COBRA_TAXA_SERVICO) '+
        ' VALUES '+
        '       (:SEQ_MERCADORIA_GRUPO '+
        '       ,:DS_NOME '+
        '       ,:FG_COBRA_TAXA_SERVICO)';
      FDQuery.Params.ParamByName('SEQ_MERCADORIA_GRUPO').AsInteger := MercadoriaGrupo.Codigo;
      FDQuery.Params.ParamByName('DS_NOME').AsString := MercadoriaGrupo.Nome;
      FDQuery.Params.ParamByName('FG_COBRA_TAXA_SERVICO').AsString := IfThen(MercadoriaGrupo.CobraTaxaServico, 'S', 'N');
      FDQuery.ExecSQL;
    finally
      DestruirDataSet(FDQuery);
    end;
  except
    on E: Exception do
      raise Exception.CreateFmt(MSG_FALHA_AO_INSERIR_CLASSE_METODO_EXCEPTION,
        [Self.ClassName, 'Inserir', E.Message]);
  end;
end;

procedure TMercadoriaGrupoAcessoDados.Atualizar(MercadoriaGrupo: TMercadoriaGrupo);
var
  FDQuery: TFDQuery;
begin
  try
    ValidarParametroMercadoriaGrupoNulo(MercadoriaGrupo);

    FDQuery := CriarDataSet;
    try
      FDQuery.SQL.Text :=
        'UPDATE MERCADORIA_GRUPO SET '+
        '       DS_NOME = :DS_NOME '+
        '      ,FG_COBRA_TAXA_SERVICO = :FG_COBRA_TAXA_SERVICO '+
        'WHERE SEQ_MERCADORIA_GRUPO = :SEQ_MERCADORIA_GRUPO';
      FDQuery.Params.ParamByName('DS_NOME').AsString := MercadoriaGrupo.Nome;
      FDQuery.Params.ParamByName('FG_COBRA_TAXA_SERVICO').AsString := IfThen(MercadoriaGrupo.CobraTaxaServico, 'S', 'N');
      FDQuery.Params.ParamByName('SEQ_MERCADORIA_GRUPO').AsInteger := MercadoriaGrupo.Codigo;
      FDQuery.ExecSQL;
    finally
      DestruirDataSet(FDQuery);
    end;
  except
    on E: Exception do
      raise Exception.CreateFmt(MSG_FALHA_AO_ATUALIZAR_CLASSE_METODO_EXCEPTION,
        [Self.ClassName, 'Atualizar', E.Message]);
  end;
end;

function TMercadoriaGrupoAcessoDados.Obter(Codigo: Integer): TMercadoriaGrupo;
var
  FDQuery: TFDQuery;
begin
  Result := nil;

  try
    if (Codigo <= 0) then Exit;

    FDQuery := CriarDataSet;
    try
      FDQuery.SQL.Text :=
        'SELECT '+
        '       DS_NOME '+
        '      ,FG_COBRA_TAXA_SERVICO '+
        '  FROM DBO.MERCADORIA_GRUPO '+
        ' WHERE SEQ_MERCADORIA_GRUPO = :SEQ_MERCADORIA_GRUPO';
      FDQuery.Params.ParamByName('SEQ_MERCADORIA_GRUPO').AsInteger := Codigo;
      FDQuery.Open;

      if (not FDQuery.Eof) then
      begin
        Result := TMercadoriaGrupo.Create;
        Result.Codigo := Codigo;
        Result.Nome := FDQuery.FieldByName('DS_NOME').AsString;
        Result.CobraTaxaServico := (FDQuery.FieldByName('FG_COBRA_TAXA_SERVICO').AsString = 'S');
      end;
    finally
      DestruirDataSet(FDQuery);
    end;
  except
    on E: Exception do
      raise Exception.CreateFmt(MSG_FALHA_AO_OBTER_CLASSE_METODO_EXCEPTION,
        [Self.ClassName, 'Obter', E.Message]);
  end;
end;

procedure TMercadoriaGrupoAcessoDados.Excluir(Codigo: Integer);
var
  FDQuery: TFDQuery;
begin
  try
    if (Codigo <= 0) then Exit;

    FDQuery := CriarDataSet;
    try
      FDQuery.SQL.Text :=
        'DELETE FROM MERCADORIA_GRUPO '+
        'WHERE SEQ_MERCADORIA_GRUPO = :SEQ_MERCADORIA_GRUPO';
      FDQuery.Params.ParamByName('SEQ_MERCADORIA_GRUPO').AsInteger := Codigo;
      FDQuery.ExecSQL;
    finally
      DestruirDataSet(FDQuery);
    end;
  except
    on E: Exception do
      raise Exception.CreateFmt(MSG_FALHA_AO_EXCLUIR_CLASSE_METODO_EXCEPTION,
        [Self.ClassName, 'Excluir', E.Message]);
  end;
end;

procedure TMercadoriaGrupoAcessoDados.ValidarParametroMercadoriaGrupoNulo(MercadoriaGrupo: TMercadoriaGrupo);
begin
  if (not Assigned(MercadoriaGrupo)) then
    raise Exception.CreateFmt(MSG_PARAMETRO_ESTA_NULO, ['MercadoriaGrupo']);
end;

end.
