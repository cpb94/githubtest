$PBExportHeader$w_cancelacion_anticipos.srw
$PBExportComments$cancelación de anticipos
forward
global type w_cancelacion_anticipos from w_int_con_empresa
end type
type gb_56 from groupbox within w_cancelacion_anticipos
end type
type gb_2 from groupbox within w_cancelacion_anticipos
end type
type gb_1 from groupbox within w_cancelacion_anticipos
end type
type gb_5 from groupbox within w_cancelacion_anticipos
end type
type gb_3 from groupbox within w_cancelacion_anticipos
end type
type pb_1 from upb_salir within w_cancelacion_anticipos
end type
type cb_consultar from commandbutton within w_cancelacion_anticipos
end type
type em_anyo from editmask within w_cancelacion_anticipos
end type
type st_8 from statictext within w_cancelacion_anticipos
end type
type em_vencimiento from u_em_campo within w_cancelacion_anticipos
end type
type em_plazo_real from u_em_campo within w_cancelacion_anticipos
end type
type st_9 from statictext within w_cancelacion_anticipos
end type
type em_anticipo from u_em_campo within w_cancelacion_anticipos
end type
type st_nombre_banco from statictext within w_cancelacion_anticipos
end type
type cb_procesar from commandbutton within w_cancelacion_anticipos
end type
type em_fcontable from editmask within w_cancelacion_anticipos
end type
type st_22 from statictext within w_cancelacion_anticipos
end type
type gb_4 from groupbox within w_cancelacion_anticipos
end type
type rb_1 from radiobutton within w_cancelacion_anticipos
end type
type rb_2 from radiobutton within w_cancelacion_anticipos
end type
type cb_cancelar from commandbutton within w_cancelacion_anticipos
end type
type st_1 from statictext within w_cancelacion_anticipos
end type
type st_2 from statictext within w_cancelacion_anticipos
end type
type st_boton_anticipo from statictext within w_cancelacion_anticipos
end type
type em_banco from u_em_campo within w_cancelacion_anticipos
end type
type dw_1 from datawindow within w_cancelacion_anticipos
end type
type st_nombre_moneda from statictext within w_cancelacion_anticipos
end type
type em_cambio from editmask within w_cancelacion_anticipos
end type
type st_3 from statictext within w_cancelacion_anticipos
end type
type em_divisas_cancelar from editmask within w_cancelacion_anticipos
end type
type em_importe_cancelar from editmask within w_cancelacion_anticipos
end type
type st_4 from statictext within w_cancelacion_anticipos
end type
type st_5 from statictext within w_cancelacion_anticipos
end type
type st_6 from statictext within w_cancelacion_anticipos
end type
type em_asiento from editmask within w_cancelacion_anticipos
end type
type st_546 from statictext within w_cancelacion_anticipos
end type
type st_situacion from statictext within w_cancelacion_anticipos
end type
type cbx_dar_por_cobrado from checkbox within w_cancelacion_anticipos
end type
type cbx_efecto_ya_cobrado from checkbox within w_cancelacion_anticipos
end type
type cbx_desglosar_gastos_en_cta_banco from checkbox within w_cancelacion_anticipos
end type
type dw_3 from datawindow within w_cancelacion_anticipos
end type
type cbx_cancelados from checkbox within w_cancelacion_anticipos
end type
end forward

global type w_cancelacion_anticipos from w_int_con_empresa
integer width = 2907
integer height = 1664
gb_56 gb_56
gb_2 gb_2
gb_1 gb_1
gb_5 gb_5
gb_3 gb_3
pb_1 pb_1
cb_consultar cb_consultar
em_anyo em_anyo
st_8 st_8
em_vencimiento em_vencimiento
em_plazo_real em_plazo_real
st_9 st_9
em_anticipo em_anticipo
st_nombre_banco st_nombre_banco
cb_procesar cb_procesar
em_fcontable em_fcontable
st_22 st_22
gb_4 gb_4
rb_1 rb_1
rb_2 rb_2
cb_cancelar cb_cancelar
st_1 st_1
st_2 st_2
st_boton_anticipo st_boton_anticipo
em_banco em_banco
dw_1 dw_1
st_nombre_moneda st_nombre_moneda
em_cambio em_cambio
st_3 st_3
em_divisas_cancelar em_divisas_cancelar
em_importe_cancelar em_importe_cancelar
st_4 st_4
st_5 st_5
st_6 st_6
em_asiento em_asiento
st_546 st_546
st_situacion st_situacion
cbx_dar_por_cobrado cbx_dar_por_cobrado
cbx_efecto_ya_cobrado cbx_efecto_ya_cobrado
cbx_desglosar_gastos_en_cta_banco cbx_desglosar_gastos_en_cta_banco
dw_3 dw_3
cbx_cancelados cbx_cancelados
end type
global w_cancelacion_anticipos w_cancelacion_anticipos

type variables
string filtro

editmask isle_campo 
integer var_ejercicio
string istr_factura

int istr_prorroga
string inst_mascara_moneda
integer inst_situacion
end variables

forward prototypes
public subroutine f_desactiva ()
public subroutine f_activa ()
public subroutine f_nueva_divisa ()
public function string f_mascara ()
public subroutine f_nuevo_importe ()
public subroutine f_desactivar_importes ()
public subroutine f_activar_importes ()
public function integer f_maxima_liquidacion (string par_empresa, integer par_anyo, string par_banco, integer par_contador, integer par_prorroga)
end prototypes

public subroutine f_desactiva ();em_banco.enabled = false
em_anyo.enabled = false
em_anticipo.enabled = false
st_boton_anticipo.enabled = false
end subroutine

public subroutine f_activa ();em_banco.enabled = true
em_anyo.enabled = true
em_anticipo.enabled = true
st_boton_anticipo.enabled = true
end subroutine

public subroutine f_nueva_divisa ();em_importe_cancelar.text = string(dec(em_divisas_cancelar.text) / dec(em_cambio.text))
end subroutine

public function string f_mascara ();str_paramemp par
string m 

par = f_paramemp(codigo_empresa)

m = par.moneda_emp

return m
end function

public subroutine f_nuevo_importe ();em_cambio.text = string(dec(em_importe_cancelar.text) * dec(em_divisas_cancelar.text))
end subroutine

public subroutine f_desactivar_importes ();em_divisas_cancelar.enabled = false
em_importe_cancelar.enabled = false
em_cambio.enabled = false
end subroutine

public subroutine f_activar_importes ();em_divisas_cancelar.enabled = true
em_importe_cancelar.enabled = true
em_cambio.enabled = true
end subroutine

public function integer f_maxima_liquidacion (string par_empresa, integer par_anyo, string par_banco, integer par_contador, integer par_prorroga);int maxim

select max(liquidacion) into :maxim
from carfinanliq
where (carfinanliq.empresa = :par_empresa)		and
		(carfinanliq.anyo = :par_anyo)				and
		(carfinanliq.bancofinan = :par_banco)		and
		(carfinanliq.contador = :par_contador)		and
		(carfinanliq.num_prorroga = :par_prorroga);
