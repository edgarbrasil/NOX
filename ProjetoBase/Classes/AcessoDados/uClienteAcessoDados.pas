unit uClienteAcessoDados;

interface

uses FireDAC.Stan.Param, FireDAC.Comp.Client, FireDAC.DApt, uAcessoDadosBase, uCliente;

type
  TClienteAcessoDados = class(TAcessoDadosBase)
  private
    { private declarations }
    procedure ValidarParametroClienteNulo(Cliente: TCliente);
  public
    { public declarations }
    constructor Create(FDCustomConnection: TFDCustomConnection);
    destructor Destroy; override;

    function Obter(Codigo: Integer): TCliente;
    procedure Inserir(Cliente: TCliente);
    procedure Atualizar(Cliente: TCliente);
    procedure Excluir(Codigo: Integer);
  end;

implementation

uses SysUtils, uConstantes;

{ TClienteAcessoDados }

constructor TClienteAcessoDados.Create;
begin
  inherited Create(FDCustomConnection);
end;

destructor TClienteAcessoDados.Destroy;
begin

  inherited;
end;

procedure TClienteAcessoDados.ValidarParametroClienteNulo(Cliente: TCliente);
begin
  if (not Assigned(Cliente)) then
    raise Exception.CreateFmt(MSG_PARAMETRO_ESTA_NULO, ['Cliente']);
end;

procedure TClienteAcessoDados.Inserir(Cliente: TCliente);
var
  FDQuery: TFDQuery;
begin
  try
    ValidarParametroClienteNulo(Cliente);

    FDQuery := CriarDataSet;
    try
      FDQuery.SQL.Text :=
        'INSERT INTO cliente '+
        '      (SEQ_cliente '+
        '      ,DS_nome) '+
        'VALUES '+
        '      (:SEQ_cliente '+
        '      ,:DS_nome)';
      FDQuery.Params.ParamByName('SEQ_cliente').AsInteger := Cliente.Codigo;
      FDQuery.Params.ParamByName('DS_nome').AsString := Cliente.Nome;
      FDQuery.ExecSQL;
    finally
      DestruirDataSet(FDQuery);
    end;
  except
    on E: Exception do
      raise Exception.CreateFmt(MSG_FALHA_AO_INSERIR_CLASSE_METODO_EXCEPTION,
        ['TClienteAcessoDados', 'Inserir', E.Message]);
  end;
end;

procedure TClienteAcessoDados.Atualizar(Cliente: TCliente);
var
  FDQuery: TFDQuery;
begin
  try
    ValidarParametroClienteNulo(Cliente);

    FDQuery := CriarDataSet;
    try
      FDQuery.SQL.Text :=
        'UPDATE cliente SET '+
        'DS_nome = :DS_nome '+
        'WHERE SEQ_cliente = :SEQ_cliente';
      FDQuery.Params.ParamByName('DS_nome').AsString := Cliente.Nome;
      FDQuery.Params.ParamByName('SEQ_cliente').AsInteger := Cliente.Codigo;
      FDQuery.ExecSQL;
    finally
      DestruirDataSet(FDQuery);
    end;
  except
    on E: Exception do
      raise Exception.CreateFmt(MSG_FALHA_AO_ATUALIZAR_CLASSE_METODO_EXCEPTION,
        ['TClienteAcessoDados', 'Atualizar', E.Message]);
  end;
end;

procedure TClienteAcessoDados.Excluir(Codigo: Integer);
var
  FDQuery: TFDQuery;
begin
  try
    if (Codigo <= 0) then Exit;

    FDQuery := CriarDataSet;
    try
      FDQuery.SQL.Text :=
        'delete from cliente '+
        'WHERE SEQ_cliente = :SEQ_cliente';
      FDQuery.Params.ParamByName('SEQ_cliente').AsInteger := Codigo;
      FDQuery.ExecSQL;
    finally
      DestruirDataSet(FDQuery);
    end;
  except
    on E: Exception do
      raise Exception.CreateFmt(MSG_FALHA_AO_EXCLUIR_CLASSE_METODO_EXCEPTION,
        ['TClienteAcessoDados', 'Excluir', E.Message]);
  end;
end;

function TClienteAcessoDados.Obter(Codigo: Integer): TCliente;
var
  FDQuery: TFDQuery;
begin
  Result := nil;

  try
    if (Codigo <= 0) then Exit;

    FDQuery := CriarDataSet;
    try
      FDQuery.SQL.Text :=
        'SELECT DS_nome '+
        'FROM cliente '+
        'WHERE SEQ_cliente = :SEQ_cliente';
      FDQuery.Params.ParamByName('SEQ_cliente').AsInteger := Codigo;
      FDQuery.Open;

      if (not FDQuery.Eof) then
      begin
        Result := TCliente.Create;
        Result.Codigo := Codigo;
        Result.Nome := FDQuery.FieldByName('DS_nome').AsString;
      end;
    finally
      DestruirDataSet(FDQuery);
    end;
  except
    on E: Exception do
      raise Exception.CreateFmt(MSG_FALHA_AO_OBTER_CLASSE_METODO_EXCEPTION,
        ['TClienteAcessoDados', 'Obter', E.Message]);
  end;
end;

end.
