unit uVenda;

interface

uses uEntidadeBase, uCliente;

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
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    property Codigo: Integer read FCodigo write FCodigo;
    property Data: TDateTime read FData write FData;
    property ValorDesconto: Currency read FValorDesconto write FValorDesconto;
    property Cliente: TCliente read FCliente write FCliente;
    property TaxaServico: Double read FTaxaServico write FTaxaServico;
    property ValorTotal: Currency read FValorTotal write FValorTotal;
  end;

implementation

uses SysUtils;

{ TVenda }

constructor TVenda.Create;
begin
  FCodigo := 0;
  FData := 0;
  FTaxaServico := 0;
  FValorDesconto := 0;
  FValorTotal := 0;
  FCliente := TCliente.Create;
end;

destructor TVenda.Destroy;
begin
  if (Assigned(FCliente)) then
    FreeAndNIl(FCliente);
  inherited;
end;

end.
