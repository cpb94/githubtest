$PBExportHeader$wi_mant_textos_clientes.srw
forward
global type wi_mant_textos_clientes from wc_mantenimientos_tab
end type
type gb_1 from groupbox within wi_mant_textos_clientes
end type
type st_2 from statictext within wi_mant_textos_clientes
end type
end forward

global type wi_mant_textos_clientes from wc_mantenimientos_tab
integer width = 2880
integer height = 1760
gb_1 gb_1
st_2 st_2
end type
global wi_mant_textos_clientes wi_mant_textos_clientes

type variables
String var_domi,var_envio,var_correspondencia
end variables

event ue_valores;call super::ue_valores;pag1 = TRUE
pag2 = TRUE
pag3 = TRUE



prin_pag1 = TRUE
prin_pag2 = FALSE
prin_pag3 = FALSE

end event

on wi_mant_textos_clientes.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.st_2
end on

on wi_mant_textos_clientes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.st_2)
end on

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion[1]     =  criterio[1]+criterio[2]

tabla[1]         = "ventextoscliente"

apartados.pagina_1.dw_pagina1.Retrieve(codigo_empresa,sle_valor.text)
apartados.pagina_2.dw_pagina2.Retrieve(codigo_empresa,sle_valor.text)
apartados.pagina_3.dw_pagina3.Retrieve(codigo_empresa,sle_valor.text)



//dw_pag1.Retrieve(codigo_empresa,sle_valor.text)
//dw_pag2.Retrieve(codigo_empresa,sle_valor.text)
//dw_pag3.Retrieve(codigo_empresa,sle_valor.text)

CALL Super::ue_recuperar

end event

event ue_inserta_fila;call super::ue_inserta_fila;
dw_pag1.SetItem(1,"cliente",sle_valor.text)
dw_pag1.SetItem(1,"empresa",codigo_empresa)


apartados.pagina_1.dw_pagina1.Object.empresa[1] = codigo_empresa
apartados.pagina_1.dw_pagina1.Object.cliente[1] = sle_valor.text

apartados.pagina_2.dw_pagina2.Object.empresa[1] = codigo_empresa
apartados.pagina_2.dw_pagina2.Object.cliente[1] = sle_valor.text

apartados.pagina_3.dw_pagina3.Object.empresa[1] = codigo_empresa
apartados.pagina_3.dw_pagina3.Object.cliente[1] = sle_valor.text

end event

event open;call super::open;titulo= " Mantenimiento Textos de Clientes "
This.title = titulo
// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
     sle_valor.text=istr_parametros.s_argumentos[2]
     istr_parametros.i_nargumentos=0
	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
        	This.TriggerEvent("ue_recuperar")
			return   
     END IF
END IF
end event

event ue_pase_valores;call super::ue_pase_valores;dw_pag1.SetItem(1,"cab2",dw_pag2.GetItemString(1,"cab2"))
dw_pag1.SetItem(1,"destino2",dw_pag2.GetItemString(1,"destino2"))
dw_pag1.SetItem(1,"pie2",dw_pag2.GetItemString(1,"pie2"))

dw_pag1.SetItem(1,"cab3",dw_pag3.GetItemString(1,"cab3"))
dw_pag1.SetItem(1,"destino3",dw_pag3.GetItemString(1,"destino3"))
dw_pag1.SetItem(1,"pie3",dw_pag3.GetItemString(1,"pie3"))
end event

type cb_salir from wc_mantenimientos_tab`cb_salir within wi_mant_textos_clientes
integer x = 2519
integer y = 200
integer width = 265
integer height = 76
integer taborder = 0
string text = "&Salir"
end type

type cb_borrar from wc_mantenimientos_tab`cb_borrar within wi_mant_textos_clientes
integer x = 2249
integer y = 200
integer width = 265
integer height = 76
integer taborder = 0
string text = "&Borrar"
end type

type cb_insertar from wc_mantenimientos_tab`cb_insertar within wi_mant_textos_clientes
integer x = 1979
integer y = 200
integer width = 265
integer height = 76
integer taborder = 0
end type

type wc_control_tabulador from wc_mantenimientos_tab`wc_control_tabulador within wi_mant_textos_clientes
integer taborder = 20
end type

