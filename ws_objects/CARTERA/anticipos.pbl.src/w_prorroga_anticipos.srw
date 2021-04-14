$PBExportHeader$w_prorroga_anticipos.srw
$PBExportComments$Prórroga de anticipos
forward
global type w_prorroga_anticipos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_prorroga_anticipos
end type
type cb_consultar from commandbutton within w_prorroga_anticipos
end type
type em_anyo from editmask within w_prorroga_anticipos
end type
type st_8 from statictext within w_prorroga_anticipos
end type
type em_vencimiento from u_em_campo within w_prorroga_anticipos
end type
type em_plazo_real from u_em_campo within w_prorroga_anticipos
end type
type st_9 from statictext within w_prorroga_anticipos
end type
type em_anticipo from u_em_campo within w_prorroga_anticipos
end type
type st_nombre_banco from statictext within w_prorroga_anticipos
end type
type tab_datos from tab within w_prorroga_anticipos
end type
type pagina1 from userobject within tab_datos
end type
type dw_1 from datawindow within pagina1
end type
type pagina1 from userobject within tab_datos
dw_1 dw_1
end type
type pagina2 from userobject within tab_datos
end type
type dw_2 from datawindow within pagina2
end type
type pagina2 from userobject within tab_datos
dw_2 dw_2
end type
type pagina3 from userobject within tab_datos
end type
type dw_4 from datawindow within pagina3
end type
type pagina3 from userobject within tab_datos
dw_4 dw_4
end type
type tab_datos from tab within w_prorroga_anticipos
pagina1 pagina1
pagina2 pagina2
pagina3 pagina3
end type
type dw_3 from datawindow within w_prorroga_anticipos
end type
type cb_procesar from commandbutton within w_prorroga_anticipos
end type
type em_fcontable from editmask within w_prorroga_anticipos
end type
type st_22 from statictext within w_prorroga_anticipos
end type
type gb_22 from groupbox within w_prorroga_anticipos
end type
type gb_3 from groupbox within w_prorroga_anticipos
end type
type gb_2 from groupbox within w_prorroga_anticipos
end type
type gb_1 from groupbox within w_prorroga_anticipos
end type
type rb_1 from radiobutton within w_prorroga_anticipos
end type
type rb_2 from radiobutton within w_prorroga_anticipos
end type
type cb_cancelar from commandbutton within w_prorroga_anticipos
end type
type st_1 from statictext within w_prorroga_anticipos
end type
type st_2 from statictext within w_prorroga_anticipos
end type
type st_boton_anticipo from statictext within w_prorroga_anticipos
end type
type em_banco from u_em_campo within w_prorroga_anticipos
end type
type em_asiento from editmask within w_prorroga_anticipos
end type
type st_33 from statictext within w_prorroga_anticipos
end type
end forward

global type w_prorroga_anticipos from w_int_con_empresa
integer width = 2907
integer height = 1596
pb_1 pb_1
cb_consultar cb_consultar
em_anyo em_anyo
st_8 st_8
em_vencimiento em_vencimiento
em_plazo_real em_plazo_real
st_9 st_9
em_anticipo em_anticipo
st_nombre_banco st_nombre_banco
tab_datos tab_datos
dw_3 dw_3
cb_procesar cb_procesar
em_fcontable em_fcontable
st_22 st_22
gb_22 gb_22
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
rb_1 rb_1
rb_2 rb_2
cb_cancelar cb_cancelar
st_1 st_1
st_2 st_2
st_boton_anticipo st_boton_anticipo
em_banco em_banco
em_asiento em_asiento
st_33 st_33
end type
global w_prorroga_anticipos w_prorroga_anticipos

type variables
string filtro

editmask isle_campo 
integer var_ejercicio
string istr_factura

int istr_prorroga
int inst_situacion

end variables

forward prototypes
public subroutine f_desactiva ()
public subroutine f_activa ()
public subroutine f_cambio ()
public subroutine f_cambia_valor ()
public subroutine f_calcula_vencim (integer arg_caso, string arg_valor)
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

//tab_datos.pagina3.dw_4.enabled = true
end subroutine

public subroutine f_cambio ();//
//dec divisas,importe,cambio
//
//tab_datos.pagina3.dw_4.accepttext()
//
//importe =tab_datos.pagina3.dw_4.getitemnumber(1,"importe_abono")
//divisas =tab_datos.pagina3.dw_4.getitemnumber(1,"divisa_abono")
//cambio = importe / divisas
//
//tab_datos.pagina3.dw_4.setitem(1,"cambio_abono",cambio)
end subroutine

public subroutine f_cambia_valor ();//dec divisas,importe,cambio
//
//tab_datos.pagina3.dw_4.accepttext()
//
//
//divisas =tab_datos.pagina3.dw_4.getitemnumber(1,"divisa_abono")
//cambio = tab_datos.pagina3.dw_4.getitemnumber(1,"cambio_abono")
//
//importe = divisas * cambio
//tab_datos.pagina3.dw_4.setitem(1,"importe_abono",long(importe))
//
//tab_datos.pagina3.dw_4.accepttext()
end subroutine

public subroutine f_calcula_vencim (integer arg_caso, string arg_valor);
date dia_venci
string nom_dia
date f_valor
int el_plazo

choose case arg_caso
	// evento itemchaged del campo "f_valor" de la dw pagina3
	case 1
		f_valor = date(arg_valor)
		el_plazo	= tab_datos.pagina3.dw_4.getitemnumber(1,"pro_plazo")
		
	// evento itemchaged del campo "pro_plazo" de la dw pagina3	
	case 2
		el_plazo = 	integer(arg_valor)
		f_valor = date(tab_datos.pagina3.dw_4.getitemdatetime(1,"pro_fvalor"))
		
	// evento clicked botón procesar
