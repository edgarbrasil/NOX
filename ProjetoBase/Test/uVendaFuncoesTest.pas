unit uVendaFuncoesTest;

interface

uses
  TestFramework, uVenda, uCliente, uVendaItens;

type
  TestTVendaFuncoes = class(TTestCase)
  strict private
  private
    FCodigoGrupoMercadoriaCobra,
    FCodigoGrupoMercadoriaNaoCobra,
    FCodigoCliente,
    FCodigoMercadoria1,
    FCodigoMercadoria2,
    FCodigoMercadoria3,
    FCodigoMercadoria4: Integer;
    procedure InserirCliente;
    procedure InserirMercadoriaGrupo;
    procedure InserirMercadoria;
    procedure InserirVenda;
    function ObterVenda: TVenda;
    function ObterCliente(Codigo: Integer): TCliente;
    function ObterItens(CodigoVenda: Integer): TVendaItens;
    function ObterValorAtualMercadoria(CodigoMercadoria: Integer): Currency;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestarProcesso;
  end;

implementation

uses
  SysUtils, uConexaoBD, uUtil, uClienteFuncoes, uMercadoriaGrupoFuncoes,
  uMercadoriaGrupo, uMercadoriaFuncoes, uMercadoria, uVendaFuncoes, uVendaItem;

procedure TestTVendaFuncoes.SetUp;
begin
end;

procedure TestTVendaFuncoes.TearDown;
begin
end;

procedure TestTVendaFuncoes.TestarProcesso;
begin
  InserirCliente;
  InserirMercadoriaGrupo;
  InserirMercadoria;
  InserirVenda;
end;

procedure TestTVendaFuncoes.InserirVenda;
var
  VendaFuncoes: TVendaFuncoes;
begin
  VendaFuncoes := TVendaFuncoes.Create(FDConnection);
  try
    VendaFuncoes.Inserir(ObterVenda);
  finally
    FreeAndNIl(VendaFuncoes);
  end;
end;

function TestTVendaFuncoes.ObterVenda: TVenda;
begin
  Result := TVenda.Create;
  Result.Codigo := ObterProximoSequence('VENDA_GEN');
  Result.Data := Now;
  Result.ValorDesconto := 7;
  Result.TaxaServico := 5; //adicionar no data ao inserir o cálculo da taxa de serviço
  //
  //o campo de valor total vai ser calculado quando adicionar os itens da venda
  //Result.ValorTotal := 0;
  Result.Cliente := ObterCliente(FCodigoCliente);
  Result.VendaItens := ObterItens(Result.Codigo);
end;

function TestTVendaFuncoes.ObterItens(CodigoVenda: Integer): TVendaItens;
begin
  Result := TVendaItens.Create;
  Result.AdicionarVendaItem(
    TVendaItem.CriarInstancia(
      ObterProximoSequence('VENDA_ITEM_GEN'),
      CodigoVenda,
      FCodigoMercadoria1,
      1,
      ObterValorAtualMercadoria(FCodigoMercadoria1)));

  Result.AdicionarVendaItem(
    TVendaItem.CriarInstancia(
      ObterProximoSequence('VENDA_ITEM_GEN'),
      CodigoVenda,
      FCodigoMercadoria2,
      1,
      ObterValorAtualMercadoria(FCodigoMercadoria2)));

  Result.AdicionarVendaItem(
    TVendaItem.CriarInstancia(
      ObterProximoSequence('VENDA_ITEM_GEN'),
      CodigoVenda,
      FCodigoMercadoria3,
      1,
      ObterValorAtualMercadoria(FCodigoMercadoria3)));

  Result.AdicionarVendaItem(
    TVendaItem.CriarInstancia(
      ObterProximoSequence('VENDA_ITEM_GEN'),
      CodigoVenda,
      FCodigoMercadoria4,
      1,
      ObterValorAtualMercadoria(FCodigoMercadoria4)));
end;

{$REGION 'CLIENTE'}
procedure TestTVendaFuncoes.InserirCliente;
var
  Cliente: TCliente;
  ClienteFuncoes: TClienteFuncoes;
begin
  ClienteFuncoes := TClienteFuncoes.Create(FDConnection);
  try
    Cliente := TCliente.Create;
    try
      FCodigoCliente := ObterProximoSequence('CLIENTE_GEN');
      Cliente.Codigo := FCodigoCliente;
      Cliente.Nome := 'Cliente Teste';

      ClienteFuncoes.Inserir(Cliente);
    finally
      FreeAndNil(Cliente);
    end;
  finally
    FreeAndNil(ClienteFuncoes);
  end;
end;

function TestTVendaFuncoes.ObterCliente(Codigo: Integer): TCliente;
var
  ClienteFuncoes: TClienteFuncoes;
begin
  ClienteFuncoes := TClienteFuncoes.Create(FDConnection);
  try
    Result := ClienteFuncoes.Obter(Codigo);
  finally
    FreeAndNil(ClienteFuncoes);
  end;
