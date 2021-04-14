$PBExportHeader$w_mant_comcabpedpro.srw
forward
global type w_mant_comcabpedpro from wc_mantenimientos_tab
end type
type st_proveedor from statictext within pagina_2
end type
type st_2 from statictext within pagina_2
end type
type em_proveedor from u_em_campo within pagina_2
end type
type dw_famiproc from u_datawindow within pagina_3
end type
type dw_tecnicos2 from u_datawindow within pagina_4
end type
type pb_calculadora from picture within w_mant_comcabpedpro
end type
type em_anyo from u_em_campo within w_mant_comcabpedpro
end type
type cb_lineas from commandbutton within w_mant_comcabpedpro
end type
type pb_imprimir from upb_imprimir within w_mant_comcabpedpro
end type
type gb_1 from groupbox within w_mant_comcabpedpro
end type
type dw_carta from datawindow within w_mant_comcabpedpro
end type
end forward

global type w_mant_comcabpedpro from wc_mantenimientos_tab
integer width = 3698
integer height = 2076
pb_calculadora pb_calculadora
em_anyo em_anyo
cb_lineas cb_lineas
pb_imprimir pb_imprimir
gb_1 gb_1
dw_carta dw_carta
end type
global w_mant_comcabpedpro w_mant_comcabpedpro

forward prototypes
public function string f_prov (string arg_anyo, string arg_ped)
end prototypes

public function string f_prov (string arg_anyo, string arg_ped);string prov
  SELECT comcabpedpro.proveedor  
    INTO :prov  
    FROM comcabpedpro  
   WHERE ( comcabpedpro.empresa = :codigo_empresa ) AND  
         ( comcabpedpro.anyo = :arg_anyo ) AND  
         ( comcabpedpro.pedido = :arg_ped )   ;
			
 if sqlca.sqlcode<>0 then setnull(prov)

return prov
end function

on w_mant_comcabpedpro.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.em_anyo=create em_anyo
this.cb_lineas=create cb_lineas
this.pb_imprimir=create pb_imprimir
this.gb_1=create gb_1
this.dw_carta=create dw_carta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.em_anyo
this.Control[iCurrent+3]=this.cb_lineas
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.dw_carta
end on

on w_mant_comcabpedpro.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.em_anyo)
destroy(this.cb_lineas)
destroy(this.pb_imprimir)
destroy(this.gb_1)
destroy(this.dw_carta)
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Pedidos Proveedor"
istr_parametros.s_listado        = "report_compedidos"
 This.title = istr_parametros.s_titulo_ventana
em_anyo.text=string(Year(Today()))
//tipo_mantenimiento ="C"
dw_carta.SetTransObject(SQLCA)

apartados.pagina_3.dw_pagina3.SetRowFocusIndicator(Hand!)
apartados.pagina_2.dw_pagina2.SetRowFocusIndicator(Hand!)
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[3]
      em_anyo.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       f_activar_campo(sle_valor)
		 TriggerEvent("ue_recuperar")
      END IF
		END IF

	
end event

event ue_valores;call super::ue_valores;pag1 = TRUE
pag2 = TRUE

pag_act1 = TRUE
pag_act2 = TRUE


prin_pag1= TRUE

end event

event ue_recuperar;// Valores Para Funcion de bloqueo


titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20 - longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(em_anyo.text)+space(20 - longitud)
longitud      =  len(trim(em_anyo.text))
criterio[3]   =  trim(sle_valor.text)+space(20 - longitud)
seleccion[1]     =  criterio[1]+criterio[2]+criterio[3]
tabla[1]         = "comcabpedpro"

apartados.pagina_1.dw_pagina1.Retrieve(codigo_empresa,em_anyo.text,sle_valor.Text)
CALL Super::ue_recuperar
end event

event ue_inserta_fila;call super::ue_inserta_fila;f_asignar_columna(apartados.pagina_1.dw_pagina1,1,"empresa",codigo_empresa)
f_asignar_columna(apartados.pagina_1.dw_pagina1,1,"anyo",em_anyo.text)
f_asignar_columna(apartados.pagina_1.dw_pagina1,1,"pedido",sle_valor.text)
  
dec existe

  SELECT count(*)  
    INTO :existe  
    FROM comcabpedpro  
   WHERE ( comcabpedpro.empresa = :codigo_empresa ) AND  
         ( comcabpedpro.anyo	  = :em_anyo.text) AND  
         ( comcabpedpro.pedido  = :sle_valor.text )   ;