if isnull(maxim) then maxim = 0

return maxim
end function

event open;call super::open;istr_parametros.s_titulo_ventana="Cancelación de Anticipos"
This.title=istr_parametros.s_titulo_ventana



dw_1.settransobject(sqlca)
dw_3.settransobject(sqlca)

em_anyo.text = string(year(today()))

dw_3.visible = false

dw_1.enabled = false
// En istr_prorroga tenemos la prorroga del anticipo seleccionado
// Inicialmente -1

istr_prorroga = -1

em_fcontable.text = string(today())

//rb_1.checked = false
//rb_2.checked = true

f_desactivar_importes()
end event

on w_cancelacion_anticipos.create
int iCurrent
call super::create
this.gb_56=create gb_56
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_5=create gb_5
this.gb_3=create gb_3
this.pb_1=create pb_1
this.cb_consultar=create cb_consultar
this.em_anyo=create em_anyo
this.st_8=create st_8
this.em_vencimiento=create em_vencimiento
this.em_plazo_real=create em_plazo_real
this.st_9=create st_9
this.em_anticipo=create em_anticipo
this.st_nombre_banco=create st_nombre_banco
this.cb_procesar=create cb_procesar
this.em_fcontable=create em_fcontable
this.st_22=create st_22
this.gb_4=create gb_4
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cb_cancelar=create cb_cancelar
this.st_1=create st_1
this.st_2=create st_2
this.st_boton_anticipo=create st_boton_anticipo
this.em_banco=create em_banco
this.dw_1=create dw_1
this.st_nombre_moneda=create st_nombre_moneda
this.em_cambio=create em_cambio
this.st_3=create st_3
this.em_divisas_cancelar=create em_divisas_cancelar
this.em_importe_cancelar=create em_importe_cancelar
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.em_asiento=create em_asiento
this.st_546=create st_546
this.st_situacion=create st_situacion
this.cbx_dar_por_cobrado=create cbx_dar_por_cobrado
this.cbx_efecto_ya_cobrado=create cbx_efecto_ya_cobrado
this.cbx_desglosar_gastos_en_cta_banco=create cbx_desglosar_gastos_en_cta_banco
this.dw_3=create dw_3
this.cbx_cancelados=create cbx_cancelados
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_56
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.gb_5
this.Control[iCurrent+5]=this.gb_3
this.Control[iCurrent+6]=this.pb_1
this.Control[iCurrent+7]=this.cb_consultar
this.Control[iCurrent+8]=this.em_anyo
this.Control[iCurrent+9]=this.st_8
this.Control[iCurrent+10]=this.em_vencimiento
this.Control[iCurrent+11]=this.em_plazo_real
this.Control[iCurrent+12]=this.st_9
this.Control[iCurrent+13]=this.em_anticipo
this.Control[iCurrent+14]=this.st_nombre_banco
this.Control[iCurrent+15]=this.cb_procesar
this.Control[iCurrent+16]=this.em_fcontable
this.Control[iCurrent+17]=this.st_22
this.Control[iCurrent+18]=this.gb_4
this.Control[iCurrent+19]=this.rb_1
this.Control[iCurrent+20]=this.rb_2
this.Control[iCurrent+21]=this.cb_cancelar
this.Control[iCurrent+22]=this.st_1
this.Control[iCurrent+23]=this.st_2
this.Control[iCurrent+24]=this.st_boton_anticipo
this.Control[iCurrent+25]=this.em_banco
this.Control[iCurrent+26]=this.dw_1
this.Control[iCurrent+27]=this.st_nombre_moneda
this.Control[iCurrent+28]=this.em_cambio
this.Control[iCurrent+29]=this.st_3
this.Control[iCurrent+30]=this.em_divisas_cancelar
this.Control[iCurrent+31]=this.em_importe_cancelar
this.Control[iCurrent+32]=this.st_4
this.Control[iCurrent+33]=this.st_5
this.Control[iCurrent+34]=this.st_6
this.Control[iCurrent+35]=this.em_asiento
this.Control[iCurrent+36]=this.st_546
this.Control[iCurrent+37]=this.st_situacion
this.Control[iCurrent+38]=this.cbx_dar_por_cobrado
this.Control[iCurrent+39]=this.cbx_efecto_ya_cobrado
this.Control[iCurrent+40]=this.cbx_desglosar_gastos_en_cta_banco
this.Control[iCurrent+41]=this.dw_3
this.Control[iCurrent+42]=this.cbx_cancelados
end on

on w_cancelacion_anticipos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_56)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_5)
destroy(this.gb_3)
destroy(this.pb_1)
destroy(this.cb_consultar)
destroy(this.em_anyo)
destroy(this.st_8)
destroy(this.em_vencimiento)
destroy(this.em_plazo_real)
destroy(this.st_9)
destroy(this.em_anticipo)
destroy(this.st_nombre_banco)
destroy(this.cb_procesar)
destroy(this.em_fcontable)
destroy(this.st_22)
destroy(this.gb_4)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cb_cancelar)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_boton_anticipo)
destroy(this.em_banco)
destroy(this.dw_1)
destroy(this.st_nombre_moneda)
destroy(this.em_cambio)
destroy(this.st_3)
destroy(this.em_divisas_cancelar)
destroy(this.em_importe_cancelar)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.em_asiento)
destroy(this.st_546)
destroy(this.st_situacion)
destroy(this.cbx_dar_por_cobrado)
destroy(this.cbx_efecto_ya_cobrado)
destroy(this.cbx_desglosar_gastos_en_cta_banco)
destroy(this.dw_3)
destroy(this.cbx_cancelados)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_cancelacion_anticipos
integer x = 2112
integer y = 20
integer width = 485
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_cancelacion_anticipos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_cancelacion_anticipos
integer width = 2427
integer height = 96
end type

type gb_56 from groupbox within w_cancelacion_anticipos
integer x = 2331
integer y = 988
integer width = 315
integer height = 308
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_2 from groupbox within w_cancelacion_anticipos
integer x = 1947
integer y = 988
integer width = 379
integer height = 308
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_1 from groupbox within w_cancelacion_anticipos
integer x = 1559
integer y = 988
integer width = 384
integer height = 308
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_5 from groupbox within w_cancelacion_anticipos
integer x = 1216
integer y = 988
integer width = 343
integer height = 308
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_3 from groupbox within w_cancelacion_anticipos
integer x = 1198
integer y = 924
integer width = 1472
integer height = 408
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type pb_1 from upb_salir within w_cancelacion_anticipos
integer x = 2688
integer y = 16
integer width = 142
integer height = 116
integer taborder = 0
end type

type cb_consultar from commandbutton within w_cancelacion_anticipos
integer x = 2336
integer y = 184
integer width = 325
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Consultar"
end type

event clicked;// ***********************************************************************
// CONTROL DE DATOS
// ************************************************************************



// Anticipo y banco
IF em_anticipo.text = "" or em_banco.text = "" then
	messagebox("Atención","Debe introducir los datos de BANCO y ANTICIPO")
	RETURN	
