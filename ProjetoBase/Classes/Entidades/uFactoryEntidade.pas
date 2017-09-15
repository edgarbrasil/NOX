unit uFactoryEntidade;

interface

uses uEnumeradores, uEntidadeBase;

type
  TFactoryEntidade = class
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    class function InstanciarEntidade(TiposEntidade: TTiposEntidade): TEntidadeBase;
  end;

implementation

uses SysUtils, TypInfo, uCliente, uMercadoria, uMercadoriaGrupo, uVenda, uVendaItem;


{ TFactoryEntidade }

constructor TFactoryEntidade.Create;
begin
  raise Exception.Create('Esta classe ''TFactoryEntidade'' deve ser usada apenas através do método ''class function InstanciarEntidade''.');
end;

destructor TFactoryEntidade.Destroy;
begin

  inherited;
end;

class function TFactoryEntidade.Instanciarentidade(TiposEntidade: TTiposEntidade): TEntidadeBase;
begin
  case TiposEntidade of
    teCliente: Result := TCliente.Create();
    teMercadoria: Result := TMercadoria.Create();
    teMercadoriaGrupo: Result := TMercadoriaGrupo.Create();
    teVenda: Result := TVenda.Create;
    teVendaItem: Result := TVendaItem.Create();
  else
    raise Exception.CreateFmt('Entidade %s não implementada.', [GetEnumName(TypeInfo(TTiposEntidade), Integer(TiposEntidade))]);
  end;
end;

end.