if sqlca.sqlcode<>0 then existe=0
if existe=0 then
	apartados.pagina_1.dw_pagina1.setitem(1,"fecha_pedido",datetime(today()))
	apartados.pagina_1.dw_pagina1.setitem(1,"notas","Pedido anticipado telefónicamente")
	apartados.pagina_1.dw_pagina1.setitem(1,"pedidopor",nombre_usuario)
end if
	






end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(apartados.pagina_3.dw_pagina3)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(apartados.pagina_3.dw_pagina3)
end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
cb_lineas.enabled = TRUE
em_anyo.enabled = TRUE
pb_imprimir.visible = TRUE
apartados.pagina_2.enabled=true
apartados.pagina_2.dw_pagina2.enabled=true
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
cb_lineas.enabled = FALSE
em_anyo.enabled = FALSE
pb_imprimir.visible = FALSE

end event

event ue_borra_fila;call super::ue_borra_fila;  DELETE FROM comlinpedpro  
   WHERE ( comlinpedpro.empresa = :codigo_empresa ) AND  
         ( comlinpedpro.anyo = :em_anyo.text ) AND  
         ( comlinpedpro.pedido = :sle_valor.text )   ;

end event

type cb_salir from wc_mantenimientos_tab`cb_salir within w_mant_comcabpedpro
integer x = 1906
integer y = 172
integer width = 288
integer height = 96
integer taborder = 0
end type

type cb_borrar from wc_mantenimientos_tab`cb_borrar within w_mant_comcabpedpro
integer x = 1618
integer y = 172
integer width = 288
integer height = 96
integer taborder = 0
end type

type cb_insertar from wc_mantenimientos_tab`cb_insertar within w_mant_comcabpedpro
integer x = 1330
integer y = 172
integer width = 288
integer height = 96
integer taborder = 0
end type

event cb_insertar::clicked;if cb_insertar.enabled=true then
	string fch
	fch=string(date(dw_pag1.getitemdatetime(dw_pag1.getrow(),"fecha_entrega")),"dd-mm-yy")
	if fch="00-00-00" or isnull(fch) or len(fch)=0 then
		messagebox("Faltan datos en la cabecera del pedido","Introduzca la fecha de entrega")
		dw_pag1.setfocus()
		dw_pag1.setrow(dw_pag1.getrow())
		dw_pag1.setcolumn("fecha_entrega")
		return
	end if
end if

call super::clicked
end event

type wc_control_tabulador from wc_mantenimientos_tab`wc_control_tabulador within w_mant_comcabpedpro
integer taborder = 40
end type

type st_empresa from wc_mantenimientos_tab`st_empresa within w_mant_comcabpedpro
integer x = 27
end type

type sle_valor from wc_mantenimientos_tab`sle_valor within w_mant_comcabpedpro
integer x = 750
integer y = 184
integer width = 325
end type

event sle_valor::getfocus;call super::getfocus;//ue_datawindow =  "dw_ayuda_comcabpedpro"
ue_datawindow =  "dw_ayuda_comcabpedpro"
ue_titulo     =  "AYUDA SELECCION DE PEDIDOS PROVEEDOR"
ue_filtro     =  "anyo = '"+em_anyo.text+"'"
isle_campo    = This
valor_empresa = TRUE
end event

type st_1 from wc_mantenimientos_tab`st_1 within w_mant_comcabpedpro
integer x = 69
integer y = 184
integer width = 402
string text = "Anyo/Pedido:"
end type

type apartados from wc_mantenimientos_tab`apartados within w_mant_comcabpedpro
integer x = 9
integer y = 300
integer width = 3611
integer height = 1552
integer weight = 700
end type

event apartados::selectionchanged;call super::selectionchanged;if newindex=2 then
	apartados.pagina_2.em_proveedor.text=""
	apartados.pagina_2.st_proveedor.text=""
end if

end event

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
integer width = 3575
integer height = 1424
string text = "Datos generales"
end type