end if



// Comprobamos la situación del anticipo por si se ha introducido
// directamente sobre el campo "em_anticipo".
// La situación ha de ser 2, 3 ó 4
int la_situacion,el_anyo,el_anticipo,v_prorroga,li_efectos_pendientes

el_anyo     = integer(em_anyo.text)
el_anticipo = integer(em_anticipo.text)
v_prorroga  = istr_prorroga

//Vamos a comprobar si hay efectos pendientes de cobrar
select isnull(count(*),0)
into   :li_efectos_pendientes
from   carfinanefe,
		 carefectos
where  carfinanefe.empresa   = carefectos.empresa
and    carfinanefe.ejercicio = carefectos.anyo
and    carfinanefe.orden     = carefectos.orden
and    carefectos.situacion  = '8'
and    carfinanefe.empresa    = :codigo_empresa
and    carfinanefe.bancofinan = :em_banco.text
and    carfinanefe.contador   = :el_anticipo
and    carfinanefe.anyo       = :el_anyo;

if li_efectos_pendientes > 0 then
	cbx_dar_por_cobrado.enabled = true
	cbx_efecto_ya_cobrado.checked = false
else
	cbx_dar_por_cobrado.checked = false
	cbx_dar_por_cobrado.enabled = false
	cbx_efecto_ya_cobrado.checked = true
end if

//

select situacion into :la_situacion
from carfinan
where (carfinan.empresa = :codigo_empresa)	and
		(carfinan.anyo = :el_anyo)					and
		(carfinan.bancofinan = :em_banco.text)	and
		(carfinan.contador = :el_anticipo)		and
		(carfinan.num_prorroga = :v_prorroga);


f_activar_importes()


int opcion  
choose case la_situacion

	// Anticipos ya liqidados. Se pueden añadir nuevos gastos
	case 4
		opcion = messagebox("Atención","El anticipo ha sido liquidado, ¿Desea añadir algún gasto?",question!,yesno!,2)
		if opcion = 2 then
			em_anticipo.text = ""
			em_anticipo.setfocus()
			dw_1.reset()
			em_cambio.text = ""
			st_nombre_moneda.text = ""
			f_activa()
			em_anticipo.setfocus()
			return
		
		else
			f_desactivar_importes()
			rb_1.checked = true
			rb_2.checked = false
			rb_1.enabled = false
			rb_2.enabled = false
			
		end if


	// Anticipo abonado con o sin gastos
	case 2,3
	
	// Resto de situacones. No válidas
	case else
		em_anticipo.text = ""
		em_anticipo.setfocus()
		return

end choose

// Variable instancia para la situación

inst_situacion = la_situacion

st_situacion.text = string(inst_situacion,"##")



//  MOSTRAMOS DATOS DEL ANTICIPO (PRORROGA 0)
dw_1.retrieve(codigo_empresa,integer(em_anyo.text),em_banco.text,integer(em_anticipo.text),v_prorroga)

// Por defecto el cambio es el del abono
string la_moneda
dec{6} el_cambio,div,imp

select cambio_abono,moneda_abono,divisa_abono,importe_abono
	into :el_cambio, :la_moneda,:div, :imp
from carfinan
where (carfinan.empresa = :codigo_empresa)	and
		(carfinan.anyo = :el_anyo)					and
		(carfinan.bancofinan = :em_banco.text)	and
		(carfinan.contador = :el_anticipo)		and
		(carfinan.num_prorroga = :v_prorroga);
		
em_cambio.text = string(el_cambio,"###,###,##0.00##")
st_nombre_moneda.text = f_nombre_moneda_abr(la_moneda)
em_divisas_cancelar.text = string(div,f_mascara_moneda(la_moneda))
em_importe_cancelar.text = string(imp)


em_asiento.text = ""


end event

type em_anyo from editmask within w_cancelacion_anticipos
integer x = 1330
integer y = 188
integer width = 219
integer height = 88
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "yyyy"
string displaydata = "x"
end type

type st_8 from statictext within w_cancelacion_anticipos
integer x = 2958
integer y = 324
integer width = 416
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Vencimiento :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_vencimiento from u_em_campo within w_cancelacion_anticipos
integer x = 3378
integer y = 332
integer width = 270
integer taborder = 0
boolean border = false
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
string displaydata = ""
end type

type em_plazo_real from u_em_campo within w_cancelacion_anticipos
integer x = 3442
integer y = 424
integer width = 206
integer taborder = 0
boolean border = false
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = numericmask!
string mask = "##0"
string displaydata = "0"
end type

type st_9 from statictext within w_cancelacion_anticipos
integer x = 2935
integer y = 424
integer width = 379
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
boolean enabled = false
string text = "Plazo Real :"
boolean focusrectangle = false
end type

type em_anticipo from u_em_campo within w_cancelacion_anticipos
integer x = 1687
integer y = 192
integer width = 261
integer taborder = 20
long backcolor = 16777215
alignment alignment = right!
end type

event modified;call super::modified;dw_1.reset()



end event

type st_nombre_banco from statictext within w_cancelacion_anticipos
integer x = 366
integer y = 196
integer width = 914
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type cb_procesar from commandbutton within w_cancelacion_anticipos
integer x = 1989
integer y = 1060
integer width = 302
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
end type

event clicked;string   ls_cliente, ls_ampliacion,ls_factura,sel,banco,mascara_moneda_empresa,cliente,factura
long     total,indice,existe,orden_efecto,orden_efecto_nuevo
datetime fecha_cobro,el_vencimiento,la_fecha_abono
boolean  bien,nuevo_cambio,con_gastos
dec{2}   importe_cobrado,importe_anticipo,diferencia_cambio,importe_resto_anticipo,importe_efecto
int      opci,ejer_act,situ,anticipo_int,anyo_int,la_liquidacion,anyo_efecto
dec      cambio_cobro,cambio_anticipo,divisas_cobradas,divisas_anticipo,divisas_resto_anticipo
dec      divisas_efecto,cambio_efecto,divisas_canceladas_efectos,resto_divisas_efecto			
string cta_gene,ls_tipodoc,ls_situacion
		
str_carfinanliq liquidacion
str_carfinanefe carfinanefe
datastore efectos


//***********************************************************************
// Control de datos
//***********************************************************************

// Banco y anticipo
if em_anticipo.text = "" or em_banco.text = "" then
	f_mensaje("Atención","Debe introducir el Banco y el Nº de Anticipo")
	return
end if

// datos del anticipo
if dw_1.rowcount()= 0 then	
	f_mensaje("Atención","No hay datos sobre el anticipo")
	return
end if

// fecha contable
if not isdate(em_fcontable.text) then 	
	f_mensaje("Atención","Introduzca la fecha para el asiento contable")
	return
end if

bien = true
mascara_moneda_empresa = f_mascara_moneda(f_moneda_empresa(codigo_empresa))
fecha_cobro  = datetime(date(em_fcontable.text))
banco        = em_banco.text
cliente      = dw_1.object.cliente[dw_1.getrow()]
factura      = dw_1.object.factura[dw_1.getrow()]