//	case 3
//		f_valor = date(tab_datos.pagina2.dw_2.getitemdatetime(1,"fvalor"))
//		el_plazo	= tab_datos.pagina2.dw_2.getitemnumber(1,"plazo")
		
end choose



// El día de vencimiento es la fecha de valor + los días de plazo

if el_plazo > 0 then
	dia_venci = relativedate(f_valor, el_plazo)
else
	dia_venci = f_valor
end if

tab_datos.pagina3.dw_4.setitem(1,"pro_fvencimiento",dia_venci)

nom_dia = upper(dayname(dia_venci))



// El plazo real son los días de plazo, exceptuando los casos en que 
// el día de vencimiento es sábado o domingo
int plazo_real
choose case nom_dia
	case "SATURDAY"
		plazo_real = el_plazo - 1
		
						
	CASE "SUNDAY"
		plazo_real = el_plazo + 1
		
		
	CASE ELSE
		plazo_real = el_plazo 
		
		
end choose

if plazo_real <= 0 then
	tab_datos.pagina3.dw_4.setitem(1,"pro_plazo_real",0)
else
	tab_datos.pagina3.dw_4.setitem(1,"pro_plazo_real",plazo_real)		
end if
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Prórroga de Anticipos"
This.title=istr_parametros.s_titulo_ventana



tab_datos.pagina1.dw_1.settransobject(sqlca)
tab_datos.pagina2.dw_2.settransobject(sqlca)
tab_datos.pagina3.dw_4.settransobject(sqlca)
dw_3.settransobject(sqlca)

em_anyo.text = string(year(today()))


dw_3.visible = false

// En istr_prorroga tenemos la prorroga del anticipo seleccionado
// Inicialmente -1
istr_prorroga = -1

em_fcontable.text = string(today())

rb_1.checked = true
rb_2.checked = false

tab_datos.selecttab(3)

end event

on w_prorroga_anticipos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.cb_consultar=create cb_consultar
this.em_anyo=create em_anyo
this.st_8=create st_8
this.em_vencimiento=create em_vencimiento
this.em_plazo_real=create em_plazo_real
this.st_9=create st_9
this.em_anticipo=create em_anticipo
this.st_nombre_banco=create st_nombre_banco
this.tab_datos=create tab_datos
this.dw_3=create dw_3
this.cb_procesar=create cb_procesar
this.em_fcontable=create em_fcontable
this.st_22=create st_22
this.gb_22=create gb_22
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cb_cancelar=create cb_cancelar
this.st_1=create st_1
this.st_2=create st_2
this.st_boton_anticipo=create st_boton_anticipo
this.em_banco=create em_banco
this.em_asiento=create em_asiento
this.st_33=create st_33
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.cb_consultar
this.Control[iCurrent+3]=this.em_anyo
this.Control[iCurrent+4]=this.st_8
this.Control[iCurrent+5]=this.em_vencimiento
this.Control[iCurrent+6]=this.em_plazo_real
this.Control[iCurrent+7]=this.st_9
this.Control[iCurrent+8]=this.em_anticipo
this.Control[iCurrent+9]=this.st_nombre_banco
this.Control[iCurrent+10]=this.tab_datos
this.Control[iCurrent+11]=this.dw_3
this.Control[iCurrent+12]=this.cb_procesar
this.Control[iCurrent+13]=this.em_fcontable
this.Control[iCurrent+14]=this.st_22
this.Control[iCurrent+15]=this.gb_22
this.Control[iCurrent+16]=this.gb_3
this.Control[iCurrent+17]=this.gb_2
this.Control[iCurrent+18]=this.gb_1
this.Control[iCurrent+19]=this.rb_1
this.Control[iCurrent+20]=this.rb_2
this.Control[iCurrent+21]=this.cb_cancelar
this.Control[iCurrent+22]=this.st_1
this.Control[iCurrent+23]=this.st_2
this.Control[iCurrent+24]=this.st_boton_anticipo
this.Control[iCurrent+25]=this.em_banco
this.Control[iCurrent+26]=this.em_asiento
this.Control[iCurrent+27]=this.st_33
end on

on w_prorroga_anticipos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.cb_consultar)
destroy(this.em_anyo)
destroy(this.st_8)
destroy(this.em_vencimiento)
destroy(this.em_plazo_real)
destroy(this.st_9)
destroy(this.em_anticipo)
destroy(this.st_nombre_banco)
destroy(this.tab_datos)
destroy(this.dw_3)
destroy(this.cb_procesar)
destroy(this.em_fcontable)
destroy(this.st_22)
destroy(this.gb_22)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cb_cancelar)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_boton_anticipo)
destroy(this.em_banco)
destroy(this.em_asiento)
destroy(this.st_33)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_prorroga_anticipos
integer x = 2112
integer y = 20
integer width = 485
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_prorroga_anticipos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_prorroga_anticipos
integer x = 9
integer y = 12
integer width = 2427
integer height = 96
end type

type pb_1 from upb_salir within w_prorroga_anticipos
integer x = 2688
integer y = 16
integer width = 142
integer height = 116
integer taborder = 0
end type

type cb_consultar from commandbutton within w_prorroga_anticipos
integer x = 2400
integer y = 172
integer width = 347
integer height = 104
integer taborder = 40
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