type dw_pagina1 from wc_mantenimientos_tab`dw_pagina1 within pagina_1
integer x = 14
integer y = 0
integer width = 3561
integer height = 1424
string dataobject = "dw_comcabpedpro"
end type

event dw_pagina1::clicked;call super::clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "w_mant_comcabpedpro"

CHOOSE CASE f_objeto_datawindow(This)

CASE "pb_proveedor"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"proveedor")
   OpenWithParm(w_mant_comproveedores,lstr_param)  
CASE "pb_envio"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"proveedor")
   OpenWithParm(w_mant_comforenv,lstr_param)	
CASE "pb_pago"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"forma_pago")
   OpenWithParm(wi_mant_carforpag,lstr_param)  
CASE "pb_moneda"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"moneda")
   OpenWithParm(wi_mant_divisas,lstr_param)  

END CHOOSE



end event

event dw_pagina1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
bus_filtro=""
bus_titulo=""
valor_empresa = TRUE
bus_campo = This.GetColumnName()

CHOOSE CASE bus_campo
	CASE "proveedor"
		bus_datawindow = "dw_ayuda_proveedores"
		bus_titulo = "VENTANA SELECCION DE PROVEEDORES"
	CASE "forma_envio"
		bus_datawindow = "dw_ayuda_comforenv"
		bus_titulo = "VENTANA SELECCION FORMAS DE ENVIO"
	CASE "forma_pago"
		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE PAGO"
	CASE "moneda"
		valor_empresa = FALSE
		bus_datawindow = "dw_ayuda_divisas"
		bus_titulo = "VENTANA SELECCION DE MONEDAS"
	CASE "tipoiva"
		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo     = "VENTANA SELECCION DE TIPOS DE IVA"		
	CASE ELSE
		bus_campo = ""
END CHOOSE

CALL SUPER::Key
end if
			
end event

event dw_pagina1::rbuttondown;bus_filtro=""
bus_titulo=""
bus_campo = This.GetColumnName()
valor_empresa = TRUE


CHOOSE CASE bus_campo
	CASE "proveedor"
		bus_datawindow = "dw_ayuda_proveedores"
		bus_titulo = "VENTANA SELECCION PROVEEDORES"
	CASE "forma_envio"
		bus_datawindow = "dw_ayuda_comforenv"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
	CASE "forma_pago"
		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION FORMAS DE PAGO"
	CASE "moneda"
		valor_empresa = FALSE
		bus_datawindow = "dw_ayuda_divisas"
		bus_titulo = "VENTANA SELECCION DE MONEDAS"
	CASE "tipoiva"
		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo     = "VENTANA SELECCION DE TIPOS DE IVA"				 
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::rbuttondown
end event

event dw_pagina1::getfocus;call super::getfocus;	apartados.pagina_2.enabled=false

end event

event dw_pagina1::itemchanged;string proveedor,forma_envio,forma_pago,moneda,tipoiva
int    decimales_precios
dec    cambio,dto1,dtopp,iva


choose case dwo.name
	case "proveedor"
		proveedor = data
		
		SELECT forma_envio,		forma_pago,
				 dto1,				dtopp,
				 moneda,				decimales_precios,
				 tipo_iva
		INTO   :forma_envio,		:forma_pago,
				 :dto1,				:dtopp,
				 :moneda,			:decimales_precios,
				 :tipoiva
		FROM   comproveedores  
		WHERE  (empresa = :codigo_empresa)
		AND  	 (codigo  = :proveedor);
		
		if isnull(forma_envio) then forma_envio = ""
		if isnull(forma_pago) then forma_pago = ""
		if isnull(dto1) then dto1 = 0
		if isnull(dtopp) then dtopp = 0
		if isnull(moneda) then moneda = ""
		if isnull(decimales_precios) then decimales_precios = 0
		if isnull(tipoiva) then tipoiva = ''
		
		if trim(moneda) <> "" then
			cambio = f_cambio_moneda(moneda)
		else
			cambio = 0
		end if
		
		if trim(tipoiva) <> '' then
			iva = f_iva_contaiva(f_ejercicio_activo(codigo_empresa),codigo_empresa,tipoiva)
		else
			iva = 0
		end if
		
		this.object.forma_envio[row]       = forma_envio
		this.object.forma_pago[row]        = forma_pago
		this.object.dto1[row]              = dto1
		this.object.dtopp[row]             = dtopp
		this.object.moneda[row]            = moneda
		this.object.decimales_precios[row] = decimales_precios
		this.object.cambio[row]            = cambio
		this.object.tipoiva[row]           = tipoiva
		this.object.iva[row]               = iva
		
	case 'tipoiva'
		tipoiva = data
		
		if trim(tipoiva) <> '' then
			iva = f_iva_contaiva(f_ejercicio_activo(codigo_empresa),codigo_empresa,tipoiva)
		else
			iva = 0
		end if		
		
		
		this.object.iva[row] = iva
	case "moneda"
		moneda = data
		
		if trim(moneda) <> "" then
			cambio            = f_cambio_moneda(moneda)
			decimales_precios = f_decimales_precios_moneda(moneda)
			
			this.object.cambio[row]            = cambio
			this.object.decimales_precios[row] = decimales_precios
		end if		
end choose
end event

type pagina_2 from wc_mantenimientos_tab`pagina_2 within apartados
integer width = 3575
integer height = 1424
string text = "Consulta por Proveedor"
st_proveedor st_proveedor
st_2 st_2
em_proveedor em_proveedor
end type

