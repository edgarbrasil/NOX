unit uVendaItemAcessoDados;

interface

uses FireDAC.Stan.Param, FireDAC.Comp.Client, FireDAC.DApt, uAcessoDadosBase, uVendaItem, uVendaItens;

type
  { TVendaItemAcessoDados }
  TVendaItemAcessoDados = class(TAcessoDadosBase)
  private
    { private declarations }
    procedure ValidarParametroVendaItemNulo(VendaItem: TVendaItem);
  public
    { public declarations }
    constructor Create(FDCustomConnection: TFDCustomConnection);
    destructor Destroy; override;

    function Obter(CodigoVenda: Integer): TVendaItens;
    procedure Inserir(VendaItem: TVendaItem);
    procedure Atualizar(VendaItem: TVendaItem);
    procedure Excluir(Codigo: Integer);
    procedure ExcluirVendaItens(CodigoVenda: Integer);
  end;

implementation

uses SysUtils, uConstantes;

{ TVendaItemAcessoDados }

constructor TVendaItemAcessoDados.Create(FDCustomConnection: TFDCustomConnection);
begin
  inherited Create(FDCustomConnection);
end;

destructor TVendaItemAcessoDados.Destroy;
begin

  inherited;
end;

procedure TVendaItemAcessoDados.Inserir(VendaItem: TVendaItem);
var
  FDQuery: TFDQuery;
begin
  try
    ValidarParametroVendaItemNulo(VendaItem);

    FDQuery := CriarDataSet;
    try
      FDQuery.SQL.Text :=
        'INSERT INTO VENDA_ITEM '+
        '           (SEQ_VENDA_ITEM '+
        '           ,ID_VENDA '+
        '           ,ID_MERCADORIA '+
        '           ,QT_VENDIDA '+
        '           ,VD_VALOR) '+
        '     VALUES '+
        '           (:SEQ_VENDA_ITEM '+
        '           ,:ID_VENDA '+
        '           ,:ID_MERCADORIA '+
        '           ,:QT_VENDIDA '+
        '           ,:VD_VALOR) ';
      FDQuery.Params.ParamByName('SEQ_VENDA_ITEM').AsInteger := VendaItem.Codigo;
      FDQuery.Params.ParamByName('ID_VENDA').AsInteger := VendaItem.CodigoVenda;
      FDQuery.Params.ParamByName('ID_MERCADORIA').AsInteger := VendaItem.CodigoMercadoria;
      FDQuery.Params.ParamByName('QT_VENDIDA').AsInteger := VendaItem.Quantidade;
      FDQuery.Params.ParamByName('VD_VALOR').AsFloat := VendaItem.Valor;
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

procedure TVendaItemAcessoDados.Atualizar(VendaItem: TVendaItem);
var
  FDQuery: TFDQuery;
begin
  try
    ValidarParametroVendaItemNulo(VendaItem);

    FDQuery := CriarDataSet;
    try
      FDQuery.SQL.Text :=
        'UPDATE VENDA_ITEM SET '+
        '       ID_MERCADORIA = :ID_MERCADORIA '+
        '      ,QT_VENDIDA = :QT_VENDIDA '+
        '      ,VD_VALOR = :VD_VALOR '+
        ' WHERE SEQ_VENDA_ITEM = :SEQ_VENDA_ITEM '+
        '   AND ID_VENDA = :ID_VENDA ';
      FDQuery.Params.ParamByName('ID_MERCADORIA').AsInteger := VendaItem.CodigoMercadoria;
      FDQuery.Params.ParamByName('QT_VENDIDA').AsInteger := VendaItem.Quantidade;
      FDQuery.Params.ParamByName('VD_VALOR').AsFloat := VendaItem.Valor;
      FDQuery.Params.ParamByName('SEQ_VENDA_ITEM').AsInteger := VendaItem.Codigo;
      FDQuery.Params.ParamByName('ID_VENDA').AsInteger := VendaItem.CodigoVenda;
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

function TVendaItemAcessoDados.Obter(CodigoVenda: Integer): TVendaItens;
var
  FDQuery: TFDQuery;
begin
  try
    Result := nil;

    if (CodigoVenda <= 0) then Exit;

    FDQuery := CriarDataSet;
    try
      FDQuery.SQL.Text :=
        'SELECT SEQ_VENDA_ITEM '+
        '      ,ID_MERCADORIA '+
        '      ,QT_VENDIDA '+
        '      ,VD_VALOR '+
        '  FROM dbo.VENDA_ITEM '+
        ' WHERE ID_VENDA = :ID_VENDA';
      FDQuery.Params.ParamByName('ID_VENDA').AsInteger := CodigoVenda;
      FDQuery.Open;

      if (not FDQuery.Eof) then
      begin
        Result := TVendaItens.Create;

        while (not FDQuery.Eof) do
        begin
          Result.AdicionarVendaItem(
            TVendaItem.CriarInstancia(
              FDQuery.FieldByName('SEQ_VENDA_ITEM').AsInteger,
              CodigoVenda,
              FDQuery.FieldByName('ID_MERCADORIA').AsInteger,
              FDQuery.FieldByName('QT_VENDIDA').AsInteger,
              FDQuery.FieldByName('VD_VALOR').AsCurrency));

          FDQuery.next;
        end;
      end;
    finally
      DestruirDataSet(FDQuery);
    end;
  except
    on E: Exception do
      raise Exception.CreateFmt(MSG_FALHA_AO_ATUALIZAR_CLASSE_METODO_EXCEPTION,
        [Self.ClassName, 'Atualizar', E.Message]);
  end;
end;

procedure TVendaItemAcessoDados.Excluir(Codigo: Integer);
var
  FDQuery: TFDQuery;
begin
  try
    if (Codigo <= 0) then Exit;

    FDQuery := CriarDataSet;
    try
      FDQuery.SQL.Text :=
        'DELETE FROM VENDA_ITEM '+
        'WHERE SEQ_VENDA_ITEM = :SEQ_VENDA_ITEM';
      FDQuery.Params.ParamByName('SEQ_VENDA_ITEM').AsInteger := Codigo;
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

procedure TVendaItemAcessoDados.ExcluirVendaItens(CodigoVenda: Integer);
var
  FDQuery: TFDQuery;
begin
  try
    if (CodigoVenda <= 0) then Exit;

    FDQuery := CriarDataSet;
    try
      FDQuery.SQL.Text :=
        'DELETE FROM VENDA_ITEM '+
        'WHERE ID_VENDA = :ID_VENDA';
      FDQuery.Params.ParamByName('ID_VENDA').AsInteger := CodigoVenda;
      FDQuery.ExecSQL;
    finally
      DestruirDataSet(FDQuery);
    end;
  except
    on E: Exception do
      raise Exception.CreateFmt(MSG_FALHA_AO_EXCLUIR_CLASSE_METODO_EXCEPTION,
        [Self.ClassName, 'ExcluirVendaItens', E.Message]);
  end;
end;

procedure TVendaItemAcessoDados.ValidarParametroVendaItemNulo(VendaItem: TVendaItem);
begin
  if (not Assigned(VendaItem)) then
    raise Exception.CreateFmt(MSG_PARAMETRO_ESTA_NULO, ['VendaItem']);
end;

end.
