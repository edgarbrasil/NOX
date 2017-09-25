unit uVenda;

interface

uses uEntidadeBase, uCliente, uVendaItens, uVendaItem;

type
  TVenda = class(TEntidadeBase)
  private
    { private declarations }
    FTaxaServico: Double;
    FValorDesconto: Currency;
    FCodigo: Integer;
    FValorTotal: Currency;
    FData: TDateTime;
    FCliente: TCliente;
    FVendaItens: TVendaItens;
    procedure SetVendaItens(const Value: TVendaItens);
    procedure ProcessarValores;
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    procedure AdicionarVendaItem(VendaItem: TVendaItem);

    property Codigo: Integer read FCodigo write FCodigo;
    property Data: TDateTime read FData write FData;
    property ValorDesconto: Currency read FValorDesconto write FValorDesconto;
    property Cliente: TCliente read FCliente write FCliente;
    property TaxaServico: Double read FTaxaServico write FTaxaServico;
    property ValorTotal: Currency read FValorTotal write FValorTotal;
    property VendaItens: TVendaItens read FVendaItens write SetVendaItens;
  end;

implementation

uses SysUtils, uConexaoBD, uMercadoriaFuncoes, uMercadoria, uMercadoriaGrupoFuncoes, uMercadoriaGrupo;

{ TVenda }

constructor TVenda.Create;
begin
  FCodigo := 0;
  FData := 0;
  FTaxaServico := 0;
  FValorDesconto := 0;
  FValorTotal := 0;
  FCliente := nil;
  FVendaItens := nil;
end;

destructor TVenda.Destroy;
begin
  if (Assigned(FCliente)) then
    FreeAndNIl(FCliente);
  if (Assigned(FVendaItens)) then
    FreeAndNIl(FVendaItens);
  inherited;
end;

procedure TVenda.SetVendaItens(const Value: TVendaItens);
begin
  FVendaItens := Value;

  ProcessarValores;
end;

procedure TVenda.ProcessarValores;
var
  i: Integer;
  Valor: Currency;
  Mercadoria: TMercadoria;
  MercadoriaGrupo: TMercadoriaGrupo;
  MercadoriaFuncoes: TMercadoriaFuncoes;
  MercadoriaGrupoFuncoes: TMercadoriaGrupoFuncoes;
begin
  FValorTotal := 0;

  MercadoriaFuncoes := TMercadoriaFuncoes.Create(FDConnection);
  try
    MercadoriaGrupoFuncoes := TMercadoriaGrupoFuncoes.Create(FDConnection);
    try
      for i := 0 to FVendaItens.Quantidade - 1 do
      begin
        Mercadoria := MercadoriaFuncoes.Obter(FVendaItens.ObterVendaItem(i).CodigoMercadoria);
        try
          MercadoriaGrupo := MercadoriaGrupoFuncoes.Obter(Mercadoria.CodigoMercadoriaGrupo);
          try
            Valor := 0;
            //aplica taxa de serviço caso mercadoria ou grupo esteja marcado
            if ((Mercadoria.CobraTaxaServico) or
                (Mercadoria.ValidarGrupo and
                (Assigned(MercadoriaGrupo)) and
                 MercadoriaGrupo.CobraTaxaServico)) then
              Valor :=
                Valor +
                (Valor * (FTaxaServico / 100));

            //simples quantidade * valor
            //(assumo que quem preencheu o objeto venda_item obteve o valor unitario da mercadoria,
            //pode ser inclusive zero pois alguém pode implementar 'zerar' o valor em tela)
            Valor :=  Valor + (
              FVendaItens.ObterVendaItem(i).Quantidade *
              FVendaItens.ObterVendaItem(i).Valor);

            //acumula o total
            FValorTotal := FValorTotal + Valor;
          finally
            FreeAndNil(MercadoriaGrupo);
          end;
        finally
          FreeAndNil(Mercadoria);
        end;
      end;
    finally
      FreeAndNil(MercadoriaGrupoFuncoes);
    end;
  finally
    FreeAndNil(MercadoriaFuncoes);
  end;
end;

procedure TVenda.AdicionarVendaItem(VendaItem: TVendaItem);
begin
  if (Assigned(VendaItem)) then
  begin
    FVendaItens.AdicionarVendaItem(VendaItem);

    ProcessarValores;
  end;
end;

end.