on pagina_2.create
this.st_proveedor=create st_proveedor
this.st_2=create st_2
this.em_proveedor=create em_proveedor
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_proveedor
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_proveedor
end on

on pagina_2.destroy
call super::destroy
destroy(this.st_proveedor)
destroy(this.st_2)
destroy(this.em_proveedor)
end on

type dw_pagina2 from wc_mantenimientos_tab`dw_pagina2 within pagina_2
integer x = 0
integer y = 148
integer width = 2619
integer height = 824
string dataobject = "dw_comcabpedpro2"
boolean vscrollbar = true
boolean border = true
borderstyle borderstyle = styleraised!
end type

event dw_pagina2::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo

  	CASE "proveedor"
 		bus_datawindow = "dw_ayuda_proveedores"
		bus_titulo = "VENTANA SELECCION DE PROVEEDORES"
		
	
END CHOOSE

CALL SUPER::Key
end if
end event

event dw_pagina2::rbuttondown;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo

  	CASE "proveedor"
 		bus_datawindow = "dw_ayuda_proveedores"
		bus_titulo = "VENTANA SELECCION DE PROVEEDORES"
		
	
END CHOOSE

CALL SUPER::Key
end if
end event

event dw_pagina2::doubleclicked;call super::doubleclicked;IF Row = 0 Then Return
str_parametros lstr_param
lstr_param.i_nargumentos=3
em_anyo.text=f_valor_columna(apartados.pagina_2.dw_pagina2,apartados.pagina_2.dw_pagina2.GetRow(),"anyo")
sle_valor.text= f_valor_columna(apartados.pagina_2.dw_pagina2,apartados.pagina_2.dw_pagina2.GetRow(),"pedido")
w_mant_comcabpedpro.triggerevent("ue_recuperar")
apartados.SelectTab(1)



end event

type pagina_3 from wc_mantenimientos_tab`pagina_3 within apartados
integer width = 3575
integer height = 1424
string text = "Pagina 3"
dw_famiproc dw_famiproc
end type

on pagina_3.create
this.dw_famiproc=create dw_famiproc
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_famiproc
end on

on pagina_3.destroy
call super::destroy
destroy(this.dw_famiproc)
end on

type dw_pagina3 from wc_mantenimientos_tab`dw_pagina3 within pagina_3
integer x = 32
integer y = 64
integer width = 786
integer height = 356
integer taborder = 10
end type

event dw_pagina3::rbuttondown;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo

  	CASE "proveedor"
 		bus_datawindow = "dw_ayuda_proveedores"
		bus_titulo = "VENTANA SELECCION DE PROVEEDORES"
		
	
END CHOOSE

CALL SUPER::Key
end if
end event

event dw_pagina3::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo

  	CASE "proveedor"
 		bus_datawindow = "dw_ayuda_proveedores"
		bus_titulo = "VENTANA SELECCION DE PROVEEDORES"
		
	
END CHOOSE

CALL SUPER::Key
end if
end event

event dw_pagina3::doubleclicked;call super::doubleclicked;//IF Row = 0 Then Return
//
//str_parametros lstr_param
//lstr_param.i_nargumentos=3
//lstr_param.s_argumentos[2]=This.GetItemString(Row,"anyo")
//lstr_param.s_argumentos[3]=This.GetItemString(Row,"pedido")
//OpenWithParm(w_mant_comcabpedpro,lstr_param) 
//
//
end event

type pagina_4 from wc_mantenimientos_tab`pagina_4 within apartados
integer width = 3575
integer height = 1424
string text = "Pagina 4"
dw_tecnicos2 dw_tecnicos2
end type

on pagina_4.create
this.dw_tecnicos2=create dw_tecnicos2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_tecnicos2
end on

on pagina_4.destroy
call super::destroy
destroy(this.dw_tecnicos2)
end on

type dw_pagina4 from wc_mantenimientos_tab`dw_pagina4 within pagina_4
integer x = 169
integer y = 32
integer width = 1897
integer height = 112
end type

type pagina_5 from wc_mantenimientos_tab`pagina_5 within apartados
integer width = 3575
integer height = 1424
string text = "Pagina 5"
end type

type dw_pagina5 from wc_mantenimientos_tab`dw_pagina5 within pagina_5
end type

type pagina_6 from wc_mantenimientos_tab`pagina_6 within apartados
integer width = 3575
integer height = 1424
end type

