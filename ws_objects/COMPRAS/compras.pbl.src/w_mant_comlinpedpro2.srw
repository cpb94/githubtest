$PBExportHeader$w_mant_comlinpedpro2.srw
forward
global type w_mant_comlinpedpro2 from w_int_con_empresa
end type
type dw_1 from datawindow within w_mant_comlinpedpro2
end type
type st_1 from statictext within w_mant_comlinpedpro2
end type
type st_2 from statictext within w_mant_comlinpedpro2
end type
type st_3 from statictext within w_mant_comlinpedpro2
end type
type st_4 from statictext within w_mant_comlinpedpro2
end type
type st_5 from statictext within w_mant_comlinpedpro2
end type
type uo_prima from u_em_campo_2 within w_mant_comlinpedpro2
end type
type uo_medida from u_em_campo_2 within w_mant_comlinpedpro2
end type
type em_cantidad from u_em_campo within w_mant_comlinpedpro2
end type
type em_precio from u_em_campo within w_mant_comlinpedpro2
end type
type em_fechaent from u_em_campo within w_mant_comlinpedpro2
end type
type cb_insertar from commandbutton within w_mant_comlinpedpro2
end type
type cb_grabar from commandbutton within w_mant_comlinpedpro2
end type
type cb_borrar from commandbutton within w_mant_comlinpedpro2
end type
type pb_salir from upb_salir within w_mant_comlinpedpro2
end type
type em_anyo2 from singlelineedit within w_mant_comlinpedpro2
end type
type em_pedido from singlelineedit within w_mant_comlinpedpro2
end type
type st_8 from statictext within w_mant_comlinpedpro2
end type
type em_imp from editmask within w_mant_comlinpedpro2
end type
type st_imp from statictext within w_mant_comlinpedpro2
end type
type st_proveedor from statictext within w_mant_comlinpedpro2
end type
type dw_obs from u_datawindow within w_mant_comlinpedpro2
end type
type pb_1 from picturebutton within w_mant_comlinpedpro2
end type
type st_323 from statictext within w_mant_comlinpedpro2
end type
type uo_envase from u_em_campo_2 within w_mant_comlinpedpro2
end type
type st_moneda from statictext within w_mant_comlinpedpro2
end type
type gb_2 from groupbox within w_mant_comlinpedpro2
end type
type st_moneda2 from statictext within w_mant_comlinpedpro2
end type
type em_descuento from u_em_campo within w_mant_comlinpedpro2
end type
type st_descuento from statictext within w_mant_comlinpedpro2
end type
type uo_seccion from u_em_campo_2 within w_mant_comlinpedpro2
end type
type em_descripcion from u_em_campo within w_mant_comlinpedpro2
end type
type st_7 from statictext within w_mant_comlinpedpro2
end type
type pb_desplegar from picturebutton within w_mant_comlinpedpro2
end type
type st_9 from statictext within w_mant_comlinpedpro2
end type
type gb_1 from groupbox within w_mant_comlinpedpro2
end type
type pb_seccion from picturebutton within w_mant_comlinpedpro2
end type
end forward

shared variables

end variables

global type w_mant_comlinpedpro2 from w_int_con_empresa
integer width = 3675
integer height = 2032
string icon = "Application!"
dw_1 dw_1
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
uo_prima uo_prima
uo_medida uo_medida
em_cantidad em_cantidad
em_precio em_precio
em_fechaent em_fechaent
cb_insertar cb_insertar
cb_grabar cb_grabar
cb_borrar cb_borrar
pb_salir pb_salir
em_anyo2 em_anyo2
em_pedido em_pedido
st_8 st_8
em_imp em_imp
st_imp st_imp
st_proveedor st_proveedor
dw_obs dw_obs
pb_1 pb_1
st_323 st_323
uo_envase uo_envase
st_moneda st_moneda
gb_2 gb_2
st_moneda2 st_moneda2
em_descuento em_descuento
st_descuento st_descuento
uo_seccion uo_seccion
em_descripcion em_descripcion
st_7 st_7
pb_desplegar pb_desplegar
st_9 st_9
gb_1 gb_1
pb_seccion pb_seccion
end type
global w_mant_comlinpedpro2 w_mant_comlinpedpro2

type variables
string numlinea
string arg_prov
string modo_d="up"
String seccion,subseccion,var_seccion,var_subseccion
String moneda,moneda_proveedor
Dec   cambio
int      decimales_precios
end variables