// **********************************************************************
// EJERCICIO A PARTIR DE LA FECHA DEL APUNTE
// **********************************************************************

ejer_act = year(date(em_fcontable.text))

//*************************************************************************
// cancelar el anticipo
//*************************************************************************

opci = messagebox("Atención", "¿Desea cancelar el anticipo?",question!,yesno!,1)

if opci = 1 then
		
	// *********************************************************************
	// 	VARIABLE con_gastos. GASTOS AL ABONAR O NO 
	// *********************************************************************
	
	IF rb_1.checked then 
		con_gastos = true
	else
		con_gastos = false
	end if		
	
	anticipo_int = integer(em_anticipo.text)
	anyo_int     = integer(em_anyo.text)
	
	//Datos del cobro
	importe_cobrado  = dec(em_importe_cancelar.text)		
	divisas_cobradas = dec(em_divisas_cancelar.text)		
	cambio_cobro     = dec(em_cambio.text)
	
	//Datos del anticipo
	
	select importe_abono,
			 divisa_abono,
			 cambio_abono,
			 vencimiento,
			 fecha_abono
	into   :importe_anticipo,
			 :divisas_anticipo,
			 :cambio_anticipo,
			 :el_vencimiento,
			 :la_fecha_abono
	from   carfinan
	where (carfinan.empresa      = :codigo_empresa)	
	and	(carfinan.anyo         = :anyo_int)				
	and	(carfinan.bancofinan   = :em_banco.text)	
	and	(carfinan.contador     = :anticipo_int)		
	and	(carfinan.num_prorroga = :istr_prorroga);		

	if divisas_cobradas = divisas_anticipo then
		//Si cobramos la totalidad del anticipo,lo damos por liquidado
		//Situación 4 Liquidado
		
		update carfinan
		set    situacion = 4
		where (empresa      = :codigo_empresa)	and
				(bancofinan   = :em_banco.text)	and
				(contador     = :anticipo_int)	and
				(num_prorroga = :istr_prorroga)	and
				(anyo         = :anyo_int);
		
		if sqlca.sqlcode <> 0 then
			bien = false
		end if
	else
		//Si no cobramos el total dejamos el anticipo con el resto
		
		divisas_resto_anticipo = divisas_anticipo - divisas_cobradas
		
		importe_resto_anticipo = dec(string((divisas_resto_anticipo) / cambio_anticipo,mascara_moneda_empresa))
		
		update carfinan
		set    importe_abono = :importe_resto_anticipo,
				 divisa_abono  = :divisas_resto_anticipo
		where (empresa      = :codigo_empresa)	and
				(bancofinan   = :em_banco.text)	and
				(contador     = :anticipo_int)	and
				(num_prorroga = :istr_prorroga)	and
				(anyo         = :anyo_int);		
				
		if sqlca.sqlcode <> 0 then
			bien = false
		end if				
	end if
	
	
	
	if sqlca.sqlcode <> 0 and sqlca.sqlcode <> 100 then
		bien = false
	else
		if not(cbx_efecto_ya_cobrado.checked) then
			//Cambiamos la situación de los efectos que forman parte del anticipo
			//y que todavia estan marcados como anticipados
			sel = "select ejercicio,orden from carfinanefe "+&
					"where empresa  = '"+codigo_empresa+"' "+&
					"and bancofinan = '"+em_banco.text+"' "+&
					"and contador   =  "+string(anticipo_int,"##########0")+" "+&
					"and anyo       =  "+string(anyo_int,"###0")
					
			efectos = f_cargar_cursor(sel)						
			total   = efectos.rowcount()
			if total > 0 then
				divisas_canceladas_efectos = 0
				for indice = 1 to total
					if divisas_canceladas_efectos < divisas_cobradas then				
						anyo_efecto  = efectos.object.ejercicio[indice]
						orden_efecto = efectos.object.orden[indice]
						
						select count(*)
						into   :existe
						from   carefectos
						where  empresa   = :codigo_empresa
						and    anyo      = :anyo_efecto
						and    orden     = :orden_efecto
						and    situacion = "8";
						
						if isnull(existe) then existe = 0
						
						if existe = 1 then
							select divisas,
									 cambio,
									 tipodoc
							into   :divisas_efecto,
									 :cambio_efecto,
									 :ls_tipodoc
							from   carefectos
							where  empresa   = :codigo_empresa
							and    anyo      = :anyo_efecto
							and    orden     = :orden_efecto
							and    situacion = "8";					
							
							if (divisas_canceladas_efectos + divisas_efecto) > divisas_cobradas then
								//hay que dividir el efecto
								orden_efecto_nuevo   = f_orden_carparam(codigo_empresa,anyo_efecto)														
								resto_divisas_efecto = divisas_efecto - (divisas_cobradas - (divisas_canceladas_efectos))
								divisas_efecto       = divisas_cobradas - (divisas_canceladas_efectos)
								
								importe_efecto       = dec(string(divisas_efecto / cambio_efecto,mascara_moneda_empresa))
								
								if f_dividir_efecto(anyo_efecto,orden_efecto,resto_divisas_efecto,anyo_efecto,orden_efecto_nuevo) = 0 then
									bien = false
								end if
								
								update carefectos
								set    importe = :importe_efecto,
										 divisas = :divisas_efecto
								where  empresa = :codigo_empresa
								and    anyo    = :anyo_efecto
								and    orden   = :orden_efecto;
								
								if sqlca.sqlcode <> 0 then
									bien = false
								end if
								
								carfinanefe.empresa    = codigo_empresa
								carfinanefe.bancofinan = banco
								carfinanefe.contador   = anticipo_int
								carfinanefe.ejercicio  = anyo_efecto
								carfinanefe.orden      = orden_efecto_nuevo
								carfinanefe.anyo       = anyo_int
								
								select anyofra,
										 serie,
										 factura,
										 ffra,
										 recibo,
										 importe,
										 divisas,
										 cambio,
										 fvto,
										 monedas,
										 fpago
								into 	 :carfinanefe.anyo_fac,
										 :carfinanefe.serie_fac,
										 :carfinanefe.factura,
										 :carfinanefe.ffactura,
										 :carfinanefe.pago,
										 :carfinanefe.importe_efec,
										 :carfinanefe.divisas_efec,
										 :carfinanefe.cambio_efec,
										 :carfinanefe.vto_efec,								
										 :carfinanefe.moneda_efec,
										 :carfinanefe.fpago
								from   carefectos
								where  empresa = :codigo_empresa
								and    anyo    = :anyo_efecto
								and    orden   = :orden_efecto_nuevo;
								
								if sqlca.sqlcode <> 0 then
									bien = false
								end if
								
								if not(f_insert_carfinanefe(carfinanefe)) then
									bien = false
								end if
							end if
							
							divisas_canceladas_efectos = divisas_canceladas_efectos + divisas_efecto
							
							if cbx_dar_por_cobrado.checked then
								if not(f_cobrar_efecto(codigo_empresa,anyo_efecto,orden_efecto,divisas_efecto,cambio_cobro,fecha_cobro,banco)) then
									bien = false
								end if
							else		
								ls_situacion = f_tipodoc_situacion_pase_cartera(codigo_empresa,ls_tipodoc)
								
								update carefectos
								set    situacion = :ls_situacion
								where  empresa   = :codigo_empresa
								and    anyo      = :anyo_efecto
								and    orden     = :orden_efecto
								and    situacion = "8";					
								
								if sqlca.sqlcode <> 0 then
									bien = false
								end if						
							end if
							
						end if
					end if
				next
			end if		
		end if
	end if
	destroy efectos
			
	// *******************************************************************
	// 	CAMBIO
	// *******************************************************************+
	
	nuevo_cambio = false
		
	// Si hay un nuevo cambio
	//if cambio_anticipo <> dec(em_cambio.text) OR abonado <> importe_cobrado then
	if cambio_anticipo <> cambio_cobro then
		nuevo_cambio = true				
		diferencia_cambio = importe_anticipo - importe_cobrado		
