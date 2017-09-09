unit uVenda;

interface

uses uEntidadeBase;

type
  TVenda = class(TEntidadeBase)
  private
    { private declarations }
    FTaxaServico: Double;
    FValorDesconto: Currency;
    FCodigo: Integer;
    FValorTotal: Currency;
    FCodigoCliente: Integer;
    FData: TDateTime;
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    property Codigo: Integer read FCodigo write FCodigo;
    property Data: TDateTime read FData write FData;
		property CodigoCliente: Integer read FCodigoCliente write FCodigoCliente;
    property ValorDesconto: Currency read FValorDesconto write FValorDesconto;
    property TaxaServico: Double read FTaxaServico write FTaxaServico;
    property ValorTotal: Currency read FValorTotal write FValorTotal;
  end;

implementation

uses SysUtils;

{ TVenda }

constructor TVenda.Create;
begin
  FCodigo := 0;
  FCodigoCliente := 0;
  FData := 0;
  FTaxaServico := 0;
  FValorDesconto := 0;
  FValorTotal := 0;
end;

destructor TVenda.Destroy;
begin

  inherited;
end;

end.
