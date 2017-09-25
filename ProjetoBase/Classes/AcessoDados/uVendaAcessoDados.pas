unit uVendaAcessoDados;

interface

uses FireDAC.Stan.Param, FireDAC.Comp.Client, FireDAC.DApt, uAcessoDadosBase,
  uVenda, uVendaItem, uVendaItens, uCliente, uMercadoriaFuncoes;

type
  { TVendaAcessoDados }
  TVendaAcessoDados = class(TAcessoDadosBase)
  private
    { private declarations }
    function ObterVendaCliente(CodigoCliente: Integer): TCliente;
    function ObterVendaItens(CodigoVenda: Integer): TVendaItens;
    procedure InserirVendaItens(VendaItens: TVendaItens);
    procedure ValidarParametroVendaNulo(Venda: TVenda);
  public
    { public declarations }
    constructor Create(FDCustomConnection: TFDCustomConnection);
    destructor Destroy; override;

    function Obter(Codigo: Integer): TVenda;
    procedure Inserir(Venda: TVenda);
    procedure Excluir(Codigo: Integer);
  end;

implementation

uses SysUtils, uConstantes, uClienteAcessoDados, uVendaItemAcessoDados;

{ TVendaAcessoDados }

constructor TVendaAcessoDados.Create(FDCustomConnection: TFDCustomConnection);
begin
  inherited Create(FDCustomConnection);
end;

destructor TVendaAcessoDados.Destroy;
begin

  inherited;
end;

procedure TVendaAcessoDados.Inserir(Venda: TVenda);
var
  FDQuery: TFDQuery;
begin
  try
    ValidarParametroVendaNulo(Venda);

    FDQuery := CriarDataSet;
    try
      FDQuery.SQL.Text :=
        'INSERT INTO VENDA '+
        '           (SEQ_VENDA '+
        '           ,DT_VENDA '+
        '           ,ID_CLIENTE '+
        '           ,VR_DESCONTO '+
        '           ,PC_TAXA_SERVICO '+
        '           ,VR_TOTAL) '+
        '     VALUES '+
        '           (:SEQ_VENDA '+
        '           ,:DT_VENDA '+
        '           ,:ID_CLIENTE '+
        '           ,:VR_DESCONTO '+
        '           ,:PC_TAXA_SERVICO '+
        '           ,:VR_TOTAL) ';
      FDQuery.Params.ParamByName('SEQ_VENDA').AsInteger := Venda.Codigo;
      FDQuery.Params.ParamByName('DT_VENDA').AsDateTime := Venda.Data;
      FDQuery.Params.ParamByName('ID_CLIENTE').AsInteger := Venda.Cliente.Codigo;
      FDQuery.Params.ParamByName('VR_DESCONTO').AsFloat := Venda.ValorDesconto;
      FDQuery.Params.ParamByName('PC_TAXA_SERVICO').AsFloat := Venda.TaxaServico;
      FDQuery.Params.ParamByName('VR_TOTAL').AsFloat := Venda.ValorTotal;

      StartTransaction;
      try
        FDQuery.ExecSQL;

        InserirVendaItens(Venda.VendaItens);

        Commit;
      except
        on E: Exception do
        begin
          Rollback;
          raise;
        end;
      end;
    finally
      DestruirDataSet(FDQuery);
    end;
  except
    on E: Exception do
      raise Exception.CreateFmt(MSG_FALHA_AO_INSERIR_CLASSE_METODO_EXCEPTION,
        ['TVendaAcessoDados', 'Inserir', E.Message]);
  end;
end;

function TVendaAcessoDados.Obter(Codigo: Integer): TVenda;
var
  FDQuery: TFDQuery;
