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
    FValidarGrupo: Boolean;
    procedure SetPreco(const Value: Currency);
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    class function CriarInstancia(
      Codigo: Integer;
      Nome: String;
      Preco: Currency;
      QuantidadeEstoque,
      CodigoMercadoriaGrupo: Integer;
      CobraTaxaServico,
      ValidarGrupo: Boolean): TMercadoria;

    property Codigo: Integer read FCodigo write FCodigo;
		property Nome: String read FNome write FNome;
		property Preco: Currency read FPreco write SetPreco;
		property QuantidadeEstoque: Integer read FQuantidadeEstoque write FQuantidadeEstoque;
		property CodigoMercadoriaGrupo: Integer read FCodigoMercadoriaGrupo write FCodigoMercadoriaGrupo;
		property CobraTaxaServico: Boolean read FCobraTaxaServico write FCobraTaxaServico;
    property ValidarGrupo: Boolean read FValidarGrupo write FValidarGrupo;
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
  FValidarGrupo := False;
end;

class function TMercadoria.CriarInstancia(
  Codigo: Integer;
  Nome: String;
  Preco: Currency;
  QuantidadeEstoque,
  CodigoMercadoriaGrupo: Integer;
  CobraTaxaServico,
  ValidarGrupo: Boolean): TMercadoria;
begin
  Result := TMercadoria.Create;
  Result.Codigo := Codigo;
  Result.Nome := Nome;
  Result.Preco := Preco;
  Result.QuantidadeEstoque := QuantidadeEstoque;
  Result.CodigoMercadoriaGrupo := CodigoMercadoriaGrupo;
  Result.CobraTaxaServico := CobraTaxaServico;
  Result.ValidarGrupo := ValidarGrupo;
end;

destructor TMercadoria.Destroy;
begin

  inherited;
end;

procedure TMercadoria.SetPreco(const Value: Currency);
begin
  if (Value <= 0) then
    raise Exception.Create('Campo Mercadoria.Preco só permite valores maiores que zero.');

  FPreco := Value;
end;

end.