type st_empresa from wc_mantenimientos_tab`st_empresa within wi_mant_textos_clientes
integer width = 2871
integer height = 96
end type

type sle_valor from wc_mantenimientos_tab`sle_valor within wi_mant_textos_clientes
integer y = 196
integer width = 233
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION CLIENTES"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = "" 	
isle_campo    = This





end event

event sle_valor::modificado;call super::modificado;st_2.text = f_nombre_cliente(codigo_empresa,"C",sle_valor.text)
end event

type st_1 from wc_mantenimientos_tab`st_1 within wi_mant_textos_clientes
integer x = 96
integer y = 192
integer width = 274
string text = "Código:"
end type

type apartados from wc_mantenimientos_tab`apartados within wi_mant_textos_clientes
integer x = 101
integer y = 328
integer width = 2702
integer height = 1212
boolean multiline = true
end type

on apartados.create
call super::create
this.Control[]={this.pagina_1,&
this.pagina_2,&
this.pagina_3,&
this.pagina_4,&
this.pagina_5,&
this.pagina_6,&
this.pagina_7,&
this.pagina_8}
end on

on apartados.destroy
call super::destroy
end on

type pagina_1 from wc_mantenimientos_tab`pagina_1 within apartados
boolean visible = false
integer width = 2665
integer height = 1084
string text = "Textos Comercial."
end type

type dw_pagina1 from wc_mantenimientos_tab`dw_pagina1 within pagina_1
integer x = 0
integer y = 8
integer width = 2697
integer height = 1080
string dataobject = "dw_textos_cliente1"
end type

type pagina_2 from wc_mantenimientos_tab`pagina_2 within apartados
integer width = 2665
integer height = 1084
string text = "Textos Aduana Nacional."
end type

type dw_pagina2 from wc_mantenimientos_tab`dw_pagina2 within pagina_2
integer x = 5
integer y = 24
integer width = 2720
integer height = 1044
string dataobject = "dw_textos_cliente2"
end type

type pagina_3 from wc_mantenimientos_tab`pagina_3 within apartados
integer width = 2665
integer height = 1084
string text = "Textos Aduana Exportación."
end type

type dw_pagina3 from wc_mantenimientos_tab`dw_pagina3 within pagina_3
integer x = 0
integer y = 16
integer width = 2697
integer height = 1052
string dataobject = "dw_textos_cliente3"
end type

type pagina_4 from wc_mantenimientos_tab`pagina_4 within apartados
boolean visible = false
integer width = 2665
integer height = 1084
string text = ""
end type

type dw_pagina4 from wc_mantenimientos_tab`dw_pagina4 within pagina_4
integer x = 0
integer y = 20
integer width = 2693
integer height = 1072
end type

type pagina_5 from wc_mantenimientos_tab`pagina_5 within apartados
boolean visible = false
integer width = 2665
integer height = 1084
string text = ""
end type

type dw_pagina5 from wc_mantenimientos_tab`dw_pagina5 within pagina_5
integer x = 23
integer y = 4
integer width = 2674
integer height = 1168
end type

event dw_pagina5::rbuttondown;bus_filtro=""
 valor_empresa = TRUE	
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
	CASE "tipo_pallet"
 		bus_datawindow = "dw_ayuda_almclasepallet"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PALLET"
 	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
 	CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
     bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
 	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina5::clicked;call super::clicked;str_parametros lstr_param
lstr_param.i_nargumentos    = 2

CHOOSE CASE f_objeto_datawindow(This)

CASE "pb_agente1"
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"agente1")
   OpenWithParm(wi_mant_venagentes,lstr_param)
CASE "pb_agente2"
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"agente2")
   OpenWithParm(wi_mant_venagentes,lstr_param)
CASE "pb_agente3"
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"agente2")
   OpenWithParm(wi_mant_venagentes,lstr_param)
CASE "pb_cod_pago"
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"cod_pago")
   OpenWithParm(wi_mant_carforpag,lstr_param)
CASE "pb_cod_entrega"
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"cod_entrega")
   OpenWithParm(wi_mant_vencondentrega,lstr_param)
END CHOOSE





end event

event dw_pagina5::key; bus_filtro=""
 bus_titulo=""
 valor_empresa = TRUE	
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "tipo_pallet"
 		bus_datawindow = "dw_ayuda_almclasepallet"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PALLET"
  	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
   CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
   CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
  	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "pb_banco_cobro"
  		bus_datawindow = "dw_ayuda_carbancos"
 		bus_titulo = "VENTANA SELECCION BANCOS EMPRESA"
	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key


