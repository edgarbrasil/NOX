unit uMercadoria;

interface

uses uEntidadeBase;

type
  TMercadoria = class(TEntidadeBase)
  private
    { private declarations }
    FQuantidadeEstoque: Integer;
    FPreco: Currency;
    FCodigo: Integer;
    FCodigoMercadoriaGrupo: Integer;
    FNome: String;
    FCobraTaxaServico: Boolean;
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    property Codigo: Integer read FCodigo write FCodigo;
		property Nome: String read FNome write FNome;
		property Preco: Currency read FPreco write FPreco;
		property QuantidadeEstoque: Integer read FQuantidadeEstoque write FQuantidadeEstoque;
		property CodigoMercadoriaGrupo: Integer read FCodigoMercadoriaGrupo write FCodigoMercadoriaGrupo;
		property CobraTaxaServico: Boolean read FCobraTaxaServico write FCobraTaxaServico;
  end;

implementation

uses SysUtils;

{ TMercadoria }

constructor TMercadoria.Create;
begin
  FCodigo := 0;
  FCodigoMercadoriaGrupo := 0;
  FNome := EmptyStr;
  FPreco := 0;
  FQuantidadeEstoque := 0;
  FCobraTaxaServico := False;
end;

destructor TMercadoria.Destroy;
begin

  inherited;
end;

end.
