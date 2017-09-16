unit uFactoryColecao;

interface

uses uEnumeradores, uColecaoBase;

type
  TFactoryColecao = class
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    class function InstanciarColecao(TiposEntidade: TTiposEntidade): TColecaoBase;
  end;

implementation

uses SysUtils, TypInfo, uClientes, uMercadorias, uMercadoriaGrupos, uVendas, uVendaItens;

{ TFactoryColecao }

constructor TFactoryColecao.Create;
begin
  raise Exception.Create('Esta classe ''TFactoryColecao'' deve ser usada apenas através do método ''class function InstanciarColecao''.');
end;

destructor TFactoryColecao.Destroy;
begin

  inherited;
end;

class function TFactoryColecao.InstanciarColecao(
  TiposEntidade: TTiposEntidade): TColecaoBase;
begin
  case TiposEntidade of
    teCliente: Result := TClientes.Create();
    teMercadoria: Result := TMercadorias.Create();
    teMercadoriaGrupo: Result := TMercadoriaGrupos.Create();
    teVenda: Result := TVendas.Create;
    teVendaItem: Result := TVendaItens.Create();
  else
    raise Exception.CreateFmt('Entidade %s não implementada.', [GetEnumName(TypeInfo(TTiposEntidade), Integer(TiposEntidade))]);
  end;
end;

end.