end event

event dw_pagina5::valores_numericos;call super::valores_numericos;f_valores_numericos(This,"cod_pago")
f_valores_numericos(This,"agente1")
f_valores_numericos(This,"agente2")
f_valores_numericos(This,"agente3")
end event

event dw_pagina5::itemfocuschanged;call super::itemfocuschanged;string control_banco, var_codpago
var_codpago   = f_valor_columna(This,This.GetRow(),'cod_pago')
control_banco = f_cartipodoc_controlbanco(codigo_empresa,f_tipodoc_carforpag(codigo_empresa,var_codpago))
This.SetTabOrder("banco_de_cobro",280)
if control_banco = "N" then
	This.SetTabOrder("banco_de_cobro",0)
END IF

end event

type pagina_6 from wc_mantenimientos_tab`pagina_6 within apartados
boolean visible = false
integer width = 2665
integer height = 1084
string text = ""
end type

type dw_pagina6 from wc_mantenimientos_tab`dw_pagina6 within pagina_6
integer y = 12
integer width = 2318
end type

event dw_pagina6::rbuttondown;bus_filtro=""
 valor_empresa = TRUE	
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
 	CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
     bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
 	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina6::clicked;call super::clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 2

CHOOSE CASE f_objeto_datawindow(This)

CASE "pb_zona"
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"zona")
   OpenWithParm(wi_mant_venzonas,lstr_param)  
CASE "pb_grupo"
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"grupo")
   OpenWithParm(wi_mant_vengrupos,lstr_param)  
CASE "pb_serie"
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"serie")
   OpenWithParm(wi_mant_venseries,lstr_param)  
END CHOOSE





end event

event dw_pagina6::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
	 valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo

  	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
   CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
   CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
  	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
END IF

end event

type pagina_7 from wc_mantenimientos_tab`pagina_7 within apartados
boolean visible = false
integer width = 2665
integer height = 1084
string text = ""
end type

type dw_pagina7 from wc_mantenimientos_tab`dw_pagina7 within pagina_7
integer x = 0
integer y = 36
integer width = 2683
integer height = 884
end type

event dw_pagina7::key; valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo

  	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
   CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_filtro = "ejercicio =" + String(f_ejercicio_activo(codigo_empresa) ,"#####")
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
   CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
  	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key


end event

event dw_pagina7::clicked;call super::clicked;str_parametros lstr_param
lstr_param.i_nargumentos    = 2

CHOOSE CASE f_objeto_datawindow(This)

CASE "pb_transportista"
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"transportista")
   OpenWithParm(wi_mant_ventransportistas,lstr_param)
CASE "pb_tarifa"
   lstr_param.s_argumentos[2]=f_valor_columna(this,This.GetRow(),"tarifa")
   OpenWithParm(wi_mant_ventarifas,lstr_param)
CASE "pb_tipoiva"
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=String(f_ejercicio_activo(codigo_empresa))
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"tipoiva")
	OpenWithParm(wi_mant_contaiva,lstr_param)  
END CHOOSE





end event

event dw_pagina7::rbuttondown; valor_empresa = TRUE	
bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
 		bus_filtro = "ejercicio =" + String(f_ejercicio_activo(codigo_empresa) ,"#####")
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
 	CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
     bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
 	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina7::itemfocuschanged;call super::itemfocuschanged;IF dw_pag7.GetItemSTring(1,"deposito")= "S" Then
	dw_pag7.SetItem(1,"pallets_enteros","S")
ELSE
	dw_pag7.SetItem(1,"pallets_enteros","")
END IF
end event

type pagina_8 from wc_mantenimientos_tab`pagina_8 within apartados
boolean visible = false
integer width = 2665
integer height = 1084
string text = ""
end type

type dw_pagina8 from wc_mantenimientos_tab`dw_pagina8 within pagina_8
integer x = 87
integer width = 2473
integer height = 1148
end type

type gb_1 from groupbox within wi_mant_textos_clientes
integer x = 1961
integer y = 164
integer width = 837
integer height = 124
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type st_2 from statictext within wi_mant_textos_clientes
integer x = 585
integer y = 196
integer width = 1358
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