forward prototypes
public function string f_ultima_linea ()
public function boolean f_act_precio_mprima (string arg_mp, decimal arg_prec)
public function boolean f_act_unimedida (string arg_mp, string arg_uni)
end prototypes

public function string f_ultima_linea ();string maxlinea
Select max(convert(int,comlinpedpro.linea)+1)
  Into   :maxlinea
  From   comlinpedpro
  Where comlinpedpro.empresa = :codigo_empresa
  and comlinpedpro.anyo = :em_anyo2.text
  and comlinpedpro.pedido = :em_pedido.text;
  
  If  isnull(maxlinea) or sqlca.sqlcode=100 then
	  maxlinea="1"
  end if
  return maxlinea
end function

public function boolean f_act_precio_mprima (string arg_mp, decimal arg_prec);boolean bien
datetime fechcomp

fechcomp=DateTime(today())

	UPDATE comartpro
	SET precio = :arg_prec,
		 fecha  = :fechcomp
	WHERE ( comartpro.empresa   = :codigo_empresa ) AND
			( comartpro.proveedor = :arg_prov ) AND
			( comartpro.mprima    = :arg_mp )   ;
		
   if sqlca.sqlcode<>0 then
		messagebox("Error al actualizar precio",sqlca.sqlerrtext)
		bien=true
		rollback;
	else
		commit;
	end if

return bien
	


end function

public function boolean f_act_unimedida (string arg_mp, string arg_uni);boolean bien = false

  UPDATE venmprima SET tipo_unidad = :arg_uni  
   WHERE ( venmprima.empresa = :codigo_empresa ) AND  
         ( venmprima.codigo = :arg_mp )   ;
			
   if sqlca.sqlcode<>0 then
		messagebox("Error al actualizar unidad",sqlca.sqlerrtext)
		bien=true
		rollback;
	else
		commit;
	end if

return bien
	

end function

on w_mant_comlinpedpro2.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.uo_prima=create uo_prima
this.uo_medida=create uo_medida
this.em_cantidad=create em_cantidad
this.em_precio=create em_precio
this.em_fechaent=create em_fechaent
this.cb_insertar=create cb_insertar
this.cb_grabar=create cb_grabar
this.cb_borrar=create cb_borrar
this.pb_salir=create pb_salir
this.em_anyo2=create em_anyo2
this.em_pedido=create em_pedido
this.st_8=create st_8
this.em_imp=create em_imp
this.st_imp=create st_imp
this.st_proveedor=create st_proveedor
this.dw_obs=create dw_obs
this.pb_1=create pb_1
this.st_323=create st_323
this.uo_envase=create uo_envase
this.st_moneda=create st_moneda
this.gb_2=create gb_2
this.st_moneda2=create st_moneda2
this.em_descuento=create em_descuento
this.st_descuento=create st_descuento
this.uo_seccion=create uo_seccion
this.em_descripcion=create em_descripcion
this.st_7=create st_7
this.pb_desplegar=create pb_desplegar
this.st_9=create st_9
this.gb_1=create gb_1
this.pb_seccion=create pb_seccion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.st_5
this.Control[iCurrent+7]=this.uo_prima
this.Control[iCurrent+8]=this.uo_medida
this.Control[iCurrent+9]=this.em_cantidad
this.Control[iCurrent+10]=this.em_precio
this.Control[iCurrent+11]=this.em_fechaent
this.Control[iCurrent+12]=this.cb_insertar
this.Control[iCurrent+13]=this.cb_grabar
this.Control[iCurrent+14]=this.cb_borrar
this.Control[iCurrent+15]=this.pb_salir
this.Control[iCurrent+16]=this.em_anyo2
this.Control[iCurrent+17]=this.em_pedido
this.Control[iCurrent+18]=this.st_8
this.Control[iCurrent+19]=this.em_imp
this.Control[iCurrent+20]=this.st_imp
this.Control[iCurrent+21]=this.st_proveedor
this.Control[iCurrent+22]=this.dw_obs
this.Control[iCurrent+23]=this.pb_1
this.Control[iCurrent+24]=this.st_323
this.Control[iCurrent+25]=this.uo_envase
this.Control[iCurrent+26]=this.st_moneda
this.Control[iCurrent+27]=this.gb_2
this.Control[iCurrent+28]=this.st_moneda2
this.Control[iCurrent+29]=this.em_descuento
this.Control[iCurrent+30]=this.st_descuento
this.Control[iCurrent+31]=this.uo_seccion
this.Control[iCurrent+32]=this.em_descripcion
this.Control[iCurrent+33]=this.st_7
this.Control[iCurrent+34]=this.pb_desplegar
this.Control[iCurrent+35]=this.st_9
this.Control[iCurrent+36]=this.gb_1
this.Control[iCurrent+37]=this.pb_seccion
end on

