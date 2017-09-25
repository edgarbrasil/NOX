unit uMercadoriaAcessoDados;

interface

uses
  FireDAC.Stan.Param, FireDAC.Comp.Client, FireDAC.DApt, uAcessoDadosBase,
  uMercadoria, uMercadorias;

type
  TMercadoriaAcessoDados = class(TAcessoDadosBase)
  private
    { private declarations }
    procedure ValidarParametroMercadoriaNulo(Mercadoria: TMercadoria);
  public
    { public declarations }
    constructor Create(FDCustomConnection: TFDCustomConnection);
    destructor Destroy; override;

    function Obter(Codigo: Integer): TMercadoria; overload;
    function Obter(Nome: String): TMercadoria; overload;
    function ObterPorGrupo(CodigoGrupo: Integer): TMercadorias;
    procedure Inserir(Mercadoria: TMercadoria);
    procedure Atualizar(Mercadoria: TMercadoria);
    procedure Excluir(Codigo: Integer);
    procedure SubtrairEstoque(CodigoMercadoria, Quantidade: Integer);
  end;

implementation

uses StrUtils, SysUtils, uConstantes;

{ TMercadoriaAcessoDados }

constructor TMercadoriaAcessoDados.Create(FDCustomConnection: TFDCustomConnection);
begin
  inherited Create(FDCustomConnection);
end;

destructor TMercadoriaAcessoDados.Destroy;
begin

  inherited;
end;

procedure TMercadoriaAcessoDados.Inserir(Mercadoria: TMercadoria);
var
  FDQuery: TFDQuery;
begin
  try
    ValidarParametroMercadoriaNulo(Mercadoria);

    FDQuery := CriarDataSet;
    try
      FDQuery.SQL.Text :=
        'INSERT INTO MERCADORIA '+
        '      (SEQ_MERCADORIA '+
        '      ,DS_NOME '+
        '      ,VR_PRECO '+
        '      ,QT_ESTOQUE '+
        '      ,ID_MERCADORIA_GRUPO '+
        '      ,FG_COBRA_TAXA_SERVICO '+
        '      ,FG_VALIDAR_GRUPO) '+
        'VALUES '+
        '      (:SEQ_MERCADORIA '+
        '      ,:DS_NOME '+
        '      ,:VR_PRECO '+
        '      ,:QT_ESTOQUE '+
        '      ,:ID_MERCADORIA_GRUPO '+
        '      ,:FG_COBRA_TAXA_SERVICO '+
        '      ,:FG_VALIDAR_GRUPO) ';
      FDQuery.Params.ParamByName('SEQ_MERCADORIA').AsInteger := Mercadoria.Codigo;
      FDQuery.Params.ParamByName('DS_NOME').AsString := Mercadoria.Nome;
      FDQuery.Params.ParamByName('VR_PRECO').AsFloat := Mercadoria.Preco;
      FDQuery.Params.ParamByName('QT_ESTOQUE').AsInteger := Mercadoria.QuantidadeEstoque;
      FDQuery.Params.ParamByName('ID_MERCADORIA_GRUPO').AsInteger := Mercadoria.CodigoMercadoriaGrupo;
      FDQuery.Params.ParamByName('FG_COBRA_TAXA_SERVICO').AsString := IfThen(Mercadoria.CobraTaxaServico, 'S', 'N');
      FDQuery.Params.ParamByName('FG_VALIDAR_GRUPO').AsString := IfThen(Mercadoria.ValidarGrupo, 'S', 'N');
      FDQuery.ExecSQL;
    finally
      DestruirDataSet(FDQuery);
    end;
  except
    on E: Exception do
      raise Exception.CreateFmt(MSG_FALHA_AO_INSERIR_CLASSE_METODO_EXCEPTION,
        ['TMercadoriaAcessoDados', 'Inserir', E.Message]);
  end;
end;

procedure TMercadoriaAcessoDados.Atualizar(Mercadoria: TMercadoria);
var
  FDQuery: TFDQuery;