// Comprobamos la situación del anticipo 
// La situación ha de ser 2 ó 3 (abonado y no cancelado) 
// 2 abonado sin gastos 
// 3 abonado con gastos 

int la_situacion,el_anyo,el_anticipo
el_anyo = integer(em_anyo.text)
el_anticipo = integer(em_anticipo.text)

select carfinan.situacion,carfinan.prorroga_activa 
into :la_situacion,:istr_prorroga
from carfinan
where (carfinan.empresa = :codigo_empresa)	and
		(carfinan.anyo = :el_anyo)					and
		(carfinan.bancofinan = :em_banco.text)	and
		(carfinan.contador = :el_anticipo)		and
		(carfinan.num_prorroga = carfinan.prorroga_activa);

// variable instancia para la situación
inst_situacion = la_situacion



if la_situacion <> 2 and la_situacion <> 3 then 
	//situación no válida
	em_anticipo.text = ""
	return
end if





int registros1,registros2

// **********************************************************************
//  MOSTRAMOS LOS DATOS DE LOS ANTICIPOS
// **********************************************************************


// presentamos los efectos del anticipo en la pestaña 1
tab_datos.pagina1.dw_1.retrieve(codigo_empresa,integer(em_anyo.text),em_banco.text,integer(em_anticipo.text))


// Presentamos los datos generales y de abono(prórroga actual)
// En la pestaña 2
registros2 = tab_datos.pagina2.dw_2.retrieve(codigo_empresa,em_banco.text,integer(em_anticipo.text), istr_prorroga,el_anyo)

// En la pestaña 3
registros2 = tab_datos.pagina3.dw_4.retrieve(codigo_empresa,em_banco.text,integer(em_anticipo.text), istr_prorroga,el_anyo)


// Páginas no activas
tab_datos.pagina1.dw_1.enabled = false
tab_datos.pagina2.dw_2.enabled = false


// Activa la pagina 3
tab_datos.selecttab(3)
tab_datos.pagina3.dw_4.setfocus()
tab_datos.pagina3.dw_4.setcolumn("pro_fvencimiento")	

// Datos por defecto

tab_datos.pagina3.dw_4.setitem(1,"pro_fvalor",tab_datos.pagina3.dw_4.getitemdatetime(1,"vencimiento"))
tab_datos.pagina3.dw_4.setitem(1,"pro_fvencimiento",tab_datos.pagina3.dw_4.getitemdatetime(1,"vencimiento"))

em_asiento.text = ""
end event

type em_anyo from editmask within w_prorroga_anticipos
integer x = 1330
integer y = 188
integer width = 219
integer height = 88
integer taborder = 20
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

type st_8 from statictext within w_prorroga_anticipos
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

type em_vencimiento from u_em_campo within w_prorroga_anticipos
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

type em_plazo_real from u_em_campo within w_prorroga_anticipos
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

type st_9 from statictext within w_prorroga_anticipos
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

type em_anticipo from u_em_campo within w_prorroga_anticipos
integer x = 1696
integer y = 192
integer width = 261
integer taborder = 30
long backcolor = 16777215
alignment alignment = right!
end type

event modified;call super::modified;tab_datos.pagina1.dw_1.reset()
tab_datos.pagina2.dw_2.reset()
tab_datos.pagina3.dw_4.reset()


end event

type st_nombre_banco from statictext within w_prorroga_anticipos
integer x = 366
integer y = 200
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

type tab_datos from tab within w_prorroga_anticipos
event create ( )
event destroy ( )
integer x = 91
integer y = 300
integer width = 2651
integer height = 868
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean raggedright = true
alignment alignment = center!
integer selectedtab = 1
pagina1 pagina1
pagina2 pagina2
pagina3 pagina3
end type

on tab_datos.create
this.pagina1=create pagina1
this.pagina2=create pagina2
this.pagina3=create pagina3
this.Control[]={this.pagina1,&
this.pagina2,&
this.pagina3}
end on

on tab_datos.destroy
destroy(this.pagina1)
destroy(this.pagina2)
destroy(this.pagina3)
end on

type pagina1 from userobject within tab_datos
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2615
integer height = 748
long backcolor = 12632256
string text = "Efectos"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on pagina1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on pagina1.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within pagina1
integer x = 14
integer y = 4
integer width = 2574
integer height = 556
integer taborder = 81
boolean bringtotop = true
string dataobject = "dw_efectos_financiados"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type pagina2 from userobject within tab_datos
integer x = 18
integer y = 104
integer width = 2615
integer height = 748
long backcolor = 12632256
string text = "Datos Generales"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on pagina2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on pagina2.destroy
destroy(this.dw_2)
end on

type dw_2 from datawindow within pagina2
integer x = 27
integer y = 40
integer width = 2578
integer height = 624
integer taborder = 82
boolean bringtotop = true
string dataobject = "dw_prorroga_anticipos2"
boolean border = false
boolean livescroll = true
end type

event rbuttondown;str_parametros astr_parametros