begin
  try
    Result := nil;

    if (Codigo <= 0) then Exit;

    FDQuery := CriarDataSet;
    try
      FDQuery.SQL.Text :=
        'SELECT DT_VENDA '+
        '      ,ID_CLIENTE '+
        '      ,VR_DESCONTO '+
        '      ,PC_TAXA_SERVICO '+
        '      ,VR_TOTAL '+
        '  FROM VENDA '+
        ' WHERE SEQ_VENDA = :SEQ_VENDA';
      FDQuery.Params.ParamByName('SEQ_VENDA').AsInteger := Codigo;
      FDQuery.Open;

      if (not FDQuery.Eof) then
      begin
        Result := TVenda.Create;
        Result.Codigo := Codigo;
        Result.Data := FDQuery.FieldByName('DT_VENDA').AsDateTime;
        Result.ValorDesconto := FDQuery.FieldByName('VR_DESCONTO').AsCurrency;
        Result.TaxaServico := FDQuery.FieldByName('PC_TAXA_SERVICO').AsFloat;
        Result.ValorTotal := FDQuery.FieldByName('VR_TOTAL').AsCurrency;
        Result.Cliente := ObterVendaCliente(FDQuery.FieldByName('ID_CLIENTE').AsInteger);
        Result.VendaItens := ObterVendaItens(Codigo);
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

function TVendaAcessoDados.ObterVendaCliente(CodigoCliente: Integer): TCliente;
var
  ClienteAcessoDados: TClienteAcessoDados;
begin
  ClienteAcessoDados := TClienteAcessoDados.Create(ObterConnection);
  try
    Result := ClienteAcessoDados.Obter(CodigoCliente);
  finally
    FreeAndNil(ClienteAcessoDados);
  end;
end;

function TVendaAcessoDados.ObterVendaItens(CodigoVenda: Integer): TVendaItens;
var
  VendaItemAcessoDados: TVendaItemAcessoDados;
begin
  VendaItemAcessoDados := TVendaItemAcessoDados.Create(ObterConnection);
  try
    Result := VendaItemAcessoDados.Obter(CodigoVenda);
  finally
    FreeAndNil(VendaItemAcessoDados);
  end;
end;

procedure TVendaAcessoDados.InserirVendaItens(VendaItens: TVendaItens);
var
  i: Integer;
  VendaItemAcessoDados: TVendaItemAcessoDados;
  MercadoriaFuncoes: TMercadoriaFuncoes;
begin
  MercadoriaFuncoes := TMercadoriaFuncoes.Create(ObterConnection);
  try
    VendaItemAcessoDados := TVendaItemAcessoDados.Create(ObterConnection);
    try
      for i := 0 to VendaItens.Quantidade - 1 do
      begin
        VendaItemAcessoDados.Inserir(VendaItens.ObterVendaItem(i));
        MercadoriaFuncoes.SubtrairEstoque(VendaItens.ObterVendaItem(i).CodigoMercadoria, VendaItens.ObterVendaItem(i).Quantidade);
      end;
    finally
      FreeAndNil(VendaItemAcessoDados);
    end;
  finally
    FreeAndNil(VendaItemAcessoDados);
  end;
end;

procedure TVendaAcessoDados.Excluir(Codigo: Integer);
var
  FDQuery: TFDQuery;
begin
  try
    if (Codigo <= 0) then Exit;

    FDQuery := CriarDataSet;
    try
      FDQuery.SQL.Text :=
        'DELETE FROM VENDA_ITEM '+
        'WHERE ID_VENDA = :ID_VENDA';
      FDQuery.Params.ParamByName('ID_VENDA').AsInteger := Codigo;

      StartTransaction;
      try
        FDQuery.ExecSQL;

        FDQuery.SQL.Clear;
        FDQuery.SQL.Text :=
          'DELETE FROM VENDA '+
          'WHERE SEQ_VENDA = :SEQ_VENDA';
        FDQuery.Params.ParamByName('SEQ_VENDA').AsInteger := Codigo;

        FDQuery.ExecSQL;

        Commit;
      except
        on E: Exception do
        begin
          Rollback;
          raise;
        end;
      end;
    finally
      DestruirDataSet(FDQuery);
    end;
  except
    on E: Exception do
      raise Exception.CreateFmt(MSG_FALHA_AO_EXCLUIR_CLASSE_METODO_EXCEPTION,
        [Self.ClassName, 'Excluir', E.Message]);
  end;
end;

procedure TVendaAcessoDados.ValidarParametroVendaNulo(Venda: TVenda);
begin
  if (not Assigned(Venda)) then
    raise Exception.CreateFmt(MSG_PARAMETRO_ESTA_NULO, ['Venda']);
end;

end.