begin
  try
    ValidarParametroMercadoriaNulo(Mercadoria);

    FDQuery := CriarDataSet;
    try
      FDQuery.SQL.Text :=
        'UPDATE MERCADORIA SET '+
        '       DS_NOME = :DS_NOME '+
        '      ,VR_PRECO = :VR_PRECO '+
        '      ,ID_MERCADORIA_GRUPO = :ID_MERCADORIA_GRUPO '+
        '      ,FG_COBRA_TAXA_SERVICO = :FG_COBRA_TAXA_SERVICO '+
        '      ,FG_VALIDAR_GRUPO = :FG_VALIDAR_GRUPO '+
        'WHERE SEQ_MERCADORIA = :SEQ_MERCADORIA)';
      FDQuery.Params.ParamByName('DS_nome').AsString := Mercadoria.Nome;
      FDQuery.Params.ParamByName('VR_PRECO').AsFloat := Mercadoria.Preco;
      //
      // esse campo não é atualizado por aqui, apenas quando está inserindo ou quando está vendendo
      //FDQuery.Params.ParamByName('QT_ESTOQUE').AsInteger := Mercadoria.QuantidadeEstoque;
      FDQuery.Params.ParamByName('ID_MERCADORIA_GRUPO').AsInteger := Mercadoria.CodigoMercadoriaGrupo;
      FDQuery.Params.ParamByName('FG_COBRA_TAXA_SERVICO').AsString := IfThen(Mercadoria.CobraTaxaServico, 'S', 'N');
      FDQuery.Params.ParamByName('FG_VALIDAR_GRUPO').AsString := IfThen(Mercadoria.ValidarGrupo, 'S', 'N');
      FDQuery.Params.ParamByName('SEQ_MERCADORIA').AsInteger := Mercadoria.Codigo;
      FDQuery.ExecSQL;
    finally
      DestruirDataSet(FDQuery);
    end;
  except
    on E: Exception do
      raise Exception.CreateFmt(MSG_FALHA_AO_ATUALIZAR_CLASSE_METODO_EXCEPTION,
        ['TMercadoriaAcessoDados', 'Atualizar', E.Message]);
  end;
end;

procedure TMercadoriaAcessoDados.SubtrairEstoque(CodigoMercadoria, Quantidade: Integer);
var
  FDQuery: TFDQuery;
begin
  try
    if (Quantidade <= 0) then Exit;    

    FDQuery := CriarDataSet;
    try
      FDQuery.SQL.Text :=
        'UPDATE MERCADORIA SET '+
        '       QT_ESTOQUE = QT_ESTOQUE - ' + IntToStr(Quantidade)+
        ' WHERE SEQ_MERCADORIA = :SEQ_MERCADORIA';
      FDQuery.Params.ParamByName('SEQ_MERCADORIA').AsInteger := CodigoMercadoria;
      FDQuery.ExecSQL;
    finally
      DestruirDataSet(FDQuery);
    end;
  except
    on E: Exception do
      raise Exception.CreateFmt(MSG_FALHA_AO_ATUALIZAR_CLASSE_METODO_EXCEPTION,
        ['TMercadoriaAcessoDados', 'Atualizar', E.Message]);
  end;
end;

function TMercadoriaAcessoDados.Obter(Codigo: Integer): TMercadoria;
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
        '      ,VR_PRECO '+
        '      ,QT_ESTOQUE '+
        '      ,ID_MERCADORIA_GRUPO '+
        '      ,FG_COBRA_TAXA_SERVICO '+
        '      ,FG_VALIDAR_GRUPO '+
        '  FROM MERCADORIA '+
        ' WHERE SEQ_MERCADORIA = :SEQ_MERCADORIA';
      FDQuery.Params.ParamByName('SEQ_MERCADORIA').AsInteger := Codigo;
      FDQuery.Open;

      if (not FDQuery.Eof) then
      begin
        Result := TMercadoria.Create;
        Result.Codigo := Codigo;
        Result.Nome := FDQuery.FieldByName('DS_NOME').AsString;
        Result.Preco := FDQuery.FieldByName('VR_PRECO').AsCurrency;
        Result.QuantidadeEstoque := FDQuery.FieldByName('QT_ESTOQUE').AsInteger;
        Result.CodigoMercadoriaGrupo := FDQuery.FieldByName('ID_MERCADORIA_GRUPO').AsInteger;
        Result.CobraTaxaServico := (FDQuery.FieldByName('FG_COBRA_TAXA_SERVICO').AsString = 'S');
        Result.ValidarGrupo := (FDQuery.FieldByName('FG_VALIDAR_GRUPO').AsString = 'S');
      end;
    finally
      DestruirDataSet(FDQuery);
    end;
  except
    on E: Exception do
      raise Exception.CreateFmt(MSG_FALHA_AO_OBTER_CLASSE_METODO_EXCEPTION,
        ['TMercadoriaAcessoDados', 'Obter', E.Message]);
  end;
end;

function TMercadoriaAcessoDados.Obter(Nome: String): TMercadoria;
var
  FDQuery: TFDQuery;