//	else
//		importe_cobrado = importe_anticipo
	end if
	
	// ********************************************************************
	// INSERTAR LIQUIDACIÓN
	// *******************************************************************
	
	la_liquidacion = f_maxima_liquidacion(codigo_empresa,anyo_int,em_banco.text,anticipo_int,istr_prorroga) + 1
		
	liquidacion.empresa      = codigo_empresa
	liquidacion.anyo         = anyo_int
	liquidacion.bancofinan   = em_banco.text
	liquidacion.contador     = anticipo_int
	liquidacion.num_prorroga = istr_prorroga	
	liquidacion.liquidacion  = la_liquidacion 
	liquidacion.banco        = em_banco.text
	liquidacion.fecha        = datetime(date(em_fcontable.text))
	
	if inst_situacion <> 4 then
		liquidacion.cambio  = dec(em_cambio.text)  
		liquidacion.divisas = dec(em_divisas_cancelar.text)
		liquidacion.importe = dec(em_importe_cancelar.text)
	else
		// Si ya liquidado y sólo se añaden gastos 0 en la liquidación 
		liquidacion.cambio  = 1  
		liquidacion.divisas = 0
		liquidacion.importe = 0
	end if
	
	liquidacion.moneda = dw_1.getitemstring(1,"moneda")
		
	if not f_insert_carfinanliq(liquidacion) then bien = false
	
	// *********************************************************************
	//		OBTENEMOS LOS DATOS DE GASTOS EN OTRA PANTALLA	
	// *********************************************************************

	IF con_gastos 	then
	
		// Estructura para el pase de parámetros
		str_input_gastos_anticipos datos,datos_salida
		
		datos.banco 		= em_banco.text
		datos.anyo 			= integer(em_anyo.text)
		datos.contador 	= integer(em_anticipo.text)
		datos.prorroga 	= istr_prorroga
		// Pasamos el total del anticipo obtenido en la ventana
		datos.importe		= importe_cobrado
		// El tipo de documento es el anticipo (CÓDIGO 13)
		datos.tipodoc     = "13"
		// Sólo anticipos de extranjero
		datos.naci_extra  = "E"
		// Es una liquidación
		datos.abono_liq_teo = "L"
		// La fecha de liquidación la fecha contable
		datos.fecha_liquidacion = datetime(date(em_fcontable.text))
		// el nº de liquidación
		datos.num_liquidacion = la_liquidacion 
		// la situación
		datos.situacion   = inst_situacion				
		datos.vencimiento = el_vencimiento
		datos.fecha_abono = la_fecha_abono
		
		// Pantalla para obtener los gastos			
		openwithparm(w_input_gastos_anticipos,datos)
		
		datos_salida = Message.powerobjectparm 
		
		IF datos_salida.correcto = false THEN 
			messagebox("¡ Atención !","No se ha cancelado el anticipo")
			rollback;
			RETURN
		END IF
																			
	end if

	// *********************************************************************
	// ASIENTO CONTABLE
	// *********************************************************************

	str_contaapun apu  
	
	dec{2} el_saldo,total_saldo
	string la_cuenta,el_banco
	int    num_apunte,i
	boolean res 		
	datetime f_contable 
	
	f_contable  = datetime(date(em_fcontable.text))
	el_banco 	= Trim(em_banco.text)
		
	// Datos comunes a todos los apuntes
	
	num_apunte		= 0	// inicialmente 0, se incrementa con cada apunte
	apu.ejercicio 	= ejer_act
	apu.empresa 	= codigo_empresa
	apu.origen		= f_diario_contagene(codigo_empresa,"28")	
	apu.asiento		= f_ultimo_asiento(ejer_act,codigo_empresa,month(date(f_contable)),apu.origen)
	apu.fapunte		= f_contable
		
	setnull(apu.diario)
	Setnull(apu.tipoapu)
	setnull(apu.documento)
	setnull(apu.factura)
	setnull(apu.ffactura)
	setnull(apu.imponible)
	setnull(apu.tipoiva)
	setnull(apu.iva)
	setnull(apu.divisas)
	setnull(apu.deducible)
	setnull(apu.actualizado)
	setnull(apu.listado)
	setnull(apu.registro)
	
	setnull(apu.tipoter)
	setnull(apu.clipro)
	setnull(apu.conciliado)
	setnull(apu.nif)
	setnull(apu.punteado)
	// la fvalor es la fapunte
	apu.fvalor	= apu.fapunte
	setnull(apu.docpunteo)
	setnull(apu.coste)
	setnull(apu.fregistro)
	
	apu.cambio	=	1
	apu.moneda	=	f_moneda_empresa(codigo_empresa)
	apu.mes		=	month(date(f_contable))
	
	// ******************************************************************
	// APUNTE AL BANCO O AL CLIENTE,DEPENDIENDO DE SI DAMOS EL EFECTO POR COBRADO O NO
	// ******************************************************************
		
	//*******************************************************
	// 1. Apunte al banco
	// Hacemos un apunte por el importe y otro por los gastos
	//********************************************************
	
	// Apunte por importe del anticipo
	// Sólo si no ha sido liquidado y se están añadiendo nuevos gastos
	ls_factura   = dw_1.getitemstring(1,"factura")
	ls_cliente   = dw_1.getitemstring(1,"cliente")
	//ls_cliente   = f_nombre_cliente(codigo_empresa, "C",ls_cliente)
	if f_nulo_blanco(ls_cliente) then ls_cliente = ""
	if f_nulo_blanco(ls_factura) then ls_factura = ""
	ls_ampliacion = "Nº:" +trim(ls_factura) + "/" + trim(f_nombre_cliente(codigo_empresa, "C",ls_cliente))
	
	if inst_situacion <> 4 then
		//Apunte Riesgo del Banco
		// *******************************************************************+
		// 2. APUNTE AL RIESGO DEL BANCO
		//	*******************************************************************+

		//cta_gene			=	"520810000"//f_cuenta_contagene(codigo_empresa,"28")
		apu.cuenta		=  f_cuenta_riesgo_exportacion_banco(codigo_empresa,em_banco.text) //f_comp_cta_riesgo(cta_gene,em_banco.text)
			
		apu.concepto	= f_concepto_contagene(codigo_empresa,"28")	
		
		if cbx_dar_por_cobrado.checked then
			apu.ampliacion	=	"Cobro Fra:"+ls_factura+" "+f_razon_genter(codigo_empresa,"C",dw_1.getitemstring(1,"cliente"))			
		else						
			apu.ampliacion	= "Canc Antic Fra "+ls_factura+" "+f_razon_genter(codigo_empresa,"C",dw_1.getitemstring(1,"cliente"))
		end if		
		apu.documento 	=  Trim(em_anticipo.text)
						
		apu.ffactura	=  la_fecha_abono
		//apu.origen		=	f_diario_contagene(codigo_empresa,"20")	
		
		IF f_dh_contagene(codigo_empresa,"24")= "H" THEN
			apu.debe		=	importe_cobrado
			apu.haber	=	0
		ELSE
			apu.debe		=	0
			apu.haber	=	importe_cobrado
		END IF	
		if importe_anticipo = 0 then
			messagebox("Error","Abonado = "+string(importe_anticipo,"###,###,0.00")+" €")
		end if
		num_apunte		=	num_apunte +1
		apu.apunte		=	num_apunte	
		apu.orden_apunte	=	num_apunte
		res = f_insert_contaapun(apu) 
		IF res = false THEN
			bien = false
		END IF
			
		if not(cbx_efecto_ya_cobrado.checked) then	
			//Apunte al riesgo del cliente
			apu.cuenta		= f_venclientes_cuenta_ecd(codigo_empresa,dw_1.getitemstring(1,"cliente"))
			IF f_dh_contagene(codigo_empresa,"24")= "H" THEN
				apu.debe		=0
				apu.haber	= importe_cobrado
			ELSE
				apu.debe		= importe_cobrado
				apu.haber	= 0
			END IF								
			num_apunte		=	num_apunte +1
			apu.apunte		=	num_apunte	
			apu.orden_apunte	=	num_apunte
			res = f_insert_contaapun(apu) 
			IF res = false THEN
				bien = false
			END IF				
		end if
		
		//Apunte al banco
		apu.cuenta 		= f_cuenta_carbancos(codigo_empresa,em_banco.text)		
		apu.concepto	= f_concepto_contagene(codigo_empresa,"28")					
		apu.ampliacion	= "Canc Antic Fra "+ls_factura+" "+f_razon_genter(codigo_empresa,"C",dw_1.getitemstring(1,"cliente"))
		apu.origen		= f_diario_contagene(codigo_empresa,"28")
		apu.documento 	= Trim(em_anticipo.text)
		apu.ffactura	= la_fecha_abono

		if cbx_desglosar_gastos_en_cta_banco.checked then		
			if f_dh_contagene(codigo_empresa,"28")= "D" then
				apu.debe		=	importe_cobrado
				apu.haber	=	0			
			else
				apu.debe 	=	0
				apu.haber	=	importe_cobrado			
			end if
		else
			if f_dh_contagene(codigo_empresa,"28")= "D" then
				apu.debe		=	importe_cobrado + datos_salida.total_gastos
				apu.haber	=	0			
			else
				apu.debe 	=	0
				apu.haber	=	importe_cobrado + datos_salida.total_gastos		
			end if				
		end if
		num_apunte		=	num_apunte +1
		apu.apunte		=	num_apunte	
		apu.orden_apunte	=	num_apunte
		res = f_insert_contaapun(apu) 
		IF res = false THEN
			bien = false
		END IF			
		
		if not(cbx_efecto_ya_cobrado.checked) then	
			//Apunte al Cliente
			apu.cuenta 		= f_cuenta_genter(codigo_empresa,"C",dw_1.getitemstring(1,"cliente"))	
			
			if f_dh_contagene(codigo_empresa,"28")= "D" then
				apu.debe		= 0
				apu.haber	= importe_cobrado			
			else
				apu.debe 	= importe_cobrado
				apu.haber	= 0			
			end if			
			
			num_apunte		=	num_apunte +1
			apu.apunte		=	num_apunte	
			apu.orden_apunte	=	num_apunte
			
			if not(cbx_dar_por_cobrado.checked) then	
				res = f_insert_contaapun(apu) 
				IF res = false THEN
					bien = false
				END IF	
			end if
		end if
		
		if cbx_dar_por_cobrado.checked then				
			//Con cobro apunte al Banco
			apu.cuenta 		= f_cuenta_carbancos(codigo_empresa,em_banco.text)
			apu.concepto	= "53"
			apu.ampliacion	= "Cobro fra:"+dw_1.getitemstring(1,"factura")+" "+f_razon_genter(codigo_empresa,"C",dw_1.getitemstring(1,"cliente"))	
			apu.origen		= f_diario_contagene(codigo_empresa,"28")
			apu.documento 	= dw_1.getitemstring(1,"factura")
			apu.ffactura	= la_fecha_abono
			
			apu.debe  = importe_cobrado
			apu.haber = 0

			num_apunte		=	num_apunte +1
			apu.apunte		=	num_apunte	
			apu.orden_apunte	=	num_apunte
			res = f_insert_contaapun(apu) 
			IF res = false THEN
				bien = false
			END IF	
			
			//Con cobro apunte al Cliente 22-05-2017 ya no lo hacemos
