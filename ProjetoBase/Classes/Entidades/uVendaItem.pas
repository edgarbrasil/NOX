unit uVendaItem;

interface

uses uEntidadeBase;

type
  TVendaItem = class(TEntidadeBase)
  private
    { private declarations }
    FValor: Currency;
    FCodigo: Integer;
    FQuantidade: Integer;
    FCodigoMercadoria: Integer;
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    property Codigo: Integer read FCodigo write FCodigo;
		property CodigoMercadoria: Integer read FCodigoMercadoria write FCodigoMercadoria;
    property Quantidade: Integer read FQuantidade write FQuantidade;
    property Valor: Currency read FValor write FValor;
  end;

implementation

uses SysUtils;

{ TVendaItem }

constructor TVendaItem.Create;
begin
  FCodigo := 0;
  FCodigoMercadoria := 0;
  FQuantidade := 0;
  FValor := 0;
end;

destructor TVendaItem.Destroy;
begin

  inherited;
end;

end.