CHOOSE CASE f_objeto_datawindow(This)
		
	
	case "banco_abono"
		
		string banc
		astr_parametros.s_criterio_busqueda = ""
		astr_parametros.s_nom_datawindow = "dw_ayuda_carbancos"
		astr_parametros.s_filtro = ""
		astr_parametros.s_titulo_ayuda = "VENTANA AYUDA BANCOS"
		astr_parametros.b_empresa	=	true
		
		openwithparm(w_busquedas,astr_parametros)
		
		BANC = message.stringparm
		
		tab_datos.pagina3.dw_4.setitem(1,"banco_abono",banc)
		tab_datos.pagina3.dw_4.accepttext()
		
		
		
	
	case "moneda_abono"
		
		string mone
		
		
		astr_parametros.s_criterio_busqueda = ""
		astr_parametros.s_nom_datawindow = "dw_ayuda_divisas"
		astr_parametros.s_filtro = ""
		astr_parametros.s_titulo_ayuda = "Ventana ayuda divisas"
		
		
		openwithparm(w_busquedas,astr_parametros)
		
		mone = message.stringparm
		
		tab_datos.pagina3.dw_4.setitem(1,"moneda_abono",mone)
		
	
		
		
		
	
		
end choose
end event

event itemchanged;
dec divisas,importe,cambio

CHOOSE CASE dwo.name
		
	case "cambio_abono"
		
		cambio = dec(data)
		
		divisas = tab_datos.pagina3.dw_4.getitemnumber(1,"divisa_abono")
		
		importe = divisas * cambio
		tab_datos.pagina3.dw_4.setitem(1,"importe_abono",long(importe))
		
				
	case "importe_abono"
		
		importe = dec(data)
		divisas = tab_datos.pagina3.dw_4.getitemnumber(1,"divisa_abono")
		cambio = importe / divisas

		tab_datos.pagina3.dw_4.setitem(1,"cambio_abono",cambio)
		
	case "divisa_abono"
		
		divisas = dec(data)
		cambio = tab_datos.pagina3.dw_4.getitemnumber(1,"cambio_abono")
		
		importe = divisas * cambio
		tab_datos.pagina3.dw_4.setitem(1,"importe_abono",long(importe))
				
end choose
end event

type pagina3 from userobject within tab_datos
integer x = 18
integer y = 104
integer width = 2615
integer height = 748
long backcolor = 12632256
string text = "Datos Prórroga"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_4 dw_4
end type

on pagina3.create
this.dw_4=create dw_4
this.Control[]={this.dw_4}
end on

on pagina3.destroy
destroy(this.dw_4)
end on

type dw_4 from datawindow within pagina3
integer x = 146
integer y = 88
integer width = 2313
integer height = 576
integer taborder = 83
boolean bringtotop = true
string dataobject = "dw_prorroga_anticipos"
boolean border = false
boolean livescroll = true
end type

event itemchanged;string fecha,nom_dia
long dias,plazo_real
date f1,f2


CHOOSE CASE dwo.name
		
	case "pro_plazo"
		f_calcula_vencim(2,data)
		
	case "pro_fvalor"		
		
		fecha = mid(data,9,2)+"/"+mid(data,6,2)+ "/" +mid(data,1,4)		
		f_calcula_vencim(1,fecha)

				
				
	case "pro_fvencimiento"
		// Obtenemos del argumento data el valor del vencimiento
		fecha = mid(data,9,2)+"/"+mid(data,6,2)+ "/" +mid(data,1,4)		
		
		f1 = date(tab_datos.pagina3.dw_4.getitemdatetime(1,"pro_fvalor"))
		f2 = date(fecha)
		dias = daysafter(f1,f2)	
		if dias < 0 then
			messagebox("Atención"," Fecha de vencimiento MENOR que fecha de valor ")
			tab_datos.pagina3.dw_4.setitem(1,"pro_plazo",0)
			tab_datos.pagina3.dw_4.setitem(1,"pro_fvencimiento",f1)
			tab_datos.pagina3.dw_4.setitem(1,"pro_plazo_real",0)
		else
			tab_datos.pagina3.dw_4.setitem(1,"pro_plazo",dias)
			nom_dia = upper(dayname(f2))
			// El plazo real son los días de plazo, exceptuando los casos en que 
			// el día de vencimiento es sábado o domingo
			
			choose case nom_dia
				case "SATURDAY"
					plazo_real = dias - 1								
				CASE "SUNDAY"
					plazo_real = dias + 1				
				CASE ELSE
					plazo_real = dias 				
			end choose
					
			tab_datos.pagina3.dw_4.setitem(1,"pro_plazo_real",plazo_real)
		end if
				
				
end choose


end event

type dw_3 from datawindow within w_prorroga_anticipos
boolean visible = false
integer x = 585
integer y = 280
integer width = 2112
integer height = 616
boolean bringtotop = true
string dataobject = "dw_ayuda_prorroga_carfinan"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;CHOOSE CASE f_objeto_datawindow(This)
		
	case "contador","num_prorroga","factura","nom_serie","nom_cliente","divisasfinan","nom_moneda"
		em_anticipo.text = string(dw_3.getitemnumber(row,"contador"))
		istr_prorroga = dw_3.getitemnumber(row,"prorroga_activa")		
		
		dw_3.visible = false
		tab_datos.pagina1.dw_1.reset()
		tab_datos.pagina2.dw_2.reset()
		tab_datos.pagina3.dw_4.reset()
		
		f_desactiva()
		
		setfocus(cb_consultar)
		cb_consultar.triggerevent("clicked")	
		
end choose


end event

type cb_procesar from commandbutton within w_prorroga_anticipos
integer x = 1390
integer y = 1236
integer width = 343
integer height = 108
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
end type

event clicked;String ff

//***********************************************************************
// Control de datos
//***********************************************************************


// Banco y anticipo
if em_anticipo.text = "" or em_banco.text = "" then
	f_mensaje("Atención","Debe introducir el Banco y el Nº de Anticipo")
	em_anticipo.setfocus()
	return
end if

