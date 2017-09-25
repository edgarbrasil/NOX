unit uVendaItem;

interface

uses uEntidadeBase;

type
  TVendaItem = class(TEntidadeBase)
  private
    { private declarations }
    FValor: Currency;
    FCodigo: Integer;
    FCodigoVenda: Integer;
    FQuantidade: Integer;
    FCodigoMercadoria: Integer;
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    class function CriarInstancia(
      Codigo,
      CodigoVenda,
      CodigoMercadoria,
      Quantidade: Integer;
      Valor: Currency): TVendaItem;

    property Codigo: Integer read FCodigo write FCodigo;
    property CodigoVenda: Integer read FCodigoVenda write FCodigoVenda;
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
  FCodigoVenda := 0;
  FCodigoMercadoria := 0;
  FQuantidade := 0;
  FValor := 0;
end;

class function TVendaItem.CriarInstancia(
  Codigo,
  CodigoVenda,
  CodigoMercadoria,
  Quantidade: Integer;
  Valor: Currency): TVendaItem;
begin
  Result := TVendaItem.Create;
  Result.Codigo := Codigo;
  Result.CodigoVenda := CodigoVenda;
  Result.CodigoMercadoria := CodigoMercadoria;
  Result.Quantidade := Quantidade;
  Result.Valor := Valor;
end;

destructor TVendaItem.Destroy;
begin

  inherited;
end;

end.