//			apu.cuenta 		= f_cuenta_genter(codigo_empresa,"C",dw_1.getitemstring(1,"cliente"))
//			apu.concepto   = "40"
//			apu.ampliacion	= "Cobro fra:"+dw_1.getitemstring(1,"factura")+" "+f_razon_genter(codigo_empresa,"C",dw_1.getitemstring(1,"cliente"))	
//			apu.origen		= f_diario_contagene(codigo_empresa,"28")
//			apu.documento 	= dw_1.getitemstring(1,"factura")
//			apu.ffactura	= la_fecha_abono
//
//			apu.debe  = 0
//			apu.haber = importe_cobrado
//
//			num_apunte		=	num_apunte +1
//			apu.apunte		=	num_apunte	
//			apu.orden_apunte	=	num_apunte
//			res = f_insert_contaapun(apu) 
//			IF res = false THEN
//				bien = false
//			END IF	
			
		end if	
		
	end if
					
	if (con_gastos and cbx_dar_por_cobrado.checked) or (con_gastos and  cbx_desglosar_gastos_en_cta_banco.checked) then //and datos_salida.total_gastos > 0 and not ya_descontado THEN
		
		apu.cuenta 		= f_cuenta_carbancos(codigo_empresa,em_banco.text)
		apu.concepto	= f_concepto_contagene(codigo_empresa,"28")	
		apu.ampliacion	= "GTOS. CANC. ANT "+ em_anticipo.text + " " + ls_ampliacion
		apu.origen		= f_diario_contagene(codigo_empresa,"28")	
		
		if f_dh_contagene(codigo_empresa,"23")= "D" then
			apu.debe		=	datos_salida.total_gastos
			apu.haber	=	0
		else
			apu.debe		=	0
			apu.haber	=	datos_salida.total_gastos
		end if	
		
		num_apunte		=	num_apunte +1
		apu.apunte		=	num_apunte	
		apu.orden_apunte=	num_apunte
		if not(f_insert_contaapun(apu) ) then
			bien = false
		end if
	
	end if	
	
	// APUNTE POR LOS INTERESES
	
	if con_gastos and datos_salida.intereses <> 0 then
						
		apu.cuenta 		=	datos_salida.cta_intereses
		apu.concepto	=  f_concepto_contagene(codigo_empresa,"28")	
		apu.ampliacion	=	"GTOS. CANC. AST "+ EM_ANTICIPO.TEXT + " " + f_nombre_banco_abr(codigo_empresa,el_banco)
		apu.origen		=	f_diario_contagene(codigo_empresa,"28")	
		
		//*REVISAR
		IF f_dh_contagene(codigo_empresa,"25")= "D" THEN
			apu.debe		=	datos_salida.intereses
			apu.haber	=	0
		ELSE
			apu.debe		=	0
			apu.haber	=	datos_salida.intereses
		END IF	
		
		num_apunte		=	num_apunte +1
		apu.apunte		=	num_apunte	
		apu.orden_apunte	=	num_apunte
		res = f_insert_contaapun(apu) 
		IF res = false THEN
			bien = false
		END IF
		// Comprobamos si tiene analitica
		IF f_contaparam_analitica(int(ejer_act),codigo_empresa) THEN
			str_costesapu	coste
			IF f_analitica_contaplan(int(ejer_act),codigo_empresa,apu.cuenta) = "S" THEN
				coste.coste		  = f_coste_contagene(codigo_empresa,"25")
				coste.empresa    = codigo_empresa
				coste.ejercicio  = int(ejer_act)
				coste.origen     = apu.origen
				coste.fapunte    = apu.fapunte
				coste.mes        = apu.mes
				coste.asiento    = apu.asiento
				coste.apunte     = apu.apunte
				coste.debe		  = apu.debe
				coste.haber		  = apu.haber
				coste.concepto   = apu.concepto
				coste.ampliacion = apu.ampliacion
				coste.cuenta     = apu.cuenta
				res = f_insert_costesapu(coste)
				IF res = false THEN
					bien = false
				END IF
			END IF
		END IF
			
	end if
	
	// APUNTES POR LOS GASTOS
	
	if con_gastos and datos_salida.num_gastos > 0 THEN
	
		// para cada uno de los gastos devueltos en pantalla auxiliar		
		fOR i= 1 to datos_salida.num_gastos
			
			// Sólo si hay gasto
			IF datos_salida.gastos[i] > 0 THEN
				apu.cuenta 		=	datos_salida.cuentas[i]
				apu.concepto	=  f_concepto_contagene(codigo_empresa,"28")	
				apu.ampliacion	=	"GTOS. CANC. ANT "+ em_anticipo.text +" "  + f_nombre_banco_abr(codigo_empresa,el_banco)
				apu.origen		=	f_diario_contagene(codigo_empresa,"28")	
				
				IF f_dh_contagene(codigo_empresa,"25")= "D" THEN
					apu.debe		=	datos_salida.gastos[i]
					apu.haber	=	0
				ELSE
					apu.debe		=	0
					apu.haber	=	datos_salida.gastos[i]
				END IF	
				
				num_apunte		=	num_apunte +1
				apu.apunte		=	num_apunte	
				apu.orden_apunte	=	num_apunte
				res = f_insert_contaapun(apu) 
				IF res = false THEN
					bien = false
				END IF
				// Comprobamos si tiene analitica
				IF f_contaparam_analitica(int(ejer_act),codigo_empresa) THEN
					IF f_analitica_contaplan(int(ejer_act),codigo_empresa,apu.cuenta) = "S" THEN
						coste.coste		  = f_coste_contagene(codigo_empresa,"25")
						coste.empresa    = codigo_empresa
						coste.ejercicio  = int(ejer_act)
						coste.origen     = apu.origen
						coste.fapunte    = apu.fapunte
						coste.mes        = apu.mes
						coste.asiento    = apu.asiento
						coste.apunte     = apu.apunte
						coste.debe		  = apu.debe
						coste.haber		  = apu.haber
						coste.concepto   = apu.concepto
						coste.ampliacion = apu.ampliacion
						coste.cuenta     = apu.cuenta
						res = f_insert_costesapu(coste)
						IF res = false THEN
							bien = false
						END IF
					END IF
				END IF
								
			END IF
		
		next
		
	end if 
			
	// *******************************************************************
	// APUNTE POR LA DIFERENCIA DE CAMBIO
	// *******************************************************************
		
	IF nuevo_cambio and diferencia_cambio <> 0 then
		
		
		// Diferencia de cambio positiva
		if diferencia_cambio > 0 then
			apu.cuenta		= 	f_cuenta_contagene(codigo_empresa,"28")
			apu.concepto	=  f_concepto_contagene(codigo_empresa,"28")	
			apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"28")+ " ANTICIPO " + em_anticipo.text + " " + ls_ampliacion
			//apu.origen		=	f_diario_contagene(codigo_empresa,"26")	
			IF f_dh_contagene(codigo_empresa,"28")= "D" THEN
				apu.debe		=	diferencia_cambio
				apu.haber	=	0
			ELSE
				apu.debe		=	0
				apu.haber	=	diferencia_cambio
			END IF	
		end if
		if diferencia_cambio < 0 then
			apu.cuenta  	=  f_cuenta_contagene(codigo_empresa,"28")
			apu.concepto	=  f_concepto_contagene(codigo_empresa,"28")
			apu.ampliacion	=	f_ampliacion_contagene(codigo_empresa,"28")+ " ANTICIPO " + em_anticipo.text + " " + ls_ampliacion
			//apu.origen		=	f_diario_contagene(codigo_empresa,"27")	
			IF f_dh_contagene(codigo_empresa,"28")= "D" THEN
				apu.debe		=	abs(diferencia_cambio)
				apu.haber	=	0
			ELSE
				apu.debe		=	0
				apu.haber	=	abs(diferencia_cambio)
			END IF	
			
		end if
				
	apu.documento 	=  Trim(em_anticipo.text)					
	apu.ffactura	=  la_fecha_abono
	num_apunte		=	num_apunte +1
	apu.apunte		=	num_apunte	
	apu.orden_apunte	=	num_apunte
	res = f_insert_contaapun(apu) 
	IF res = false THEN
		bien = false
	END IF
				
	end if
		
	if apu.apunte > 0 then
		em_asiento.text = string(apu.asiento)
	end if
				
	//********************************************************************
	//  CONTROL DE ERRORES
	// *******************************************************************
	
	if bien then			
		f_activa()
		dw_1.reset()
			
		em_anticipo.text = ""
		em_anticipo.setfocus()
		em_cambio.text = ""
		st_nombre_moneda.text = ""
		em_importe_cancelar.text = ""
		em_cambio.text = ""
		em_divisas_cancelar.text = ""
		f_desactivar_importes()		
		commit;
		
		messagebox("BIEN","Se ha cancelado el anticipo")		
	else				
		rollback;
		messagebox("ATENCIÓN","No se ha grabado el anticipo")		
	END IF	