// datos del anticipo
if tab_datos.pagina1.dw_1.rowcount()= 0 or &
	tab_datos.pagina2.dw_2.rowcount() = 0 then
	
	f_mensaje("Atención","No hay datos sobre el anticipo")
	return
end if


// fecha contable
if not isdate(em_fcontable.text) then 	
	f_mensaje("Atención","Introduzca la fecha para el asiento contable")
	return
end if



// **********************************************************************
// EJERCICIO A PARTIR DE LA FECHA DEL APUNTE
// **********************************************************************

integer ejer_act,error_num

ejer_act = year(date(em_fcontable.text))


//*************************************************************************
// GRABAR LOS DATOS DE ABONO
//*************************************************************************

BOOLEAN correcto,con_gastos
int opci

opci = messagebox("Atención", "¿ Desea PRORROGAR el anticipo ?",question!,yesno!,1)

if opci = 1 then
	
	//********************************************************************
	// Control de los datos de abono
	//********************************************************************
		

	datetime pro_fvalor
	long pro_plazo
	
	// Control fecha valor prórroga	
	pro_fvalor = tab_datos.pagina3.dw_4.getitemdatetime(1,"pro_fvalor")
	if not isdate(string(date(pro_fvalor)))  then
		f_mensaje("Atención","Debe rellenar el campo FECHA DE VALOR")
		tab_datos.selecttab(3)
		tab_datos.pagina3.dw_4.setfocus()
		tab_datos.pagina3.dw_4.setcolumn("pro_fvalor")		
		return
	end if
	
	pro_plazo = tab_datos.pagina3.dw_4.getitemnumber(1,"pro_plazo")
	if pro_plazo = 0  then
		f_mensaje("Atención","Debe rellenar el campo PLAZO")
		tab_datos.selecttab(3)
		tab_datos.pagina3.dw_4.setfocus()
		tab_datos.pagina3.dw_4.setcolumn("pro_plazo")		
		return
	end if

	
	// *********************************************************************
	// 	VARIABLE con_gastos. GASTOS AL ABONAR O NO 
	// *********************************************************************
	
	IF rb_1.checked then 
		con_gastos = true
	else
		con_gastos = false
	end if
	
	
	
	// *******************************************************************
	// GRABAR DATOS DE PRÓRROGA
	// *******************************************************************

	string banc
	int any_ant,anticip
	str_carfinan anticipo
	
	banc					= em_banco.text
	any_ant  			= integer(em_anyo.text)
	anticip			 	= integer(em_anticipo.text)

	
	
	// Incrementamos el nº de prórroga
	istr_prorroga = istr_prorroga +1
	
	
	// Datos anticipo actual
	select 	empresa,							bancofinan,
				contador,						num_prorroga,
				refbanco,						ordencarga,
				fvalor,							moneda,
				divisasfinan,					plazo,
				vencimiento,					plazoreal,
				cliente,							situacion,
				prorroga_activa,				banco_abono,
				facabono,						divisa_abono,
				importe_abono,					cambio_abono,
				anyo,								moneda_abono,
				anyo_fac,						serie_fac,
				factura,							fpago,
				fanticipo,						fecha_abono,
				pdte_liquidar
		into  :anticipo.empresa,			:anticipo.bancofinan,
				:anticipo.contador,			:anticipo.num_prorroga,
				:anticipo.refbanco,			:anticipo.ordencarga,
				:anticipo.fvalor,				:anticipo.moneda,
				:anticipo.divisasfinan,		:anticipo.plazo,
				:anticipo.vencimiento,		:anticipo.plazoreal,
				:anticipo.cliente,			:anticipo.situacion,
				:anticipo.prorroga_activa,	:anticipo.banco_abono,
				:anticipo.facabono,			:anticipo.divisa_abono,
				:anticipo.importe_abono,	:anticipo.cambio_abono,
				:anticipo.anyo,				:anticipo.moneda_abono,
				:anticipo.anyo_fac,			:anticipo.serie_fac,
				:anticipo.factura,			:anticipo.fpago,
				:anticipo.fanticipo,			:anticipo.fecha_abono,
				:anticipo.pdte_liquidar
				
		from 	carfinan 
		where (carfinan.empresa = :codigo_empresa) and
				(carfinan.anyo = :any_ant)	and
				(carfinan.bancofinan = :banc)	and
				(carfinan.contador = :anticip);
	

		// Datos nuevo anticipo
		anticipo.num_prorroga	=	istr_prorroga
		anticipo.prorroga_activa=	istr_prorroga 
		anticipo.fecha_abono 	=	tab_datos.pagina3.dw_4.getitemdatetime(1,"pro_fvalor")
		anticipo.plazo 			=	tab_datos.pagina3.dw_4.getitemnumber(1,"pro_plazo")
		anticipo.vencimiento 	=	tab_datos.pagina3.dw_4.getitemdatetime(1,"pro_fvencimiento")
		anticipo.plazoreal		=	tab_datos.pagina3.dw_4.getitemnumber(1,"pro_plazo_real")
		
		
		
		// Actualizar datos prórrogas anteriores
		// Nueva prórroga activa y situación cancelado
		update carfinan
		set prorroga_activa = :istr_prorroga,situacion = 5
		where (carfinan.empresa = :codigo_empresa) and
				(carfinan.anyo = :any_ant)	and
				(carfinan.bancofinan = :banc)	and
				(carfinan.contador = :anticip);
	
	
	if not f_insert_carfinan(anticipo) then error_num = 1

	
	

	
	
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
		// Pasamos el total del anticipo obtenida en la ventana
		datos.importe		= tab_datos.pagina3.dw_4.getitemnumber(1,"importe_abono")
		// El tipo de documento es el anticipo (CÓDIGO 13)
		datos.tipodoc = "13"
		// Sólo anticipos de extranjero
		datos.naci_extra = "E"
		// Es una liquidación
		datos.abono_liq_teo = "L"
		// Situación
		datos.situacion = inst_situacion
		// es prorroga
		datos.es_prorroga = "S"
		
		datos.vencimiento = tab_datos.pagina3.dw_4.getitemdatetime(1,"pro_fvencimiento")
		datos.fecha_abono = tab_datos.pagina3.dw_4.getitemdatetime(1,"pro_fvalor")
		
		// Pantalla para obtener los gastos			
		openwithparm(w_input_gastos_anticipos,datos)
		
		datos_salida = Message.powerobjectparm 
		
		IF datos_salida.correcto = false THEN 
			messagebox("Atención","No se ha anticipado el anticipo")
			rollback;
			RETURN
		END IF																
	end if

	setpointer(hourglass!)

	// ******************************************************************
	// CAMBIAR LA SITUACIÓN DEL ANTICIPO
	// ********************************************************************
			
	// Situación 3 abonada con gastos
	// Situación 2 abonada sin gastos
	
	int situ,anticipo_int,anyo_int
	
	anticipo_int = integer(em_anticipo.text)
	anyo_int = integer(em_anyo.text)
	
	
	if con_gastos then
		situ = 3
	else
		situ = 2
	end if
		
	
	UPDATE carfinan
	set situacion = :situ
	where (empresa = :codigo_empresa)		and
			(bancofinan = :em_banco.text)		and
			(contador = :anticipo_int)			and
			(num_prorroga = :istr_prorroga)	and
			(anyo = :anyo_int);
	

	// *********************************************************************
	// ASIENTO CONTABLE
	// *********************************************************************


	str_contaapun apu  
	
	dec{2} el_saldo,total_saldo
	string la_cuenta,el_banco
	int  num_apunte,i
	boolean res 		
	datetime f_contable 
	
	f_contable = datetime(date(em_fcontable.text))
	el_banco 	= Trim(em_banco.text)
	
	
	// Datos comunes a todos los apuntes
	
	num_apunte		=	0	// inicialmente 0, se incrementa con cada apunte
	apu.ejercicio 	=	ejer_act
	apu.empresa 	=	codigo_empresa
	apu.origen		=	"2"	
	apu.asiento		=	f_ultimo_asiento(ejer_act,codigo_empresa,month(date(f_contable)),apu.origen)
	apu.fapunte		=	f_contable	
	
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
	// APUNTE AL BANCO
	// ******************************************************************
	
	
	//*******************************************************
	// 1. Apunte al banco por los gastos
	//********************************************************

	
	
	IF con_gastos and datos_salida.total_gastos > 0 THEN
		
		apu.cuenta 		=	f_cuenta_carbancos(codigo_empresa,em_banco.text)
		apu.concepto	=	f_concepto_contagene(codigo_empresa,"40")	
		apu.ampliacion	= f_ampliacion_contagene(codigo_empresa,"40")+ " "+ em_anticipo.text + " " + &
							f_razon_genter(codigo_empresa,"C",tab_datos.pagina2.dw_2.getitemstring(1,"cliente"))
		
		apu.origen		=	f_diario_contagene(codigo_empresa,"40")	
		apu.documento 	=  tab_datos.pagina1.dw_1.getitemstring(1,"factura")		
		
		apu.ffactura	= apu.fapunte
		
		
		IF f_dh_contagene(codigo_empresa,"40")= "D" THEN
			apu.debe		=	round(datos_salida.total_gastos, 2)
			apu.haber	=	0
		ELSE
			apu.debe		=	0
			apu.haber	=	round(datos_salida.total_gastos, 2)
		END IF	
		
		num_apunte		=	num_apunte +1
		apu.apunte		=	num_apunte	
		apu.orden_apunte=	num_apunte
		



		
		res = f_insert_contaapun(apu) 
		IF res = false THEN
			error_num = 20
		END IF
	
	END IF
	

	
	
	
	// *******************************************************************+
	// 2. CANCELACIÓN RIESGO DEL BANCO PRÓRROGA ANTERIOR
	//	*******************************************************************+
					
	// obtenemos la cuenta de riesgo componiendola
	// con la que se obtiene de la tabla contagene
	// y el código del banco
	
	
	string cta_gene
	cta_gene			=	f_cuenta_contagene(codigo_empresa,"41")
	apu.cuenta		=  f_cuenta_riesgo_exportacion_banco(codigo_empresa,em_banco.text)//f_comp_cta_riesgo(cta_gene,em_banco.text)
		
	apu.concepto	=	f_concepto_contagene(codigo_empresa,"41")	
	apu.ampliacion	= f_ampliacion_contagene(codigo_empresa,"41")+ " " + em_anticipo.text +" " +& 
						string(date(tab_datos.pagina3.dw_4.getitemdatetime(1,"vencimiento")))+" "+&
						f_razon_genter(codigo_empresa,"C",tab_datos.pagina2.dw_2.getitemstring(1,"cliente"))
	apu.documento 	= anticipo.factura
	
	
					
	apu.ffactura	=  tab_datos.pagina1.dw_1.getitemdatetime(1,"ffactura")
	apu.origen		=	f_diario_contagene(codigo_empresa,"41")	
	
	IF f_dh_contagene(codigo_empresa,"41")= "D" THEN
		apu.debe		=	round(anticipo.importe_abono, 2)
		apu.haber	=	0
	ELSE
		apu.debe		=	0
		apu.haber	=	round(anticipo.importe_abono, 2)
	END IF	
	
	num_apunte		=	num_apunte +1
	apu.apunte		=	num_apunte	
	apu.orden_apunte	=	num_apunte
		
	res = f_insert_contaapun(apu) 
	IF res = false THEN
		error_num = 3
	END IF

	
	
	
	
	// *******************************************************************+
	// 3. NUEVO RIESGO DEL BANCO
	//	*******************************************************************+
					

	
		cta_gene			=	f_cuenta_contagene(codigo_empresa,"41")
		apu.cuenta		=  f_cuenta_riesgo_exportacion_banco(codigo_empresa,em_banco.text)//f_comp_cta_riesgo(cta_gene,em_banco.text)
			
		apu.concepto	=	f_concepto_contagene(codigo_empresa,"41")	
		apu.ampliacion	= f_ampliacion_contagene(codigo_empresa,"41")+ " "+ em_anticipo.text + " " + &
							string(date(tab_datos.pagina3.dw_4.getitemdatetime(1,"pro_fvencimiento")))+" " +&
							f_razon_genter(codigo_empresa,"C",tab_datos.pagina2.dw_2.getitemstring(1,"cliente"))
		
		apu.documento 	= tab_datos.pagina1.dw_1.getitemstring(1,"factura")
						
		apu.ffactura	= tab_datos.pagina1.dw_1.getitemdatetime(1,"fFACTURA")
		apu.origen		=	f_diario_contagene(codigo_empresa,"41")	
		
		IF f_dh_contagene(codigo_empresa,"41")= "D" THEN
			apu.debe		=	round(anticipo.importe_abono, 2)
			apu.haber	=	0
		ELSE
			apu.debe		=	0
			apu.haber	=	round(anticipo.importe_abono, 2)
		END IF	
		
		num_apunte		=	num_apunte +1
		apu.apunte		=	num_apunte	
		apu.orden_apunte	=	num_apunte
		
	
		
		res = f_insert_contaapun(apu) 
		IF res = false THEN
			error_num = 30
		END IF
		
	
	
	// ******************************************************************
	// 4. APUNTE POR LOS GASTOS
	// ******************************************************************
	
	
	// APUNTE POR LOS INTERESES
	
	if con_gastos and datos_salida.intereses > 0 then
				
		
		apu.cuenta 		=	datos_salida.cta_intereses
		apu.concepto	=	f_concepto_contagene(codigo_empresa,"40")	
		apu.ampliacion	= f_ampliacion_contagene(codigo_empresa,"40")+ " "+ em_anticipo.text + " " + &
							f_razon_genter(codigo_empresa,"C",tab_datos.pagina2.dw_2.getitemstring(1,"cliente"))
		apu.origen		=	f_diario_contagene(codigo_empresa,"40")	
		apu.documento 	= tab_datos.pagina1.dw_1.getitemstring(1,"factura")
		
		IF f_dh_contagene(codigo_empresa,"40")= "D" THEN
			apu.debe		=	round(datos_salida.intereses, 2)
			apu.haber	=	0
		ELSE
			apu.debe		=	0
			apu.haber	=	round(datos_salida.intereses, 2)
		END IF	
		
		num_apunte		=	num_apunte +1
		apu.apunte		=	num_apunte	
		apu.orden_apunte	=	num_apunte
			
		res = f_insert_contaapun(apu) 
		IF res = false THEN
			error_num = 40
		END IF
		// Comprobamos si tiene analitica
		IF f_contaparam_analitica(int(ejer_act),codigo_empresa) THEN
			str_costesapu	coste
			IF f_analitica_contaplan(int(ejer_act),codigo_empresa,apu.cuenta) = "S" THEN
				coste.coste		  = f_coste_contagene(codigo_empresa,"40")
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
					error_num = 50
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
				apu.concepto	=	f_concepto_contagene(codigo_empresa,"40")	
				apu.ampliacion	= f_ampliacion_contagene(codigo_empresa,"40")+ " "+ em_anticipo.text + " " + &
							f_razon_genter(codigo_empresa,"C",tab_datos.pagina2.dw_2.getitemstring(1,"cliente"))
				apu.origen		=	f_diario_contagene(codigo_empresa,"40")	
				apu.documento 	= tab_datos.pagina1.dw_1.getitemstring(1,"factura")		
	
				IF f_dh_contagene(codigo_empresa,"40")= "D" THEN
					apu.debe		=	round(datos_salida.gastos[i], 2)
					apu.haber	=	0
				ELSE
					apu.debe		=	0
					apu.haber	=	round(datos_salida.gastos[i], 2)
				END IF	
				
				num_apunte		=	num_apunte +1
				apu.apunte		=	num_apunte	
				apu.orden_apunte	=	num_apunte
				res = f_insert_contaapun(apu) 
				IF res = false THEN
					error_num = 60
				END IF
				// Comprobamos si tiene analitica
				IF f_contaparam_analitica(int(ejer_act),codigo_empresa) THEN
					IF f_analitica_contaplan(int(ejer_act),codigo_empresa,apu.cuenta) = "S" THEN
						coste.coste		  = f_coste_contagene(codigo_empresa,"40")
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
							error_num = 70
						END IF
					END IF
				END IF
				
				
			END IF
		
		next
		
	end if 
	

	// *******************************************************************
	// 	CAMBIAR LA F. VENCIMIENTO EN CARPAGOS
	// *******************************************************************
	

	datastore d
	string sel
	long r,t
	dec orden_carpagos,anyo_dec
	datetime vencim	
	


	anyo_dec = dec(em_anyo.text)
	
	sel = " select empresa,anyo,orden,fra from carpagos " + &
			" where carpagos.empresa = '"+codigo_empresa +"'" + &
			" and anyo = " + string(anyo_dec)
			
	d = f_cargar_cursor(sel)
	r = d.rowcount()


	vencim = tab_datos.pagina3.dw_4.getitemdatetime(1,"pro_fvencimiento")