end;
{$ENDREGION 'CLIENTE'}
{$REGION 'GRUPO_MERCADORIA'}
procedure TestTVendaFuncoes.InserirMercadoriaGrupo;
var
  MercadoriaGrupo: TMercadoriaGrupo;
  MercadoriaGrupoFuncoes: TMercadoriaGrupoFuncoes;
begin
  MercadoriaGrupoFuncoes := TMercadoriaGrupoFuncoes.Create(FDConnection);
  try
    MercadoriaGrupo := TMercadoriaGrupo.Create;
    try
      FCodigoGrupoMercadoriaCobra := ObterProximoSequence('MERCADORIA_GRUPO_GEN');

      MercadoriaGrupo.Codigo := FCodigoGrupoMercadoriaCobra;
      MercadoriaGrupo.Nome := 'Mercadoria Grupo Teste 1';
      MercadoriaGrupo.CobraTaxaServico := True;

      MercadoriaGrupoFuncoes.Inserir(MercadoriaGrupo);
    finally
      FreeAndNil(MercadoriaGrupo);
    end;

    MercadoriaGrupo := TMercadoriaGrupo.Create;
    try
      FCodigoGrupoMercadoriaNaoCobra := ObterProximoSequence('MERCADORIA_GRUPO_GEN');
      MercadoriaGrupo.Codigo := FCodigoGrupoMercadoriaNaoCobra;
      MercadoriaGrupo.Nome := 'Mercadoria Grupo Teste 2';
      MercadoriaGrupo.CobraTaxaServico := False;

      MercadoriaGrupoFuncoes.Inserir(MercadoriaGrupo);
    finally
      FreeAndNil(MercadoriaGrupo);
    end;
  finally
    FreeAndNil(MercadoriaGrupoFuncoes);
  end;
end;
{$ENDREGION 'GRUPO_MERCADORIA'}
{$REGION 'MERCADORIA'}
procedure TestTVendaFuncoes.InserirMercadoria;
var
  Mercadoria: TMercadoria;
  MercadoriaFuncoes: TMercadoriaFuncoes;

  procedure Inserir(
    Nome: String;
    Preco: Currency;
    CodigoMercadoria,
    QuantidadeEstoque,
    CodigoMercadoriaGrupo: Integer;
    CobraTaxaServico,
    ValidarGrupo: Boolean);
  begin
    Mercadoria := TMercadoria.Create;
    try
      Mercadoria.Codigo := CodigoMercadoria;
      Mercadoria.Nome := Nome;
      Mercadoria.Preco := Preco;
      Mercadoria.QuantidadeEstoque := QuantidadeEstoque;
      Mercadoria.CodigoMercadoriaGrupo := CodigoMercadoriaGrupo;
      Mercadoria.CobraTaxaServico := CobraTaxaServico;
      Mercadoria.ValidarGrupo := ValidarGrupo;

      MercadoriaFuncoes.Inserir(Mercadoria);
    finally
      FreeAndNil(Mercadoria);
    end;
  end;
begin
  MercadoriaFuncoes := TMercadoriaFuncoes.Create(FDConnection);
  try
    FCodigoMercadoria1 := ObterProximoSequence('MERCADORIA_GEN');
    FCodigoMercadoria2 := ObterProximoSequence('MERCADORIA_GEN');
    FCodigoMercadoria3 := ObterProximoSequence('MERCADORIA_GEN');
    FCodigoMercadoria4 := ObterProximoSequence('MERCADORIA_GEN');
    Inserir('Mercadoria Teste 1', 6.66, FCodigoMercadoria1, 6, FCodigoGrupoMercadoriaCobra, False, False);
    Inserir('Mercadoria Teste 2', 5.66, FCodigoMercadoria2, 5, FCodigoGrupoMercadoriaCobra, True, False);
    Inserir('Mercadoria Teste 3', 4.66, FCodigoMercadoria3, 4, FCodigoGrupoMercadoriaNaoCobra, False, True);
    Inserir('Mercadoria Teste 4', 3.66, FCodigoMercadoria4, 3, FCodigoGrupoMercadoriaNaoCobra, True, False);
  finally
    FreeAndNil(MercadoriaFuncoes);
  end;
end;

function TestTVendaFuncoes.ObterValorAtualMercadoria(CodigoMercadoria: Integer): Currency;
var
  Mercadoria: TMercadoria;
  MercadoriaFuncoes: TMercadoriaFuncoes;
begin
  Result := 0;

  MercadoriaFuncoes := TMercadoriaFuncoes.Create(FDConnection);
  try
    Mercadoria := MercadoriaFuncoes.Obter(CodigoMercadoria);
    try
      if (Assigned(Mercadoria)) then
        Result := Mercadoria.Preco;
    finally
      FreeAndNil(Mercadoria);
    end;
  finally
    FreeAndNil(Mercadoria);
  end;
end;
{$ENDREGION 'MERCADORIA'}

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTVendaFuncoes.Suite);
end.