end if
end event

type em_fcontable from editmask within w_cancelacion_anticipos
integer x = 1582
integer y = 1152
integer width = 338
integer height = 88
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_22 from statictext within w_cancelacion_anticipos
integer x = 1573
integer y = 1068
integer width = 357
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "F. Contable "
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_4 from groupbox within w_cancelacion_anticipos
integer x = 119
integer y = 924
integer width = 1079
integer height = 408
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Cancelación"
end type

type rb_1 from radiobutton within w_cancelacion_anticipos
integer x = 1257
integer y = 1128
integer width = 210
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Sí"
end type

type rb_2 from radiobutton within w_cancelacion_anticipos
integer x = 1257
integer y = 1200
integer width = 206
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "No"
boolean checked = true
end type

type cb_cancelar from commandbutton within w_cancelacion_anticipos
integer x = 1989
integer y = 1180
integer width = 302
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;f_activa()
dw_1.reset()
dw_3.visible = false

em_anticipo.text = ""
em_anticipo.setfocus()
em_importe_cancelar.text = ""
em_cambio.text = ""
em_divisas_cancelar.text = ""
st_nombre_moneda.text = ""
f_desactivar_importes()

rb_1.enabled = true
rb_2.enabled = true
end event

type st_1 from statictext within w_cancelacion_anticipos
integer x = 110
integer y = 116
integer width = 1175
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
string text = "Banco"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_cancelacion_anticipos
integer x = 1289
integer y = 116
integer width = 338
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
string text = "Año Ant."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_boton_anticipo from statictext within w_cancelacion_anticipos
integer x = 1632
integer y = 116
integer width = 370
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
string text = "Anticipo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;
int reg