// Esto sólo se hace en IKON

//	for t = 1 to r 
//		ff = Mid(d.getitemstring(t,"fra"),1,6)
//		IF anticipo.factura = ff Then
//			orden_carpagos = d.getitemnumber(t,"orden")
//			
//			update carpagos
//			set carpagos.fvto = :vencim
//			where (carpagos.empresa = :codigo_empresa)  and
//					(carpagos.anyo    = :anyo_dec)           and
//					(carpagos.orden   = :orden_carpagos);
//		END IF
//
//	next


	
	
	
	
	
	
	
	
	
	
	//********************************************************************
	//  CONTROL DE ERRORES
	// *******************************************************************
	
	if error_num = 0 then
		if apu.apunte > 0 then
			em_asiento.text = string(apu.asiento)
		end if
		f_mensaje("BIEN","Los datos de prórroga se grabaron correctamente")			
		commit;
	else
		em_asiento.text = ""
		string final
		choose case error_num
			case 1
				final = "error al actualizar datos prorroga."
			case 10
				final = "error en apunte al banco."
			case 20
				final = "error en apunte al banco por los gastos."
			case 30
				final = "error en apunte al riesgo banco."
			case 40
				final = "error en apunte por intereses."
			case 50
				final = "error en apunte contabilidad analítica intereses."
			case 60
				final = "error en apunte por los gastos."
			case 70
				final = "error en apunte contabilidad analitica gastos."
			case 80  
				final = "error al grabar en la CARTERA DE PAGOS."
		end choose
		f_mensaje("ATENCIÓN","Los datos de prórroga NO se grabaron correctamente, " +final ) 
		rollback;
		RETURN
	END IF
	
	
	f_activa()
	tab_datos.pagina1.dw_1.reset()
	tab_datos.pagina2.dw_2.reset()
	tab_datos.pagina3.dw_4.reset()
	
	em_anticipo.text = ""
	em_anticipo.setfocus()
	
	rb_1.enabled = true
	rb_2.enabled = true
	
	
	