begin
  Result := nil;

  try
    if (Trim(Nome) = EmptyStr) then Exit;

    FDQuery := CriarDataSet;
    try
      FDQuery.SQL.Text :=
        'SELECT '+
        '       SEQ_MERCADORIA '+
        '      ,VR_PRECO '+
        '      ,QT_ESTOQUE '+
        '      ,ID_MERCADORIA_GRUPO '+
        '      ,FG_COBRA_TAXA_SERVICO '+
        '      ,FG_VALIDAR_GRUPO '+
        '  FROM MERCADORIA '+
        ' WHERE DS_NOME = :DS_NOME';
      FDQuery.Params.ParamByName('DS_NOME').AsString := Trim(Nome);
      FDQuery.Open;

      if (not FDQuery.Eof) then
      begin
        Result := TMercadoria.Create;
        Result.Codigo := FDQuery.FieldByName('SEQ_MERCADORIA').AsInteger;
        Result.Nome := Trim(Nome);
        Result.Preco := FDQuery.FieldByName('VR_PRECO').AsCurrency;
        Result.QuantidadeEstoque := FDQuery.FieldByName('QT_ESTOQUE').AsInteger;
        Result.CodigoMercadoriaGrupo := FDQuery.FieldByName('ID_MERCADORIA_GRUPO').AsInteger;
        Result.CobraTaxaServico := (FDQuery.FieldByName('FG_COBRA_TAXA_SERVICO').AsString = 'S');
        Result.ValidarGrupo := (FDQuery.FieldByName('FG_VALIDAR_GRUPO').AsString = 'S');
      end;
    finally
      DestruirDataSet(FDQuery);
    end;
  except
    on E: Exception do
      raise Exception.CreateFmt(MSG_FALHA_AO_OBTER_CLASSE_METODO_EXCEPTION,
        ['TMercadoriaAcessoDados', 'Obter', E.Message]);
  end;
end;

function TMercadoriaAcessoDados.ObterPorGrupo(CodigoGrupo: Integer): TMercadorias;
var
  FDQuery: TFDQuery;
begin
  Result := nil;

  try
    if (CodigoGrupo <= 0) then Exit;

    FDQuery := CriarDataSet;
    try
      FDQuery.SQL.Text :=
        'SELECT '+
        '       SEQ_MERCADORIA '+
        '      ,DS_NOME '+
        '      ,VR_PRECO '+
        '      ,QT_ESTOQUE '+
        '      ,FG_COBRA_TAXA_SERVICO '+
        '      ,FG_VALIDAR_GRUPO '+
        '  FROM MERCADORIA '+
        ' WHERE ID_MERCADORIA_GRUPO = :ID_MERCADORIA_GRUPO';
      FDQuery.Params.ParamByName('ID_MERCADORIA_GRUPO').AsInteger := CodigoGrupo;
      FDQuery.Open;

      if (not FDQuery.Eof) then
      begin
        Result := TMercadorias.Create;

        while (not FDQuery.Eof) do
        begin
          Result.AdicionarMercadoria(
            TMercadoria.CriarInstancia(
              FDQuery.FieldByName('SEQ_MERCADORIA').AsInteger,
              FDQuery.FieldByName('DS_NOME').AsString,
              FDQuery.FieldByName('VR_PRECO').AsCurrency,
              FDQuery.FieldByName('QT_ESTOQUE').AsInteger,
              FDQuery.FieldByName('ID_MERCADORIA_GRUPO').AsInteger,
              (FDQuery.FieldByName('FG_COBRA_TAXA_SERVICO').AsString = 'S'),
              (FDQuery.FieldByName('FG_VALIDAR_GRUPO').AsString = 'S')));

          FDQuery.Next;
        end;
      end;
    finally
      DestruirDataSet(FDQuery);
    end;
  except
    on E: Exception do
      raise Exception.CreateFmt(MSG_FALHA_AO_OBTER_CLASSE_METODO_EXCEPTION,
        ['TMercadoriaAcessoDados', 'Obter', E.Message]);
  end;
end;

procedure TMercadoriaAcessoDados.Excluir(Codigo: Integer);
var
  FDQuery: TFDQuery;
begin
  try
    if (Codigo <= 0) then Exit;

    FDQuery := CriarDataSet;
    try
      FDQuery.SQL.Text :=
        'DELETE FROM MERCADORIA '+
        'WHERE SEQ_MERCADORIA = :SEQ_MERCADORIA';
      FDQuery.Params.ParamByName('SEQ_MERCADORIA').AsInteger := Codigo;
      FDQuery.ExecSQL;
    finally
      DestruirDataSet(FDQuery);
    end;
  except
    on E: Exception do
      raise Exception.CreateFmt(MSG_FALHA_AO_EXCLUIR_CLASSE_METODO_EXCEPTION,
        ['TMercadoriaAcessoDados', 'Excluir', E.Message]);
  end;
end;

procedure TMercadoriaAcessoDados.ValidarParametroMercadoriaNulo(Mercadoria: TMercadoria);
begin
  if (not Assigned(Mercadoria)) then
    raise Exception.CreateFmt(MSG_PARAMETRO_ESTA_NULO, ['Mercadoria']);
end;

end.