if cbx_cancelados.checked then
	// anticipos en situación 2 a 4
	reg = dw_3.retrieve(codigo_empresa,em_banco.text,integer(em_anyo.text),2,4)
else
	// anticipos en situación 2 a 3
	reg = dw_3.retrieve(codigo_empresa,em_banco.text,integer(em_anyo.text),2,3)
end if
if reg > 0 then
	dw_3.visible = true
	dw_3.setfocus()
end if


end event

type em_banco from u_em_campo within w_cancelacion_anticipos
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 114
integer y = 192
integer taborder = 10
boolean bringtotop = true
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION BANCOS"
ue_datawindow = "dw_ayuda_carbancos"
ue_filtro     = ""		
isle_campo    = this

end event

event modificado;call super::modificado;st_nombre_banco.text=f_nombre_banco(codigo_empresa,em_banco.text)	
IF Trim(st_nombre_banco.text)="" THEN 
 IF Trim(st_nombre_banco.text)<>"" Then f_activar_campo(em_banco)
 em_banco.text=""
END IF
end event

type dw_1 from datawindow within w_cancelacion_anticipos
integer x = 119
integer y = 284
integer width = 2551
integer height = 624
string dataobject = "dw_cancelacion_anticipos"
boolean livescroll = true
end type

event itemchanged;
if this.update(false) = 1 then
	commit;
else
	rollback;
end if
end event

type st_nombre_moneda from statictext within w_cancelacion_anticipos
integer x = 942
integer y = 1008
integer width = 233
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type em_cambio from editmask within w_cancelacion_anticipos
integer x = 407
integer y = 1112
integer width = 247
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,###.##"
end type

event modified;
f_nueva_divisa()
end event

type st_3 from statictext within w_cancelacion_anticipos
integer x = 128
integer y = 1120
integer width = 274
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cambio :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_divisas_cancelar from editmask within w_cancelacion_anticipos
integer x = 411
integer y = 1004
integer width = 521
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,###.##"
end type

event modified;
f_nueva_divisa()
end event

type em_importe_cancelar from editmask within w_cancelacion_anticipos
integer x = 407
integer y = 1220
integer width = 539
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,###,###.##"
end type

event modified;//f_nuevo_importe()
end event

type st_4 from statictext within w_cancelacion_anticipos
integer x = 151
integer y = 1012
integer width = 251
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Divisas :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_cancelacion_anticipos
integer x = 133
integer y = 1228
integer width = 274
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Importe :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_6 from statictext within w_cancelacion_anticipos
integer x = 1239
integer y = 1044
integer width = 247
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
string text = "Gastos"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_asiento from editmask within w_cancelacion_anticipos
integer x = 2359
integer y = 1200
integer width = 270
integer height = 80
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###"
end type

type st_546 from statictext within w_cancelacion_anticipos
integer x = 2354
integer y = 1124
integer width = 274
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Asiento"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_situacion from statictext within w_cancelacion_anticipos
integer x = 2725
integer y = 1384
integer width = 73
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type cbx_dar_por_cobrado from checkbox within w_cancelacion_anticipos
integer x = 114
integer y = 1336
integer width = 745
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
string text = "Dar el efecto por cobrado"
end type

type cbx_efecto_ya_cobrado from checkbox within w_cancelacion_anticipos
integer x = 114
integer y = 1404
integer width = 855
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
string text = "Efecto ya cobrado"
end type

type cbx_desglosar_gastos_en_cta_banco from checkbox within w_cancelacion_anticipos
integer x = 1225
integer y = 1336
integer width = 896
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
string text = "Desglosar gastos en cta banco"
end type

type dw_3 from datawindow within w_cancelacion_anticipos
boolean visible = false
integer x = 69
integer y = 288
integer width = 2770
integer height = 872
integer taborder = 100
boolean bringtotop = true
string dataobject = "dw_ayuda_carfinan"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;//CHOOSE CASE f_objeto_datawindow(This)
//		
//	case "contador","bancofinan","nom_banc","num_prorroga","nom_cliente"
//		em_anticipo.text = string(dw_3.getitemnumber(row,"contador"))
//		istr_prorroga = dw_3.getitemnumber(row,"num_prorroga")		
//		
//		dw_3.visible = false
//		dw_1.reset()		
//		f_desactiva()
//		
//		setfocus(cb_consultar)
//		cb_consultar.triggerevent("clicked")	
//
//end choose

if row > 0 then
	em_anticipo.text = string(dw_3.getitemnumber(row,"contador"))
	istr_prorroga = dw_3.getitemnumber(row,"num_prorroga")		
	
	dw_3.visible = false
	dw_1.reset()		
	f_desactiva()
	
	setfocus(cb_consultar)
	cb_consultar.triggerevent("clicked")		
end if


end event

type cbx_cancelados from checkbox within w_cancelacion_anticipos
boolean visible = false
integer x = 2007
integer y = 124
integer width = 645
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Mostrar Cancelados"
end type