end if


setpointer(arrow!)
end event

type em_fcontable from editmask within w_prorroga_anticipos
integer x = 530
integer y = 1244
integer width = 306
integer height = 92
integer taborder = 70
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

type st_22 from statictext within w_prorroga_anticipos
integer x = 133
integer y = 1252
integer width = 389
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
string text = "F. Contable :"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_22 from groupbox within w_prorroga_anticipos
integer x = 2126
integer y = 1160
integer width = 622
integer height = 220
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_3 from groupbox within w_prorroga_anticipos
integer x = 887
integer y = 1160
integer width = 462
integer height = 220
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_2 from groupbox within w_prorroga_anticipos
integer x = 1353
integer y = 1160
integer width = 768
integer height = 220
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_1 from groupbox within w_prorroga_anticipos
integer x = 105
integer y = 1160
integer width = 777
integer height = 220
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type rb_1 from radiobutton within w_prorroga_anticipos
integer x = 914
integer y = 1216
integer width = 425
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Con gastos"
end type

type rb_2 from radiobutton within w_prorroga_anticipos
integer x = 914
integer y = 1284
integer width = 407
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Sin gastos"
end type

type cb_cancelar from commandbutton within w_prorroga_anticipos
integer x = 1746
integer y = 1236
integer width = 343
integer height = 108
integer taborder = 90
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
tab_datos.pagina1.dw_1.reset()
tab_datos.pagina2.dw_2.reset()
tab_datos.pagina3.dw_4.reset()