on w_mant_comlinpedpro2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.uo_prima)
destroy(this.uo_medida)
destroy(this.em_cantidad)
destroy(this.em_precio)
destroy(this.em_fechaent)
destroy(this.cb_insertar)
destroy(this.cb_grabar)
destroy(this.cb_borrar)
destroy(this.pb_salir)
destroy(this.em_anyo2)
destroy(this.em_pedido)
destroy(this.st_8)
destroy(this.em_imp)
destroy(this.st_imp)
destroy(this.st_proveedor)
destroy(this.dw_obs)
destroy(this.pb_1)
destroy(this.st_323)
destroy(this.uo_envase)
destroy(this.st_moneda)
destroy(this.gb_2)
destroy(this.st_moneda2)
destroy(this.em_descuento)
destroy(this.st_descuento)
destroy(this.uo_seccion)
destroy(this.em_descripcion)
destroy(this.st_7)
destroy(this.pb_desplegar)
destroy(this.st_9)
destroy(this.gb_1)
destroy(this.pb_seccion)
end on

event ue_recuperar;call super::ue_recuperar;//em_anyo2.text=string(Year(Today()))
// Valores Para Funcion de bloqueo


titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(em_anyo2.text))
criterio[2]   =  trim(em_anyo2.text)+space(20-longitud)
longitud      =  len(trim(em_pedido.text))
criterio[3]   =  trim(em_pedido.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         = "comlinpedpro"


dw_1.Retrieve(codigo_empresa,em_anyo2.text,em_pedido.Text)
CALL Super::ue_recuperar

end event

event open;call super::open;int  anyo
long pedido


istr_parametros.s_titulo_ventana = "Mantenimiento de Lineas de Pedidos a Proveedores"
istr_parametros.s_listado        = ""
This.title = istr_parametros.s_titulo_ventana
  
//tipo_mantenimiento ="C"
//dw_1.SetRowFocusIndicator(Hand!)
dw_1.SetTransObject(SQLCA)
dw_obs.SetTransObject(SQLCA)

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	em_anyo2.text  = istr_parametros.s_argumentos[3]
   em_pedido.text = istr_parametros.s_argumentos[2]
	arg_prov       = istr_parametros.s_argumentos[4]
	st_proveedor.text = f_nombre_proveedor(codigo_empresa,istr_parametros.s_argumentos[4])

	anyo   = dec(em_anyo2.text)
	pedido = dec(em_pedido.text)
	
	select moneda,			decimales_precios,			cambio	
	into   :moneda,		:decimales_precios,			:cambio	
	from   comcabpedpro
	where  empresa = :codigo_empresa
	and    anyo    = :anyo
	and    pedido  = :pedido;
	
	if isnull(moneda) then moneda = ""
	if isnull(decimales_precios) then decimales_precios = 0
	if isnull(cambio) then cambio = 0
	
	moneda_proveedor = f_moneda_genter(codigo_empresa,"P",arg_prov)

	em_precio.setmask(DecimalMask!,f_mascara_decimales(decimales_precios))
	em_imp.setmask(DecimalMask!,f_mascara_moneda(moneda))		
		
	st_moneda.text = f_nombre_moneda_abr(moneda)
	st_moneda2.text = f_nombre_moneda_abr(moneda)
	
	TriggerEvent("ue_recuperar")
	f_activar_campo(uo_prima.em_campo)

END IF

cb_grabar.enabled = TRUE
cb_insertar.enabled = FALSE
cb_borrar.enabled = FALSE
pb_desplegar.enabled=false


end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_cursor_abajo(dw_1)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_cursor_arriba(dw_1)
end event

event ue_f2;call super::ue_f2;cb_insertar.triggerevent(clicked!)
end event

event ue_f3;call super::ue_f3;cb_grabar.triggerevent(clicked!)
end event

event ue_f4;call super::ue_f4;cb_borrar.triggerevent(clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_mant_comlinpedpro2
integer x = 681
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_mant_comlinpedpro2
end type

type st_empresa from w_int_con_empresa`st_empresa within w_mant_comlinpedpro2
end type

type dw_1 from datawindow within w_mant_comlinpedpro2
integer y = 244
integer width = 3607
integer height = 1256
boolean bringtotop = true
string dataobject = "dw_comlinpedpro"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF Row = 0 Then Return
cb_grabar.enabled = TRUE
cb_insertar.enabled = TRUE
cb_borrar.enabled = TRUE
pb_desplegar.enabled = true

uo_prima.em_codigo.text    = dw_1.GetItemString(Row,"mprima")
uo_prima.em_campo.text     = f_nombre_mprima(codigo_empresa,uo_prima.em_codigo.text)
uo_prima.ue_valor_anterior = uo_prima.em_campo.text

em_cantidad.text         = string(dw_1.GetItemNumber(Row,"cantidad"))
em_precio.text           = String(dw_1.GetItemNumber(Row,"precio"))
em_fechaent.text         = String(date(dw_1.GetItemDateTime(Row,"fecha_entrega")))
uo_medida.em_codigo.text = dw_1.GetItemString(Row,"unidad_medida")
uo_medida.em_campo.text  = f_nombre_unimedida(uo_medida.em_codigo.text)
numlinea                 = dw_1.GetItemString(Row,"linea")
em_descripcion.text      = dw_1.GetItemString(Row,"descripcion")

dw_obs.Retrieve(dw_1.GetItemString(Row,"empresa"),dw_1.GetItemSTring(Row,"anyo"),dw_1.GetItemSTring(Row,"pedido"),dw_1.GetItemSTring(Row,"linea"))

em_imp.text = string(dw_1.GetItemNumber(Row,"comlinpedpro_importe"))
uo_prima.ue_valor_anterior=uo_prima.em_campo.text
uo_prima.em_campo.SetFocus()
uo_prima.em_campo.SelectText(1,Len(uo_prima.em_campo.Text))

uo_seccion.em_codigo.text    = dw_1.GetItemString(Row,"seccion")
uo_seccion.em_campo.text     = f_nombre_contaseccion(codigo_empresa,uo_seccion.em_codigo.text)
uo_seccion.ue_valor_anterior = uo_seccion.em_campo.text

//uo_subseccion.em_codigo.text=dw_1.GetItemString(Row,"subseccion")
//uo_subseccion.em_campo.text = f_nombre_contacoste(codigo_empresa,uo_seccion.em_codigo.text,uo_subseccion.em_codigo.text)
//uo_subseccion.ue_valor_anterior = uo_subseccion.em_campo.text

uo_envase.em_codigo.text    = dw_1.GetItemString(Row,"envase")
uo_envase.em_campo.text     = f_nombre_envase(uo_envase.em_codigo.text)
uo_envase.ue_valor_anterior = uo_envase.em_campo.text
end event

type st_1 from statictext within w_mant_comlinpedpro2
integer x = 23
integer y = 140
integer width = 334
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Anyo/Pedido:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_mant_comlinpedpro2
integer x = 101
integer y = 1500
integer width = 1385
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Mat.Prima"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_3 from statictext within w_mant_comlinpedpro2
integer x = 1490
integer y = 1500
integer width = 434
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cantidad"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_4 from statictext within w_mant_comlinpedpro2
integer x = 2194
integer y = 1500
integer width = 425
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Precio"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_5 from statictext within w_mant_comlinpedpro2
integer x = 2848
integer y = 1500
integer width = 283
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Entrega"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_prima from u_em_campo_2 within w_mant_comlinpedpro2
integer x = 5
integer y = 1580
integer width = 1481
integer height = 76
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;Boolean bien
dec     precio,cambio_moneda_proveedor,precio_nuevo

uo_prima.em_campo.text=f_nombre_mprima(codigo_empresa,uo_prima.em_codigo.text)
em_descripcion.text=f_nombre_mprima(codigo_empresa,uo_prima.em_codigo.text)
If Trim(uo_prima.em_campo.text)="" Then
	If Trim(uo_prima.em_codigo.text)<>"" then uo_prima.em_campo.SetFocus()
	uo_prima.em_campo.text=""
	uo_prima.em_codigo.text=""
	em_descripcion.text=""
end if

precio = f_precio_mprima(codigo_empresa,arg_prov,uo_prima.em_codigo.text)

if moneda <> moneda_proveedor then
	cambio_moneda_proveedor = f_cambio_moneda(moneda_proveedor)
	
	precio_nuevo = (precio / cambio_moneda_proveedor) * cambio
	
	precio_nuevo = round(precio_nuevo,decimales_precios)
	precio = precio_nuevo
end if

em_precio.text = string(precio)

uo_medida.em_codigo.text    = f_unimedida_mprima(codigo_empresa,uo_prima.em_codigo.text)
uo_medida.em_campo.text     = f_nombre_unimedida(uo_medida.em_codigo.text)
uo_envase.em_codigo.text    = f_envase_mprima(codigo_empresa,uo_prima.em_codigo.text)
uo_envase.em_campo.text     = f_nombre_envase_abr(uo_envase.em_codigo.text)
uo_seccion.em_codigo.text   = f_seccion_mprima(codigo_empresa,uo_prima.em_codigo.text)
uo_seccion.em_campo.text    = f_nombre_contaseccion(codigo_empresa,uo_seccion.em_codigo.text) 

uo_envase.ue_valor_anterior  = uo_envase.em_campo.text  
uo_medida.ue_valor_anterior  = uo_medida.em_campo.text  
uo_seccion.ue_valor_anterior = uo_seccion.em_codigo.text

if cb_insertar.enabled = false then
	em_fechaent.text=string(date(f_fentrega_cabped(codigo_empresa,em_anyo2.text,em_pedido.text)))
end if


end event

event getfocus;call super::getfocus;//ue_datawindow =  "dw_ayuda_primas_prove"
ue_datawindow =  "dw_ayuda_venmprima_compras"
ue_titulo     =  "AYUDA SELECCION DE MATERIAS PRIMAS POR PROVEEDOR"
ue_filtro     =  "proveedor='" + arg_prov +"'"
valor_empresa = TRUE
end event

on uo_prima.destroy
call u_em_campo_2::destroy
end on

type uo_medida from u_em_campo_2 within w_mant_comlinpedpro2
integer x = 1815
integer y = 1580
integer width = 110
integer height = 76
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_medida.em_campo.text=f_nombre_unimedida(uo_medida.em_codigo.text)

If Trim(uo_medida.em_campo.text)="" Then
	If Trim(uo_medida.em_codigo.text)<>"" then uo_medida.em_campo.SetFocus()
	uo_medida.em_campo.text=""
	uo_medida.em_codigo.text=""
end if

if f_unimedida_mprima(codigo_empresa,uo_prima.em_codigo.text)<> &
	uo_medida.em_codigo.text AND Trim(uo_medida.em_codigo.text) <> "" then
//	integer op
//	op=messagebox("Unidad de medida modificada","Desea modificar la unidad en la ficha del articulo",question!,yesno!)
//	if op=1 then
		f_act_unimedida(uo_prima.em_codigo.text,uo_medida.em_codigo.text)
//	end if
end if

end event

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_comunimedida"
ue_titulo     =  "AYUDA SELECCION DE UNIDADES DE MEDIDA"
ue_filtro     =  ""
valor_empresa = false
end event

on uo_medida.destroy
call u_em_campo_2::destroy
end on

type em_cantidad from u_em_campo within w_mant_comlinpedpro2
integer x = 1490
integer y = 1580
integer width = 325
integer height = 76
integer taborder = 50
integer weight = 400
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxxxx"
string displaydata = ""
end type

event modified;dec imp
imp = dec(em_cantidad.text) * dec(em_precio.text)
em_imp.text = string(imp)
end event

type em_precio from u_em_campo within w_mant_comlinpedpro2
integer x = 2194
integer y = 1580
integer width = 320
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,##0.0#"
end type

event modified;dec    precio,importe,descuento,cantidad
String proveedor,mascara_moneda,mprima

proveedor        = st_proveedor.text
mascara_moneda   = f_mascara_moneda(moneda)
mprima           = uo_prima.em_codigo.text
precio           = dec(this.text)
descuento        = dec(em_descuento.text)
cantidad         = dec(em_cantidad.text)

if precio <> 0 and moneda = moneda_proveedor then
	if f_precio_mprima(codigo_empresa,proveedor,mprima) <> precio then
		if messagebox("Precio modificado","Desea modificar el precio en la ficha del articulo",question!,yesno!) = 1 then
			//f_act_precio_mprima(proveedor,mprima,precio)
		end if
	end if
end if

importe = dec(string(cantidad * precio,mascara_moneda))

if descuento <> 0 then
	importe = importe - ((importe / 100) * descuento)
	importe = dec(string(importe,mascara_moneda))
end if

em_imp.text = string(importe)
end event

type em_fechaent from u_em_campo within w_mant_comlinpedpro2
integer x = 2848
integer y = 1580
integer width = 283
integer height = 76
integer taborder = 100
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type cb_insertar from commandbutton within w_mant_comlinpedpro2
integer x = 2560
integer y = 1724
integer width = 343
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F2 Insertar"
end type

event clicked;uo_prima.em_codigo.text  = ""
uo_prima.em_campo.text   = ""
em_cantidad.text         = ""
em_precio.text           = ""
em_imp.text              = ""
em_fechaent.text         = ""
uo_medida.em_codigo.text = ""
uo_medida.em_campo.text  = ""
em_descripcion.text      = ""
uo_prima.em_campo.SetFocus()
cb_grabar.enabled        = true
cb_borrar.enabled        = false
cb_insertar.enabled      = false
pb_desplegar.enabled     = false

uo_seccion.em_codigo.text    = ""
uo_seccion.em_campo.text     = ""
uo_seccion.ue_valor_anterior = ""
//uo_subseccion.em_codigo.text=subseccion
//uo_seccion.em_campo.text = f_nombre_contaseccion(codigo_empresa,uo_seccion.em_codigo.text)
//uo_subseccion.em_campo.text = f_nombre_contacoste(codigo_empresa,uo_seccion.em_codigo.text,uo_subseccion.em_codigo.text)
//uo_seccion.ue_valor_anterior = uo_seccion.em_campo.text
//uo_subseccion.ue_valor_anterior = uo_subseccion.em_campo.text
	
end event

type cb_grabar from commandbutton within w_mant_comlinpedpro2
integer x = 2903
integer y = 1724
integer width = 343
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F3 Grabar"
end type

event clicked;string   var_anyo,var_pedido,var_linea,var_mprima,var_medida,var_observaciones,var_envase,var_descripcion
decimal  var_cantidad,var_precio,var_descuento,var_importe
datetime var_entrega

var_anyo        = em_anyo2.text
var_pedido      = em_pedido.text
var_mprima      = uo_prima.em_codigo.text	
var_cantidad    = dec(em_cantidad.text)
var_precio      = dec(em_precio.text)
var_descuento   = dec(em_descuento.text)
var_importe     = dec(em_imp.text)
var_entrega     = datetime(date(em_fechaent.text))
var_medida      = uo_medida.em_codigo.text
var_envase      = uo_envase.em_codigo.text
var_descripcion = em_descripcion.text
var_seccion     = uo_seccion.em_codigo.text

IF dw_obs.RowCount() <> 0 Then
	var_observaciones = dw_obs.GetItemSTring(1,"observaciones")
END IF

if var_mprima="" Then
	uo_prima.em_campo.SetFocus()
	return
end if

if em_cantidad.text="" Then 
	em_cantidad.SetFocus()
	return
end if

if var_medida="" or isnull(var_medida) Then 
	uo_medida.em_campo.SetFocus()
	return
end if

if em_precio.text="" Then
	em_precio.SetFocus()
	return
end if

if em_fechaent.text="" Then
	em_fechaent.SetFocus()
	return
end if

If cb_insertar.enabled = FALSE And cb_grabar.enabled = TRUE and cb_borrar.enabled = FALSE Then
	var_linea=f_ultima_linea()
	
  INSERT INTO comlinpedpro  
           ( empresa,   
           anyo,   
           pedido,   
           linea,   
           mprima,   
           cantidad,   
           precio,   
           fecha_entrega,   
           unidad_medida,
			  observaciones,
			  descripcion,
			  seccion,
			  subseccion,
			  envase,
			  descuento,
			  importe)  
  VALUES ( :codigo_empresa,   
           :var_anyo,   
           :var_pedido,   
           :var_linea,   
           :var_mprima,   
           :var_cantidad,   
           :var_precio,   
           :var_entrega,   
           :var_medida,
			  :var_observaciones,
			  :var_descripcion,
			  :var_seccion,
			  :var_subseccion,
			  :var_envase,
			  :var_descuento,
			  :var_importe);
			  
	if sqlca.sqlcode <> 0 then 
		rollback;
		messagebox("Error al insertar línea",sqlca.sqlerrtext)
	else
		commit;
	end if
	dw_obs.update()
	commit;
	modo_d         = "up"
	dw_obs.visible = false
	pb_desplegar.PictureName = "\bmp\up.bmp"
	dw_1.Retrieve(codigo_empresa,em_anyo2.text,em_pedido.Text)
	uo_prima.em_codigo.text  = ""
	uo_prima.em_campo.text   = ""
	em_cantidad.text         = ""
	em_precio.text           = ""
	em_imp.text              = ""
	em_fechaent.text         = ""
	uo_medida.em_codigo.text = ""
	uo_medida.em_campo.text  = ""
	em_descripcion.text      = ""
	dw_obs.Reset()
	uo_prima.em_campo.SetFocus()
END IF

if cb_grabar.enabled = TRUE And cb_insertar.enabled = TRUE  And cb_borrar.enabled = TRUE Then
	var_linea = numlinea
	
	UPDATE comlinpedpro 
	SET    empresa       = :codigo_empresa, 
			 anyo          = :var_anyo,  
			 pedido        = :var_pedido,   
			 linea         = :var_linea,   
			 mprima        = :var_mprima,
			 cantidad      = :var_cantidad, 
			 precio        = :var_precio,  
			 fecha_entrega = :var_entrega,  
			 unidad_medida = :var_medida,
			 observaciones = :var_observaciones,
			 descripcion   = :var_descripcion,
			 seccion       = :var_seccion,
			 subseccion    = :var_subseccion,
			 envase        = :var_envase,
			 descuento     = :var_descuento,
			 importe       = :var_importe
	Where empresa = :codigo_empresa
	and   anyo    = :var_anyo
	and   pedido  = :var_pedido
	and   linea   = :var_linea;
	
	if sqlca.sqlcode <> 0 then
		rollback;
		messagebox("Error al modificar la línea",sqlca.sqlerrtext)
	else
		commit;
	end if
	dw_obs.update()
	commit;
	modo_d="up"
	dw_obs.visible=false
	pb_desplegar.PictureName = "\bmp\up.bmp"
	dw_1.Retrieve(codigo_empresa,em_anyo2.text,em_pedido.Text)
end if

end event

type cb_borrar from commandbutton within w_mant_comlinpedpro2
integer x = 3246
integer y = 1724
integer width = 343
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F4 Borrar"
end type

event clicked; string var_anyo,var_pedido,var_linea
  var_anyo=em_anyo2.text
  var_pedido=em_pedido.text
  var_linea=numlinea
 
 Delete From comlinpedpro  
 Where empresa = :codigo_empresa
 and anyo = :var_anyo
 and pedido = :var_pedido
 and linea = :var_linea;
 
dw_1.Retrieve(codigo_empresa,em_anyo2.text,em_pedido.Text)
uo_prima.em_codigo.text=""
uo_prima.em_campo.text=""
em_cantidad.text=""
em_precio.text=""
em_imp.text=""
em_fechaent.text=""
uo_medida.em_codigo.text=""
uo_medida.em_campo.text=""
em_descripcion.text=""
uo_prima.em_campo.SetFocus()
cb_grabar.enabled = TRUE
cb_borrar.enabled = false
cb_insertar.enabled = FALSE
pb_desplegar.enabled = FALSE
end event

type pb_salir from upb_salir within w_mant_comlinpedpro2
integer x = 3511
integer y = 4
integer width = 96
integer height = 100
integer taborder = 0
integer textsize = -8
fontcharset fontcharset = ansi!
end type

type em_anyo2 from singlelineedit within w_mant_comlinpedpro2
integer x = 361
integer y = 136
integer width = 247
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type em_pedido from singlelineedit within w_mant_comlinpedpro2
integer x = 654
integer y = 136
integer width = 247
integer height = 88
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_8 from statictext within w_mant_comlinpedpro2
integer x = 603
integer y = 144
integer width = 69
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "/"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_imp from editmask within w_mant_comlinpedpro2
integer x = 3136
integer y = 1580
integer width = 389
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,###,###"
string displaydata = "~b"
end type

type st_imp from statictext within w_mant_comlinpedpro2
integer x = 3136
integer y = 1500
integer width = 471
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Importe"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_proveedor from statictext within w_mant_comlinpedpro2
integer x = 910
integer y = 132
integer width = 1545
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_obs from u_datawindow within w_mant_comlinpedpro2
boolean visible = false
integer x = 91
integer y = 920
integer width = 1353
integer height = 492
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_comlinpedpro_observaciones"
boolean border = false
end type

type pb_1 from picturebutton within w_mant_comlinpedpro2
integer y = 1500
integer width = 101
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\carpeta.bmp"
alignment htextalign = left!
end type

event clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 1
lstr_param.s_argumentos[1]  = "w_mant_comlinpedpro2"

OpenWithParm(w_mant_venmprima2,lstr_param)  

end event

type st_323 from statictext within w_mant_comlinpedpro2
integer x = 1925
integer y = 1500
integer width = 265
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Env."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_envase from u_em_campo_2 within w_mant_comlinpedpro2
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 1925
integer y = 1580
integer width = 265
integer height = 76
integer taborder = 60
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_envase.em_campo.text=f_nombre_envase_abr(uo_envase.em_codigo.text)
If Trim(uo_envase.em_campo.text)="" Then
	If Trim(uo_envase.em_codigo.text)<>"" then uo_envase.em_campo.SetFocus()
	uo_envase.em_campo.text=""
	uo_envase.em_codigo.text=""
end if

end event

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_venenvases"
ue_titulo     =  "AYUDA SELECCION DE ENVASES"
ue_filtro     =  ""
valor_empresa = TRUE
end event

on uo_envase.destroy
call u_em_campo_2::destroy
end on

type st_moneda from statictext within w_mant_comlinpedpro2
integer x = 2519
integer y = 1596
integer width = 87
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_mant_comlinpedpro2
integer y = 80
integer width = 3602
integer height = 164
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type st_moneda2 from statictext within w_mant_comlinpedpro2
integer x = 3529
integer y = 1596
integer width = 73
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type em_descuento from u_em_campo within w_mant_comlinpedpro2
integer x = 2624
integer y = 1580
integer width = 219
integer height = 76
integer taborder = 80
integer weight = 400
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "#0.00"
end type

event modified;dec    precio,importe,descuento,cantidad
String mascara_moneda

mascara_moneda   = f_mascara_moneda(moneda)
precio           = dec(em_precio.text)
descuento        = dec(this.text)
cantidad         = dec(em_cantidad.text)

importe = dec(string(cantidad * precio,mascara_moneda))

if descuento <> 0 then
	importe = importe - ((importe / 100) * descuento)
	importe = dec(string(importe,mascara_moneda))
end if

em_imp.text = string(importe)
end event

type st_descuento from statictext within w_mant_comlinpedpro2
integer x = 2624
integer y = 1500
integer width = 219
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "% Dto"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_seccion from u_em_campo_2 within w_mant_comlinpedpro2
integer x = 1618
integer y = 1740
integer width = 919
integer height = 76
integer taborder = 120
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;
this.em_campo.text = f_nombre_contaseccion(codigo_empresa,this.em_codigo.text)

If Trim(this.em_campo.text) = "" Then	
	this.em_campo.text  = ""
	this.em_codigo.text = ""
	this.em_campo.SetFocus()
end if

end event

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_contaseccion"
ue_titulo     =  "AYUDA SELECCIÓN DE SECCIONES"
ue_filtro     =  ""
valor_empresa = TRUE
end event

on uo_seccion.destroy
call u_em_campo_2::destroy
end on

type em_descripcion from u_em_campo within w_mant_comlinpedpro2
integer y = 1740
integer width = 1618
integer height = 76
integer taborder = 110
integer weight = 400
fontcharset fontcharset = ansi!
string facename = "Arial"
string displaydata = ""
end type

type st_7 from statictext within w_mant_comlinpedpro2
integer y = 1660
integer width = 1527
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Descripción"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type pb_desplegar from picturebutton within w_mant_comlinpedpro2
integer x = 1527
integer y = 1660
integer width = 91
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\up.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;if modo_d="up" then
	modo_d="down"
	IF dw_obs.Retrieve(codigo_empresa,em_anyo2.text,em_pedido.Text,numlinea)= 0 Then
		dw_obs.InsertRow(1)
		dw_obs.SetItem(1,"empresa",codigo_empresa)
		dw_obs.SetItem(1,"anyo",em_anyo2.text)
		dw_obs.SetItem(1,"pedido",em_pedido.Text)
		dw_obs.SetItem(1,"linea",numlinea)
	END IF
	dw_obs.visible=true
	dw_obs.setfocus()
	pb_desplegar.PictureName = "\bmp\down.bmp"
else
	modo_d="up"
	dw_obs.visible=false
	em_descripcion.setfocus()
	pb_desplegar.PictureName = "\bmp\up.bmp"
end if
end event

type st_9 from statictext within w_mant_comlinpedpro2
integer x = 1618
integer y = 1660
integer width = 818
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Sección"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_mant_comlinpedpro2
integer x = 2546
integer y = 1680
integer width = 1056
integer height = 140
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type pb_seccion from picturebutton within w_mant_comlinpedpro2
integer x = 2437
integer y = 1660
integer width = 101
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\carpeta.bmp"
alignment htextalign = left!
end type

event clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 1
lstr_param.s_argumentos[1]  = "w_mant_comlinpedpro2"

OpenWithParm(w_mant_contaseccion,lstr_param)

end event

