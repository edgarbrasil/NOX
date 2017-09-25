object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Principal'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 56
    Top = 43
    Width = 51
    Height = 13
    Caption = 'Data inicial'
  end
  object Label2: TLabel
    Left = 240
    Top = 43
    Width = 16
    Height = 13
    Caption = 'at'#233
  end
  object Button1: TButton
    Left = 389
    Top = 38
    Width = 75
    Height = 25
    Caption = 'Relatorio 1'
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 113
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object Edit2: TEdit
    Left = 262
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object Relatorio1: TfrxReport
    Version = '5.6.3'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43003.600473969900000000
    ReportOptions.LastChange = 43003.622467164400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 504
    Top = 48
    Datasets = <
      item
        DataSet = frxDBItens
        DataSetName = 'Itens'
      end
      item
        DataSet = frxDBVenda
        DataSetName = 'Venda'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 113.385900000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        DataSet = frxDBVenda
        DataSetName = 'Venda'
        RowCount = 0
        object VendaSEQ_VENDA: TfrxMemoView
          Left = 109.606370000000000000
          Top = 7.559060000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'SEQ_VENDA'
          DataSet = frxDBVenda
          DataSetName = 'Venda'
          Memo.UTF8W = (
            '[Venda."SEQ_VENDA"]')
        end
        object VendaDT_VENDA: TfrxMemoView
          Left = 294.803340000000000000
          Top = 7.559060000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'DT_VENDA'
          DataSet = frxDBVenda
          DataSetName = 'Venda'
          Memo.UTF8W = (
            '[Venda."DT_VENDA"]')
        end
        object VendaID_CLIENTE: TfrxMemoView
          Left = 109.606370000000000000
          Top = 30.236240000000000000
          Width = 600.945270000000000000
          Height = 18.897650000000000000
          DataSet = frxDBVenda
          DataSetName = 'Venda'
          Memo.UTF8W = (
            '[Venda."ID_CLIENTE"] + nome')
        end
        object VendaVR_DESCONTO: TfrxMemoView
          Left = 445.984540000000000000
          Top = 56.692950000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'VR_DESCONTO'
          DataSet = frxDBVenda
          DataSetName = 'Venda'
          Memo.UTF8W = (
            '[Venda."VR_DESCONTO"]')
        end
        object VendaPC_TAXA_SERVICO: TfrxMemoView
          Left = 253.228510000000000000
          Top = 56.692950000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'PC_TAXA_SERVICO'
          DataSet = frxDBVenda
          DataSetName = 'Venda'
          Memo.UTF8W = (
            '[Venda."PC_TAXA_SERVICO"]')
        end
        object VendaVR_TOTAL: TfrxMemoView
          Left = 631.181510000000000000
          Top = 56.692950000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = frxDBVenda
          DataSetName = 'Venda'
          Memo.UTF8W = (
            '[Venda."VR_TOTAL"]')
        end
        object Memo1: TfrxMemoView
          Left = 11.338590000000000000
          Top = 7.559060000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'C'#243'digo Venda:')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 196.535560000000000000
          Top = 7.559060000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Data Venda:')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 11.338590000000000000
          Top = 30.236240000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Cliente:')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 532.913730000000000000
          Top = 56.692950000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Total:')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 154.960730000000000000
          Top = 56.692950000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Taxa Servi'#231'o:')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 336.378170000000000000
          Top = 56.692950000000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Desconto:')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 11.338590000000000000
          Top = 90.708720000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo Mercadoria')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 143.622140000000000000
          Top = 90.708720000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 241.889920000000000000
          Top = 90.708720000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 343.937230000000000000
          Top = 90.708720000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Taxa Servi'#231'o')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 442.205010000000000000
          Top = 90.708720000000000000
          Width = 177.637910000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Desconto Proporcional')
          ParentFont = False
        end
      end
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        Height = 68.031540000000000000
        Top = 154.960730000000000000
        Width = 718.110700000000000000
        DataSet = frxDBItens
        DataSetName = 'Itens'
        RowCount = 0
        object ItensID_MERCADORIA: TfrxMemoView
          Left = 11.338590000000000000
          Top = 3.779530000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'ID_MERCADORIA'
          DataSet = frxDBItens
          DataSetName = 'Itens'
          Memo.UTF8W = (
            '[Itens."ID_MERCADORIA"]')
        end
        object ItensQT_VENDIDA: TfrxMemoView
          Left = 147.401670000000000000
          Top = 3.779530000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'QT_VENDIDA'
          DataSet = frxDBItens
          DataSetName = 'Itens'
          Memo.UTF8W = (
            '[Itens."QT_VENDIDA"]')
        end
        object ItensVD_VALOR: TfrxMemoView
          Left = 241.889920000000000000
          Top = 3.779530000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'VD_VALOR'
          DataSet = frxDBItens
          DataSetName = 'Itens'
          Memo.UTF8W = (
            '[Itens."VD_VALOR"]')
        end
        object ItensVR_TAXA_ITEM: TfrxMemoView
          Left = 347.716760000000000000
          Top = 3.779530000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'VR_TAXA_ITEM'
          DataSet = frxDBItens
          DataSetName = 'Itens'
          Memo.UTF8W = (
            '[Itens."VR_TAXA_ITEM"]')
        end
        object ItensPERCENTUAL_DESCONTO: TfrxMemoView
          Left = 442.205010000000000000
          Top = 7.559060000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'PERCENTUAL_DESCONTO'
          DataSet = frxDBItens
          DataSetName = 'Itens'
          Memo.UTF8W = (
            '[Itens."PERCENTUAL_DESCONTO"]')
        end
      end
    end
  end
  object frxDBVenda: TfrxDBDataset
    UserName = 'Venda'
    CloseDataSource = False
    FieldAliases.Strings = (
      'SEQ_VENDA=SEQ_VENDA'
      'DT_VENDA=DT_VENDA'
      'ID_CLIENTE=ID_CLIENTE'
      'VR_DESCONTO=VR_DESCONTO'
      'PC_TAXA_SERVICO=PC_TAXA_SERVICO'
      'VR_TOTAL=VR_TOTAL')
    DataSet = qryVenda
    BCDToCurrency = False
    Left = 480
    Top = 112
  end
  object qryVenda: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT'
      '       SEQ_VENDA'
      '      ,DT_VENDA'
      '      ,ID_CLIENTE'
      '      ,VR_DESCONTO'
      '      ,PC_TAXA_SERVICO'
      '      ,VR_TOTAL'
      'FROM VENDA'
      'WHERE SEQ_VENDA= 6')
    Left = 480
    Top = 168
  end
  object frxDBItens: TfrxDBDataset
    UserName = 'Itens'
    CloseDataSource = False
    FieldAliases.Strings = (
      'SEQ_VENDA_ITEM=SEQ_VENDA_ITEM'
      'ID_MERCADORIA=ID_MERCADORIA'
      'QT_VENDIDA=QT_VENDIDA'
      'VD_VALOR=VD_VALOR'
      'VR_TAXA_ITEM=VR_TAXA_ITEM'
      'PERCENTUAL_DESCONTO=PERCENTUAL_DESCONTO')
    DataSet = qryItens
    BCDToCurrency = False
    Left = 536
    Top = 112
  end
  object qryItens: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT SEQ_VENDA_ITEM'
      '      ,ID_MERCADORIA'
      '      ,QT_VENDIDA'
      '      ,VD_VALOR'
      '      ,CASE '
      #9'   when ((MERCADORIA.FG_COBRA_TAXA_SERVICO = '#39'S'#39') or '
      #9'         (MERCADORIA.FG_VALIDAR_GRUPO = '#39'S'#39') and'
      #9#9#9' (MERCADORIA_GRUPO.FG_COBRA_TAXA_SERVICO = '#39'S'#39')) '
      #9#9'then (VENDA_ITEM.VD_VALOR * VENDA.PC_TAXA_SERVICO)/100'
      #9#9'else 0 end as VR_TAXA_ITEM'
      #9'  ,CASE'
      
        #9'   WHEN VENDA.VR_DESCONTO > 0 THEN(VENDA.VR_DESCONTO * (VD_VALO' +
        'R * 100) / VENDA.VR_TOTAL) /100'
      #9'   ELSE 0'
      #9'   END AS PERCENTUAL_DESCONTO'
      '  FROM VENDA_ITEM'
      'inner join VENDA on (VENDA_ITEM.ID_VENDA = VENDA.SEQ_VENDA)'
      
        'LEFT JOIN MERCADORIA ON (VENDA_ITEM.ID_MERCADORIA = MERCADORIA.S' +
        'EQ_MERCADORIA)'
      
        'LEFT JOIN MERCADORIA_GRUPO ON (MERCADORIA.ID_MERCADORIA_GRUPO = ' +
        'MERCADORIA_GRUPO.SEQ_MERCADORIA_GRUPO)'
      'WHERE ID_VENDA = 6')
    Left = 536
    Top = 168
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=MSSQL'
      'Database=VENDAS'
      'MetaCaseIns=False'
      'Server=EDGAR-NOTE\MSSQLSERVER2014'
      'User_Name=sa'
      'Password=Pa$$wOrd')
    Connected = True
    LoginPrompt = False
    Left = 504
    Top = 224
  end
end