em_anticipo.text = ""
em_anticipo.setfocus()
dw_3.visible = false

rb_1.enabled = true
rb_2.enabled = true

em_asiento.text = ""
end event

type st_1 from statictext within w_prorroga_anticipos
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

type st_2 from statictext within w_prorroga_anticipos
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

type st_boton_anticipo from statictext within w_prorroga_anticipos
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
// Anticipos del banco en la situación 2 ó 3 
reg = dw_3.retrieve(codigo_empresa,em_banco.text,integer(em_anyo.text),2,3)
if reg > 0 then
	dw_3.visible = true
	dw_3.setfocus()
else
	messagebox("Atención","No hay anticipos pendientes para el banco y el año seleccionados ")
	em_anticipo.setfocus()
end if


end event

type em_banco from u_em_campo within w_prorroga_anticipos
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 114
integer y = 192
integer taborder = 10
boolean bringtotop = true
long backcolor = 16777215
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

type em_asiento from editmask within w_prorroga_anticipos
integer x = 2423
integer y = 1244
integer width = 293
integer height = 88
integer taborder = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
alignment alignment = center!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
string mask = "###,###,###"
string displaydata = ""
end type

type st_33 from statictext within w_prorroga_anticipos
integer x = 2153
integer y = 1252
integer width = 265
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
string text = "Asiento :"
alignment alignment = center!
boolean focusrectangle = false
end type