type dw_pagina6 from wc_mantenimientos_tab`dw_pagina6 within pagina_6
end type

type pagina_7 from wc_mantenimientos_tab`pagina_7 within apartados
integer width = 3575
integer height = 1424
end type

type dw_pagina7 from wc_mantenimientos_tab`dw_pagina7 within pagina_7
end type

type pagina_8 from wc_mantenimientos_tab`pagina_8 within apartados
integer width = 3575
integer height = 1424
end type

type dw_pagina8 from wc_mantenimientos_tab`dw_pagina8 within pagina_8
end type

type st_proveedor from statictext within pagina_2
integer x = 818
integer y = 44
integer width = 997
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_2 from statictext within pagina_2
integer x = 41
integer y = 40
integer width = 334
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Proveedor:"
boolean focusrectangle = false
end type

type em_proveedor from u_em_campo within pagina_2
integer x = 407
integer y = 40
integer width = 393
integer taborder = 2
end type

event getfocus;call super::getfocus;ue_titulo="AYUDA SELECCION DE PROVEEDORES"
ue_datawindow= "dw_ayuda_proveedores"
ue_filtro =""
isle_campo = this
valor_empresa = TRUE
end event

event modificado;call super::modificado;st_proveedor.text = f_nombre_proveedor(codigo_empresa,This.text)
iF Trim(st_proveedor.text) = "" Then
	IF Trim(em_proveedor.text)<>"" Then
	f_activar_campo(em_proveedor)
END IF
em_proveedor.text = ""
END iF
apartados.pagina_2.dw_pagina2.Retrieve(em_proveedor.text)

end event

type dw_famiproc from u_datawindow within pagina_3
boolean visible = false
integer x = 14
integer y = 24
integer width = 178
integer height = 96
integer taborder = 2
string dataobject = "dw_venfampro2"
end type

type dw_tecnicos2 from u_datawindow within pagina_4
boolean visible = false
integer x = 9
integer y = 24
integer width = 242
integer height = 148
integer taborder = 2
string dataobject = "dw_ventecnicos"
end type

type pb_calculadora from picture within w_mant_comcabpedpro
integer x = 1079
integer y = 184
integer width = 101
integer height = 84
boolean bringtotop = true
string picturename = "c:\bmp\calcula.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From comcabpedpro
 Where  comcabpedpro.empresa = :codigo_empresa
 and comcabpedpro.anyo = :em_anyo.text;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,comcabpedpro.pedido)+1) Into :sle_valor.text
  From  comcabpedpro
  Where  comcabpedpro.empresa = :codigo_empresa
  And comcabpedpro.anyo       = :em_anyo.text;
 END IF
 apartados.pagina_1.dw_pagina1.triggerevent(clicked!)
end event

type em_anyo from u_em_campo within w_mant_comcabpedpro
integer x = 485
integer y = 184
integer taborder = 0
end type

type cb_lineas from commandbutton within w_mant_comcabpedpro
integer x = 2194
integer y = 172
integer width = 288
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Lineas"
end type

event clicked;if isnull(sle_valor.text) or sle_valor.text="" then
	messagebox("No hay pedido seleccionado","Introduzca el nº de Pedido")
	sle_valor.setfocus()
	return
end if

str_parametros lstr_param
lstr_param.i_nargumentos=4
lstr_param.s_argumentos[2]=sle_valor.text
lstr_param.s_argumentos[3]=em_anyo.text
lstr_param.s_argumentos[4]=f_prov(em_anyo.text,sle_valor.text)
OpenWithParm(w_mant_comlinpedpro2, lstr_param)
end event

type pb_imprimir from upb_imprimir within w_mant_comcabpedpro
integer x = 2482
integer y = 172
integer taborder = 0
boolean bringtotop = true
end type

event clicked;call super::clicked;if isnull(sle_valor.text) or sle_valor.text="" then
	messagebox("No hay pedido seleccionado","Introduzca el nº de Pedido")
	sle_valor.setfocus()
	return
end if

dw_carta.Retrieve(codigo_empresa,'1','1',em_anyo.text,sle_valor.text)
f_imprimir_datawindow(dw_carta)
//dw_carta.Print(TRUE) 




end event

type gb_1 from groupbox within w_mant_comcabpedpro
integer x = 1317
integer y = 132
integer width = 1298
integer height = 148
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type dw_carta from datawindow within w_mant_comcabpedpro
boolean visible = false
integer x = 2875
integer y = 104
integer width = 174
integer height = 88
integer taborder = 20
boolean bringtotop = true
string dataobject = "report_carta_compedidos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

