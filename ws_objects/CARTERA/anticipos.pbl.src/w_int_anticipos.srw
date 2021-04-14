$PBExportHeader$w_int_anticipos.srw
$PBExportComments$Introducción de Anticipos
forward
global type w_int_anticipos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_anticipos
end type
type cb_consultar from commandbutton within w_int_anticipos
end type
type em_anyo from editmask within w_int_anticipos
end type
type st_8 from statictext within w_int_anticipos
end type
type em_vencimiento from u_em_campo within w_int_anticipos
end type
type em_plazo_real from u_em_campo within w_int_anticipos
end type
type st_9 from statictext within w_int_anticipos
end type
type em_anticipo from u_em_campo within w_int_anticipos
end type
type st_nombre_banco from statictext within w_int_anticipos
end type
type tab_datos from tab within w_int_anticipos
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
type tab_datos from tab within w_int_anticipos
pagina1 pagina1
pagina2 pagina2
end type
type cb_nuevo from commandbutton within w_int_anticipos
end type
type cb_grabar from commandbutton within w_int_anticipos
end type
type dw_3 from datawindow within w_int_anticipos
end type
type em_fac_desde from editmask within w_int_anticipos
end type
type em_fac_hasta from editmask within w_int_anticipos
end type
type gb_8 from groupbox within w_int_anticipos
end type
type gb_6 from groupbox within w_int_anticipos
end type
type st_4 from statictext within w_int_anticipos
end type
type cb_1 from commandbutton within w_int_anticipos
end type
type st_1 from statictext within w_int_anticipos
end type
type st_2 from statictext within w_int_anticipos
end type
type st_boton_anticipo from statictext within w_int_anticipos
end type
type st_5 from statictext within w_int_anticipos
end type
type uo_cliente from u_em_campo_2 within w_int_anticipos
end type
type gb_7 from groupbox within w_int_anticipos
end type
type em_banco from u_em_campo within w_int_anticipos
end type
type cb_retroceder from commandbutton within w_int_anticipos
end type
end forward

global type w_int_anticipos from w_int_con_empresa
integer width = 2752
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
cb_nuevo cb_nuevo
cb_grabar cb_grabar
dw_3 dw_3
em_fac_desde em_fac_desde
em_fac_hasta em_fac_hasta
gb_8 gb_8
gb_6 gb_6
st_4 st_4
cb_1 cb_1
st_1 st_1
st_2 st_2
st_boton_anticipo st_boton_anticipo
st_5 st_5
uo_cliente uo_cliente
gb_7 gb_7
em_banco em_banco
cb_retroceder cb_retroceder
end type
global w_int_anticipos w_int_anticipos

type variables
string filtro

integer var_ejercicio
string es_nacional
boolean inst_nuevo
editmask isle_campo
end variables

forward prototypes
public subroutine f_desactiva ()
public subroutine f_activa ()
public subroutine f_calcula_vencim (integer arg_caso, string arg_valor)
protected function boolean f_ya_anticipado (decimal arg_efecto, decimal arg_anyo)
end prototypes

public subroutine f_desactiva ();em_banco.enabled = false
em_anyo.enabled = false
em_anticipo.enabled = false
cb_consultar.enabled = false
em_fac_desde.enabled = false
em_fac_hasta.enabled = false
st_boton_anticipo.enabled = false
cb_retroceder.enabled = false
end subroutine

public subroutine f_activa ();em_banco.enabled = true
em_anyo.enabled = true
em_anticipo.enabled = true
cb_consultar.enabled = true
em_fac_desde.enabled = true
em_fac_hasta.enabled = true
st_boton_anticipo.enabled = true
cb_retroceder.enabled = true
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
		el_plazo	= tab_datos.pagina2.dw_2.Object.plazo[1]
		
	// evento itemchaged del campo "plazo" de la dw pagina3	
	case 2
		el_plazo = 	integer(arg_valor)
		f_valor = date(tab_datos.pagina2.dw_2.Object.fvalor[1])
		
	// evento clicked botón procesar
	case 3
		f_valor = date(tab_datos.pagina2.dw_2.Object.fvalor[1])
		el_plazo	= tab_datos.pagina2.dw_2.Object.plazo[1]
		
end choose



// El día de vencimiento es la fecha de valor + los días de plazo

if el_plazo > 0 then
	dia_venci = relativedate(f_valor, el_plazo)
else
	dia_venci = f_valor
end if

tab_datos.pagina2.dw_2.Object.vencimiento[1] = dia_venci

nom_dia = upper(dayname(dia_venci))

// El plazo real son los días de plazo, exceptuando los casos en que 
// el día de vencimiento es sábado o domingo
int plazo_real

plazo_real = daysafter(today(),dia_venci)

choose case nom_dia
	case "SATURDAY"
		plazo_real = plazo_real - 1
		//tab_datos.pagina2.dw_2.setitem(1,"plazoreal",el_plazo -1)
						
	CASE "SUNDAY"
		plazo_real = plazo_real + 1
		//tab_datos.pagina2.dw_2.setitem(1,"plazoreal",el_plazo + 1)
		
	CASE ELSE
		plazo_real = plazo_real 
		//tab_datos.pagina2.dw_2.setitem(1,"plazoreal",el_plazo)
		
end choose

if plazo_real <= 0 then
	tab_datos.pagina2.dw_2.Object.plazoreal[1]=0
else
	tab_datos.pagina2.dw_2.Object.plazoreal[1]=plazo_real		
end if
end subroutine

protected function boolean f_ya_anticipado (decimal arg_efecto, decimal arg_anyo);int cant,r,i,contador,situ,anyo_int
string sel,banco
boolean encontrado
dec {2} efecto_dec
datastore d

cant = 0
anyo_int = integer(arg_anyo)
efecto_dec = arg_efecto
encontrado = false

// Cuanta veces aparece el efecto
select count(*) into :cant
from carfinanefe
where (carfinanefe.empresa = :codigo_empresa)	and
		(carfinanefe.orden = :arg_efecto)			and
		(carfinanefe.ejercicio = :anyo_int);

if isnull(cant) then cant = 0
	

if cant > 0 then 
	
	// Si está más de una vez comprobamos en carfinan que no está 
	// en situación 9 ( anulado )
	sel = " Select bancofinan, contador " + & 
			" from carfinanefe " + &
			" where ( carfinanefe.empresa = '"+ codigo_empresa + "' ) and " + &
			"	( carfinanefe.ejercicio = "+string(integer(arg_anyo))  + ") and " + &
			"  ( carfinanefe.orden = " + string(integer(arg_efecto)) +" )"
	
	d = f_cargar_cursor(sel)
	r = d.rowcount()
	
	
	for i = 1 to r 
		banco = d.getitemstring(i,"bancofinan")
		contador = d.getitemnumber(i,"contador")
		
		select situacion into :situ
		from carfinan
		where (carfinan.empresa = :codigo_empresa )	and
				(carfinan.anyo = :arg_anyo )				and
				(carfinan.bancofinan = :banco)			and
				(carfinan.contador = :contador)			and
				(carfinan.num_prorroga = 0);
		 
		
		if situ <> 9 then 
			encontrado = true		
		end if

	next
	
	if encontrado then
		// El efecto está en carfinanefe y la situación del anticipo <> 9
		return true
	else
		// El efecto está en carfinanefe pero la situación del anticipo = 9
		return false
	end if
	
else
	// No está el efecto en carfinanefe 
	return false
end if
end function

event open;call super::open;istr_parametros.s_titulo_ventana="Introducción de Anticipos"
This.title=istr_parametros.s_titulo_ventana



tab_datos.pagina1.dw_1.settransobject(sqlca)
tab_datos.pagina2.dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)

em_anyo.text = string(year(today()))
em_fac_desde.text = string(year(today()) - 1)
em_fac_hasta.text = string(year(today()))

uo_cliente.em_campo.enabled = false

cb_grabar.enabled = false
cb_retroceder.enabled = false
dw_3.visible = false

// variable instancia para saber si se está consultando o es nuevo anticipo
inst_nuevo = false

end event

on w_int_anticipos.create
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
this.cb_nuevo=create cb_nuevo
this.cb_grabar=create cb_grabar
this.dw_3=create dw_3
this.em_fac_desde=create em_fac_desde
this.em_fac_hasta=create em_fac_hasta
this.gb_8=create gb_8
this.gb_6=create gb_6
this.st_4=create st_4
this.cb_1=create cb_1
this.st_1=create st_1
this.st_2=create st_2
this.st_boton_anticipo=create st_boton_anticipo
this.st_5=create st_5
this.uo_cliente=create uo_cliente
this.gb_7=create gb_7
this.em_banco=create em_banco
this.cb_retroceder=create cb_retroceder
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
this.Control[iCurrent+11]=this.cb_nuevo
this.Control[iCurrent+12]=this.cb_grabar
this.Control[iCurrent+13]=this.dw_3
this.Control[iCurrent+14]=this.em_fac_desde
this.Control[iCurrent+15]=this.em_fac_hasta
this.Control[iCurrent+16]=this.gb_8
this.Control[iCurrent+17]=this.gb_6
this.Control[iCurrent+18]=this.st_4
this.Control[iCurrent+19]=this.cb_1
this.Control[iCurrent+20]=this.st_1
this.Control[iCurrent+21]=this.st_2
this.Control[iCurrent+22]=this.st_boton_anticipo
this.Control[iCurrent+23]=this.st_5
this.Control[iCurrent+24]=this.uo_cliente
this.Control[iCurrent+25]=this.gb_7
this.Control[iCurrent+26]=this.em_banco
this.Control[iCurrent+27]=this.cb_retroceder
end on

on w_int_anticipos.destroy
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
destroy(this.cb_nuevo)
destroy(this.cb_grabar)
destroy(this.dw_3)
destroy(this.em_fac_desde)
destroy(this.em_fac_hasta)
destroy(this.gb_8)
destroy(this.gb_6)
destroy(this.st_4)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_boton_anticipo)
destroy(this.st_5)
destroy(this.uo_cliente)
destroy(this.gb_7)
destroy(this.em_banco)
destroy(this.cb_retroceder)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_anticipos
integer x = 2112
integer y = 20
integer width = 485
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_anticipos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_anticipos
integer y = 16
integer width = 2427
integer height = 96
end type

type pb_1 from upb_salir within w_int_anticipos
integer x = 2555
integer y = 8
integer width = 142
integer height = 116
integer taborder = 0
end type

type cb_consultar from commandbutton within w_int_anticipos
integer x = 1664
integer y = 124
integer width = 347
integer height = 84
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

event clicked;// **********************************************************************
//	CONTROL DE DATOS
// *********************************************************************

// Comprobamos la situación del anticipo por si se ha introducido
// directamente sobre el campo "em_anticipo".
// La situación ha de ser 0 ó 1
int la_situacion,el_anyo,el_anticipo
el_anyo = integer(em_anyo.text)
el_anticipo = integer(em_anticipo.text)

select situacion into :la_situacion
from carfinan
where (carfinan.empresa = :codigo_empresa)	and
		(carfinan.anyo = :el_anyo)					and
		(carfinan.bancofinan = :em_banco.text)	and
		(carfinan.contador = :el_anticipo)		and
		(carfinan.num_prorroga = 0);


if la_situacion >= 2 then 
	em_anticipo.text = ""
	tab_datos.pagina1.dw_1.reset()
	tab_datos.pagina2.dw_2.reset()
	uo_cliente.em_campo.text = ""
	em_anticipo.setfocus()
	return
end if


// **********************************************************************
//	MOSTRAR DATOS
// **********************************************************************

int registros1,registros2

// Presentamos los anticipos del banco elegido con prórroga 0
registros2 = tab_datos.pagina2.dw_2.retrieve(codigo_empresa,em_banco.text,integer(em_anticipo.text),0,el_anyo)

// Presentamos los datos del cliente y la fecha del anticipo
if registros2 > 0 then
	uo_cliente.em_codigo.text = tab_datos.pagina2.dw_2.getitemstring(1,"cliente")
	uo_cliente.em_campo.text = f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)

else
	uo_cliente.em_campo.text = ""
	uo_cliente.em_codigo.text = ""
	
end if

// presentamos las facturas del cliente entre los años
int i,reg,cantidad,ord,cont,ejer
string filt

tab_datos.pagina1.dw_1.visible = false

filt = ""
tab_datos.pagina1.dw_1.setfilter(filt)
tab_datos.pagina1.dw_1.filter()


reg = tab_datos.pagina1.dw_1.retrieve(codigo_empresa,integer(em_fac_desde.text),integer(em_fac_hasta.text),uo_cliente.em_codigo.text,"N")




// marcamos los campos de punteo si tiene facturas en anticipos

cont = integer(em_anticipo.text)
int senyalados,anyo_int
senyalados = 0

anyo_int = integer(em_anyo.text)
for i = 1 to reg
	ord = integer(tab_datos.pagina1.dw_1.getitemnumber(i,"orden"))
	ejer = integer(tab_datos.pagina1.dw_1.getitemnumber(i,"anyo"))
	
	select count(*) into :cantidad
	from carfinanefe
	where empresa = :codigo_empresa and
			bancofinan = :em_banco.text and
			contador = :cont and
			ejercicio = :ejer and
			orden = :ord and
			anyo = :anyo_int;
			
	if cantidad =1 then 
		tab_datos.pagina1.dw_1.setitem(i,"punt2","S")
		// Cuantos efectos hay señalados de una factura
		senyalados = senyalados +1
	end if
	
next


filt = "punt2 = '"+"S"+"'"
tab_datos.pagina1.dw_1.setfilter(filt)
tab_datos.pagina1.dw_1.filter()


// Al consultar Dw visibles pero no enabled
tab_datos.pagina1.dw_1.visible = true

tab_datos.pagina1.dw_1.enabled = false
tab_datos.pagina2.dw_2.enabled = false

// variable instancia para saber si se está consultando o es nuevo anticipo
inst_nuevo = false

cb_grabar.enabled = false
uo_cliente.em_campo.enabled = false
cb_retroceder.enabled = true

tab_datos.selecttab(2)
end event

type em_anyo from editmask within w_int_anticipos
integer x = 1038
integer y = 204
integer width = 224
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

event modified;//em_fac_desde.text = em_anyo.text
end event

type st_8 from statictext within w_int_anticipos
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

type em_vencimiento from u_em_campo within w_int_anticipos
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

type em_plazo_real from u_em_campo within w_int_anticipos
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

type st_9 from statictext within w_int_anticipos
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

type em_anticipo from u_em_campo within w_int_anticipos
integer x = 1303
integer y = 204
integer width = 302
integer height = 88
integer taborder = 30
long backcolor = 16777215
alignment alignment = right!
end type

event modified;call super::modified;dw_3.visible = FALSE
end event

type st_nombre_banco from statictext within w_int_anticipos
integer x = 347
integer y = 208
integer width = 658
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

type tab_datos from tab within w_int_anticipos
event create ( )
event destroy ( )
integer x = 114
integer y = 296
integer width = 2583
integer height = 856
integer taborder = 140
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
end type

on tab_datos.create
this.pagina1=create pagina1
this.pagina2=create pagina2
this.Control[]={this.pagina1,&
this.pagina2}
end on

on tab_datos.destroy
destroy(this.pagina1)
destroy(this.pagina2)
end on

event selectionchanged;// Si se pincha la segunda página y se está insertando un
// nuevo anticipo calculamos el valor del anticipo
// para pasarlo como defecto a la página2
// También pasamos la moneda y la fecha de valor


int reg,i,punteados
string punte,mone
dec total_div
datetime fecha_valor,fecha_valor2

punteados = 0
total_div = 0
fecha_valor = datetime(date("1/1/75"))
if newindex= 2 and inst_nuevo then 
	
	reg = tab_datos.pagina1.dw_1.rowcount()
	
	for i = 1 to reg
		punte = tab_datos.pagina1.dw_1.getitemstring(i,"punt2")
		if punte = "S" then
			punteados = punteados +1
			// Sumamos el total de las divisas
			total_div = total_div + tab_datos.pagina1.dw_1.getitemnumber(i,"divisas")	
			// La moneda en toda la factura es la misma
			mone = tab_datos.pagina1.dw_1.getitemstring(i,"monedas") 			
			// La fecha de valor es la última fecha de vencimiento
			fecha_valor2 = tab_datos.pagina1.dw_1.getitemdatetime(i,"fvto")
			if fecha_valor2 > fecha_valor then fecha_valor = fecha_valor2
			
			
		end if
		
		
	next
	
	// si hay alguno que se haya marcado pasamos los valores por defecto
	if punteados > 0 then
		
		// pasamos moneda ,fvto y divisas	
		tab_datos.pagina2.dw_2.setitem(1,"moneda",mone)
		tab_datos.pagina2.dw_2.setitem(1,"divisasfinan",total_div)
		tab_datos.pagina2.dw_2.setitem(1,"fvalor",fecha_valor)
		tab_datos.pagina2.dw_2.setitem(1,"plazo",0)
		tab_datos.pagina2.dw_2.setitem(1,"vencimiento",fecha_valor)
		tab_datos.pagina2.dw_2.setitem(1,"plazoreal",0)
	end if
	
	
end if
	
	

end event

type pagina1 from userobject within tab_datos
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2546
integer height = 736
long backcolor = 12632256
string text = "Facturas"
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
integer x = 114
integer width = 2345
integer height = 700
integer taborder = 51
boolean bringtotop = true
string dataobject = "dw_int_anticipos"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;string punteado,fac1,fac2,nuevo_valor 
int i,total_filas
boolean final

final = false

CHOOSE CASE f_objeto_datawindow(This)
	// Si se pincha en punt1 (seleccionar toda la factura)
	CASE "punt1"
		
		punteado = trim(tab_datos.pagina1.dw_1.getitemstring(row,"punt1"))
		// Cambiamos su valor
		if punteado = "S" then
			nuevo_valor = "N"
		else
			nuevo_valor = "S"
		end if
		
		total_filas = tab_datos.pagina1.dw_1.rowcount()
		
		// Cambiamos el valor  de todos los elementos de la factura	(grupo)
		
		// Primero el de la primera fila
		tab_datos.pagina1.dw_1.setitem(row,"punt2",nuevo_valor)
		fac1 = trim(tab_datos.pagina1.dw_1.getitemstring(row,"factura"))
		
		i = row + 1
		if i <= total_filas then
			fac2 = trim(tab_datos.pagina1.dw_1.getitemstring(i,"factura"))
		else
			final = true
		end if 
		
		// después el resto de elementos del grupo
		do while ( fac1 = fac2 ) and not final
			
			tab_datos.pagina1.dw_1.setitem(i,"punt2",nuevo_valor)
			tab_datos.pagina1.dw_1.setitem(i,"punt1",nuevo_valor)
			i = i + 1
			if i <= total_filas then
				fac2 = trim(tab_datos.pagina1.dw_1.getitemstring(i,"factura"))
			else
				final = true
			end if
			
		loop 
		
	
		
	
	
end choose
end event

event itemchanged;cb_grabar.enabled = true
uo_cliente.em_campo.enabled = false


end event

type pagina2 from userobject within tab_datos
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2546
integer height = 736
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
integer x = 142
integer y = 100
integer width = 2226
integer height = 436
integer taborder = 101
boolean bringtotop = true
string dataobject = "dw_mant_anticipos"
boolean border = false
boolean livescroll = true
end type

event itemchanged;cb_grabar.enabled = true
uo_cliente.em_campo.enabled = false


string fecha,nom_dia
date f1,f2
long dias,plazo_real

CHOOSE CASE dwo.name
		
	case "plazo"
		f_calcula_vencim(2,data)
		
	case "fvalor"		
		
		fecha = mid(data,9,2)+"/"+mid(data,6,2)+ "/" +mid(data,1,4)		
		f_calcula_vencim(1,fecha)
				

	case "vencimiento"
		// Obtenemos del argumento data el valor del vencimiento
		fecha = mid(data,9,2)+"/"+mid(data,6,2)+ "/" +mid(data,1,4)		
		
		f1 = today()//date(tab_datos.pagina2.dw_2.getitemdatetime(1,"fvalor"))
		f2 = date(fecha)
		dias = daysafter(f1,f2)	
//		if dias < 0 then
//			messagebox("Atención"," Fecha de vencimiento MENOR que fecha de valor ")
//			tab_datos.pagina2.dw_2.setitem(1,"plazo",0)
//			tab_datos.pagina2.dw_2.setitem(1,"vencimiento",f1)
//			tab_datos.pagina2.dw_2.setitem(1,"plazoreal",0)
//		else
			tab_datos.pagina2.dw_2.setitem(1,"plazo",dias)
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
					
			tab_datos.pagina2.dw_2.setitem(1,"plazoreal",plazo_real)
//		end if
end choose


end event

event rbuttondown;CHOOSE CASE f_objeto_datawindow(This)
		
	case "moneda"
		
		string mone
		str_parametros astr_parametros
		
		astr_parametros.s_criterio_busqueda = ""
		astr_parametros.s_nom_datawindow = "dw_ayuda_divisas"
		astr_parametros.s_filtro = ""
		astr_parametros.s_titulo_ayuda = "Ventana ayuda divisas"
		
		
		openwithparm(w_busquedas,astr_parametros)
		
		mone = message.stringparm
		
		tab_datos.pagina2.dw_2.setitem(1,"moneda",mone)
		

		
		
	
		
end choose
end event

type cb_nuevo from commandbutton within w_int_anticipos
integer x = 187
integer y = 1280
integer width = 311
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Nuevo"
end type

event clicked;
if em_banco.text = "" then
	messagebox("Atención","Debe introducir los datos de BANCO y AÑO ")
	em_banco.setfocus()
	return
end if

if em_anyo.text = "" or isnull(em_anyo.text) or integer(em_anyo.text) = 0 then
	messagebox("Atención","Debe introducir los datos de BANCO y AÑO ")
	em_anyo.setfocus()
	return
end if

f_desactiva()
em_anticipo.text = ""

// introducir el cliente
uo_cliente.enabled = true
uo_cliente.em_campo.enabled = true
uo_cliente.em_campo.text = ""

setfocus(uo_cliente.em_campo)

// limpiar dw
tab_datos.pagina1.dw_1.enabled = true
tab_datos.pagina1.dw_1.reset()
tab_datos.pagina2.dw_2.reset()
tab_datos.pagina2.dw_2.insertrow(1)

cb_grabar.enabled = false



// cuando es nuevo se puede modificar en dw_1
inst_nuevo = true


// botones nuevo y consultar not enable

cb_nuevo.enabled = false
cb_consultar.enabled = false



// Datos por defecto en dw_2

// Por defecto la prórroga activa es la 0 
tab_datos.pagina2.dw_2.setitem(1,"prorroga_activa",0)


tab_datos.pagina1.dw_1.enabled = true
tab_datos.pagina2.dw_2.enabled = true

tab_datos.selecttab(1)


end event

type cb_grabar from commandbutton within w_int_anticipos
integer x = 1957
integer y = 1276
integer width = 311
integer height = 92
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Grabar"
end type

event clicked;tab_datos.pagina2.dw_2.accepttext()
// Calculamos el vencimiento
f_calcula_vencim(3,"")


// ********************************************************************
// CONTROL DE CLIENTE
// *********************************************************************

IF uo_cliente.em_campo.text = "" then

	messagebox("ATENCIÓN","Debe introducir el cliente")
	uo_cliente.em_campo.setfocus()
	return
end if




// *********************************************************************
// CONTROL ELEMENTOS PÁGINA1
//**********************************************************************


// Control hay facturas 
int filas

filas =  tab_datos.pagina1.dw_1.rowcount() 

if filas <= 0 then

	f_mensaje("Atención ","No hay Facturas ")
	tab_datos.selecttab(1)
	return

end if




// Control hay una única factura seleccionada
int i,cuantos,cuantos2
string marcado,marcado2

string punte,factu
string fac[]
int k

cuantos = 0
cuantos2 = 0
k = 0

for i = 1 to filas
	punte = tab_datos.pagina1.dw_1.Object.punt1[i]
	factu = tab_datos.pagina1.dw_1.Object.factura[i]
	if punte = "S" then
		k = k + 1
		fac[k] = factu
	end if
next



for i = 2 to k
	if fac[i] <> fac[i - 1] then
		f_mensaje("Atención","Se ha seleccionado más de una factura")
		tab_datos.selecttab(1)
		return
	end if
next




// Control se han señalado elementos de una única factura
string factura,factura_ant
string facturas[]
int j
dec efectos[],anyos[]

j = 0
cuantos = 0

for i = 1 to filas 
	marcado = tab_datos.pagina1.dw_1.Object.punt2[i]
	factura = tab_datos.pagina1.dw_1.Object.factura[i]
	if marcado = "S" then 
		j = j+1
		facturas[j] = factura 	
		efectos[j] = tab_datos.pagina1.dw_1.Object.orden[i]
		anyos[j] = tab_datos.pagina1.dw_1.Object.anyo[i]
		
	end if

next

for i = 2 to j 
	if facturas[i] <> facturas[i - 1] then
		f_mensaje("Atención","Se han seleccionado efectos de diversas facturas")
		tab_datos.selecttab(1)
		return
	end if
next



// Control los efectos seleccionados no están ya anticipados.
int op
boolean anticipado
anticipado = false

for i = 1 to j 
	
	anticipado = f_ya_anticipado(efectos[i],anyos[i])
	if anticipado then 
		op = messagebox("Atención","Los efectos selecconados ya han sido anticipados, ¿ Desea continuar ?",question!,yesno!,2)
		if op = 2 then return		
		
	end if
next


// tiene que haber al menos uno señalado
if  j = 0 then
	f_mensaje("Atención","No se ha seleccionado factura o efecto")
	return
end if



// *********************************************************************
// CONTROL ELEMENTOS PÁGINA2
//**********************************************************************

string la_moneda,el_banco_abono
datetime la_fvalor,el_vencimiento 
int el_plazo
dec las_divisas

// El plazo
el_plazo = tab_datos.pagina2.dw_2.Object.plazo[1]

if (isnull(el_plazo)) or (string(el_plazo)) = "" or (el_plazo < 0) then
	f_mensaje("Atención","Debe introducir el plazo")
	tab_datos.selecttab(2)
	tab_datos.pagina2.dw_2.setfocus()
	tab_datos.pagina2.dw_2.setcolumn("plazo")	
	return
end if


// La fecha de valor
la_fvalor =  tab_datos.pagina2.dw_2.Object.fvalor[1]

if not isdate(string(date(la_fvalor))) or isnull(la_fvalor) then
	f_mensaje("Atención","Fecha de valor no válida")
	tab_datos.selecttab(2)
	tab_datos.pagina2.dw_2.setfocus()
	tab_datos.pagina2.dw_2.setcolumn("fvalor")	
	return
end if


// moneda
la_moneda =  tab_datos.pagina2.dw_2.Object.moneda[1]
if isnull(la_moneda) or (la_moneda = "") then
	f_mensaje("Atención","Debe introducir la moneda")
	tab_datos.selecttab(2)
	tab_datos.pagina2.dw_2.setfocus()
	tab_datos.pagina2.dw_2.setcolumn("moneda")	
	return
end if



// Las divisas
las_divisas = tab_datos.pagina2.dw_2.Object.divisasfinan[1]
if isnull(las_divisas) or (string(las_divisas) = "") then las_divisas = 0 

if las_divisas = 0 then
	f_mensaje("Atención","Debe introducir las divisas")
	tab_datos.selecttab(2)
	tab_datos.pagina2.dw_2.setfocus()
	tab_datos.pagina2.dw_2.setcolumn("divisasfinan")	
	return
end if



// vencimiento
el_vencimiento = tab_datos.pagina2.dw_2.Object.vencimiento[1]
if isnull(el_vencimiento) or not isdate(string(date(el_vencimiento)))  then
 	f_mensaje("Atención","Debe introducir el vencimiento")
	tab_datos.selecttab(2)
	return
end if


// **********************************************************************
// GRABAMOS LOS CAMBIOS
// **********************************************************************


// grabamos en "CARFINANEFE" los efectos señalados en pagina1
// sólo si es la primera vez que se introduce el anticipo

string   punt1,punt2,serie,la_factura,mone,forma_pago
int      anticip,ord,anyo_fac,ejer,recib,maxim,anyo_int
datetime ffac,venci
dec{2}   imp
dec      div, cambi
boolean  correcto


anyo_int = integer(em_anyo.text) 

correcto = true


// sólo si es nuevo
if inst_nuevo then
	
	// Buscamos el contador de anticipos de extranjero (A + codigo_banco)  
	maxim = f_numero_contador(codigo_empresa,string(em_anyo.text), "A"+ em_banco.text)

	anticip = maxim
	em_anticipo.text = string(maxim)
	
	string formas_pag[]
	
	for i = 1 to filas
		punt1 = tab_datos.pagina1.dw_1.Object.punt1[i]
		punt2 = tab_datos.pagina1.dw_1.Object.punt2[i]
		
		if isnull(punt1) then punt1= "N"
		if isnull(punt2) then punt2= "N"
		
		// Para los efectos marcados
		if (punt1 = "S") and (punt2 = "S") or &
			(punt2 = "S") and (punt1 <> "S") then
			  
			  
			 // recogemos datos de carefectos mediante la dw 
			 ord = tab_datos.pagina1.dw_1.Object.orden[i]
			 ejer = tab_datos.pagina1.dw_1.Object.anyo[i]
			 anyo_fac= integer(tab_datos.pagina1.dw_1.Object.anyofra[i])
			 serie =tab_datos.pagina1.dw_1.Object.serie[i]
			 la_factura=tab_datos.pagina1.dw_1.Object.factura[i]
			 ffac = tab_datos.pagina1.dw_1.Object.ffra[i]
			 imp = tab_datos.pagina1.dw_1.Object.importe[i]
			 div =tab_datos.pagina1.dw_1.Object.divisas[i]
			 cambi = tab_datos.pagina1.dw_1.Object.cambio[i]
			 venci = tab_datos.pagina1.dw_1.Object.fvto[i]
			 recib = tab_datos.pagina1.dw_1.Object.recibo[i]
			 mone  = tab_datos.pagina1.dw_1.Object.monedas[i]
			 forma_pago = tab_datos.pagina1.dw_1.Object.fpago[i]
			 formas_pag[i] = forma_pago

			 // CAMBIAR LA SITUACION EN CARTERA	
			UPDATE carefectos
			set   carefectos.situacion = "8", carefectos.banco =  :em_banco.text
			where carefectos.empresa 	=  :codigo_empresa
			and	carefectos.anyo		=	:ejer
			and	carefectos.orden		=	:ord;

			 // insertamos en "CARFINANEFE"
			  INSERT INTO carfinanefe  
				( empresa,   
				  bancofinan,   
				  contador,   
				  ejercicio,   
				  orden,   
				  anyo_fac,   
				  serie_fac,   
				  factura,   
				  ffactura,   
				  pago,   
				  importe_efec,   
				  divisas_efec,   
				  cambio_efec,   
				  vto_efec,
				  anyo,
				  moneda_efec,
				  fpago)  
				 VALUES ( 
				  :codigo_empresa,   
				  :em_banco.text,   
				  :anticip,   
				  :ejer,   
				  :ord,   
				  :anyo_fac,   
				  :serie,   
				  :la_factura,   
				  :ffac,
				  :recib,
				  :imp,   
				  :div,                               
				  :cambi,
				  :venci,
				  :anyo_int,
				  :mone,
				  :forma_pago)  ;
	
					if sqlca.sqlcode <> 0 then correcto = false
			
			
		end if
	next
	
end if
	
	

// **********************************************************************
// CONTROL DE LA FORMA DE PAGO. DEBE SER ÚNICA
// **********************************************************************
int l
boolean correcte
string fpago_factura

correcte = true
if l > 1 then
	FOR l = 2 to i
		if formas_pag[l - 1] <> formas_pag[l] then
			correcte = false
			exit
		end if
	next

end if


if correcte = false then
	messagebox("Atención","Existe más de una forma de pago para los efectos seleccionados")
	
else
	// Todas las formas de pago son iguales
	fpago_factura = formas_pag[1]
end if



// Grabamos en "CARFINAN"

tab_datos.pagina2.dw_2.Object.empresa[1]=codigo_empresa
tab_datos.pagina2.dw_2.Object.anyo[1]=integer(em_anyo.text)
tab_datos.pagina2.dw_2.Object.bancofinan[1]=em_banco.text
tab_datos.pagina2.dw_2.Object.contador[1]=integer(em_anticipo.text)
tab_datos.pagina2.dw_2.Object.num_prorroga[1]=0
// situación 0. 
tab_datos.pagina2.dw_2.Object.situacion[1]=0

tab_datos.pagina2.dw_2.Object.cliente[1]=uo_cliente.em_codigo.text
tab_datos.pagina2.dw_2.Object.prorroga_activa[1]=0
tab_datos.pagina2.dw_2.Object.factura[1]=la_factura
tab_datos.pagina2.dw_2.Object.anyo_fac[1]=anyo_fac
tab_datos.pagina2.dw_2.Object.serie_fac[1]=serie
tab_datos.pagina2.dw_2.Object.fpago[1]=formas_pag[1]


if tab_datos.pagina2.dw_2.update() < 1 then correcto = false



if not correcto then
	f_mensaje("Atención","No se ha podido grabar el anticipo")
	tab_datos.pagina1.dw_1.reset()
	tab_datos.pagina2.dw_2.reset()
	em_anticipo.text = ""
	uo_cliente.em_campo.text = ""
	rollback;
else
	f_mensaje("Bien","El anticipo ha sido grabado")
	commit;
end if


cb_nuevo.enabled = true
cb_consultar.enabled = true
cb_grabar.enabled = false
uo_cliente.enabled = false


// Dw visibles pero no enabled
tab_datos.pagina1.dw_1.visible = true

tab_datos.pagina1.dw_1.enabled = false
tab_datos.pagina2.dw_2.enabled = false
f_activa()




end event

type dw_3 from datawindow within w_int_anticipos
boolean visible = false
integer x = 27
integer y = 292
integer width = 2697
integer height = 616
integer taborder = 70
boolean bringtotop = true
string dataobject = "dw_ayuda_carfinan"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;CHOOSE CASE f_objeto_datawindow(This)
		
	case "contador","num_prorroga","factura","nom_serie","nom_cliente","divisasfinan","nom_moneda"
		em_anticipo.text = string(dw_3.getitemnumber(row,"contador"))
		
		dw_3.visible = false
		tab_datos.pagina1.dw_1.reset()
		tab_datos.pagina2.dw_2.reset()
		
		setfocus(cb_consultar)
		cb_consultar.triggerevent("clicked")	
		tab_datos.selecttab(2)
end choose


end event

type em_fac_desde from editmask within w_int_anticipos
integer x = 2075
integer y = 200
integer width = 187
integer height = 88
integer taborder = 60
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

type em_fac_hasta from editmask within w_int_anticipos
integer x = 2327
integer y = 200
integer width = 187
integer height = 88
integer taborder = 80
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

type gb_8 from groupbox within w_int_anticipos
integer x = 1879
integer y = 1184
integer width = 823
integer height = 232
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_6 from groupbox within w_int_anticipos
integer x = 119
integer y = 1184
integer width = 448
integer height = 232
integer taborder = 150
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
end type

type st_4 from statictext within w_int_anticipos
integer x = 2281
integer y = 204
integer width = 46
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "-"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_int_anticipos
integer x = 2313
integer y = 1276
integer width = 311
integer height = 92
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancelar"
end type

event clicked;cb_consultar.enabled = true
cb_nuevo.enabled = true
cb_grabar.enabled = false

uo_cliente.em_campo.text = ""
em_anticipo.text = ""

uo_cliente.enabled = true

tab_datos.pagina1.dw_1.reset()
tab_datos.pagina2.dw_2.reset()

f_activa()
cb_retroceder.enabled = false
uo_cliente.enabled = false

em_anticipo.setfocus()
dw_3.visible = false
end event

type st_1 from statictext within w_int_anticipos
integer x = 110
integer y = 128
integer width = 901
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

type st_2 from statictext within w_int_anticipos
integer x = 1015
integer y = 128
integer width = 288
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
string text = "Año A."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_boton_anticipo from statictext within w_int_anticipos
integer x = 1312
integer y = 128
integer width = 302
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

// anticipos del banco en situación 0 ó 1
reg = dw_3.retrieve(codigo_empresa,em_banco.text,integer(em_anyo.text),0,1)
if reg > 0 then
	dw_3.visible = true
	dw_3.setfocus()
else
	messagebox("Atención","No hay anticipos para la el banco y el año selecionado")
	em_anticipo.setfocus()
end if


end event

type st_5 from statictext within w_int_anticipos
integer x = 2075
integer y = 124
integer width = 439
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
string text = "Año factura"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_cliente from u_em_campo_2 within w_int_anticipos
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 704
integer y = 1280
integer width = 1029
integer taborder = 100
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,'C',uo_cliente.em_codigo.text)
IF Trim(uo_cliente.em_campo.text)="" THEN 
 IF Trim(uo_cliente.em_codigo.text)<>"" Then uo_cliente.em_campo.SetFocus()
 uo_cliente.em_campo.text=""
 uo_cliente.em_codigo.text=""
END IF



// Mostramos las facturas que no son de nacional entre los dos años para el cliente seleccionado


tab_datos.pagina1.dw_1.setfilter("")
tab_datos.pagina1.dw_1.filter()
tab_datos.pagina1.dw_1.retrieve(codigo_empresa,integer(em_fac_desde.text),integer(em_fac_hasta.text),uo_cliente.em_codigo.text,"N")
tab_datos.selecttab(1)


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""

end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type gb_7 from groupbox within w_int_anticipos
integer x = 576
integer y = 1184
integer width = 1298
integer height = 232
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Cliente"
end type

type em_banco from u_em_campo within w_int_anticipos
integer x = 110
integer y = 204
integer width = 229
integer taborder = 10
boolean bringtotop = true
long backcolor = 16777215
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

event modificado;call super::modificado;st_nombre_banco.text=f_nombre_banco(codigo_empresa,em_banco.text)	
IF Trim(st_nombre_banco.text)="" THEN 
 IF Trim(st_nombre_banco.text)<>"" Then f_activar_campo(em_banco)
 em_banco.text=""
END IF
end event

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION BANCOS"
ue_datawindow = "dw_ayuda_carbancos"
ue_filtro     = ""		
isle_campo    = this

end event

type cb_retroceder from commandbutton within w_int_anticipos
integer x = 1664
integer y = 212
integer width = 347
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Retroceder"
end type

event clicked;int anticipo_int
int anyo_int,opci,cuantos

long   ll_indice,ll_total,ll_anyo_efecto,ll_orden_efecto
string ls_sel
datastore ds_efectos

anticipo_int = integer(em_anticipo.text)
anyo_int = integer(em_anyo.text)

select count(*) into :cuantos
from carfinan
where (carfinan.empresa = :codigo_empresa)		and
		(carfinan.bancofinan = :em_banco.text)		and
		(carfinan.contador = :anticipo_int)			and
		(carfinan.num_prorroga = 0)					and
		(carfinan.anyo = :anyo_int)					and
		(carfinan.situacion < 2);

if cuantos = 0 then 
	cb_retroceder.enabled = false
	tab_datos.pagina1.dw_1.reset()
	tab_datos.pagina2.dw_2.reset()
	em_anticipo.text = ""
	uo_cliente.em_campo.text ="" 
	uo_cliente.em_codigo.text = ""
	em_anticipo.setfocus()
	f_activa()

	return
end if


opci = messagebox("¡¡ ATENCIÓN !!","¿ Desea anular el anticipo seleccionado ?",question!,yesno!,2)

if opci = 1 then
	
	
	// Borramos el anticipo

 	//PRIMERO CAMBIAMOS LA SITUACION DE LOS EFECTOS DE LA 8 A LA 0	
	//CURSOR PARA CARGAR LOS EFECTOS DE CARFINANEFE
	ls_sel = "select carfinanefe.ejercicio, "+&
				"       carfinanefe.orden "+&
				"from   carfinanefe "+&
				"where  carfinanefe.empresa    = '"+codigo_empresa+"' "+&
				"and    carfinanefe.bancofinan = '"+em_banco.text+"' "+&
				"and    carfinanefe.anyo       = "+string(anyo_int,"###0")+" "+&
				"and    carfinanefe.contador   = "+string(anticipo_int,"###0")+" "
				
	ll_total = f_cargar_cursor_transaccion(sqlca,ds_efectos,ls_sel)
	
	for ll_indice = 1 to ll_total
		ll_anyo_efecto  = ds_efectos.object.ejercicio[ll_indice]
		ll_orden_efecto = ds_efectos.object.orden[ll_indice]
		
		UPDATE carefectos
		set   situacion = "0", 
				banco     =  ""
		where carefectos.empresa 	=  :codigo_empresa
		and	carefectos.anyo		=	:ll_anyo_efecto
		and	carefectos.orden		=	:ll_orden_efecto
		and   carefectos.situacion = "8";		
	next
	
	destroy ds_efectos
	
	
	DELETE CARFINAN
	where (empresa = :codigo_empresa)		and
			(bancofinan = :em_banco.text)		and
			(contador = :anticipo_int)			and
			(num_prorroga = 0)	and
			(anyo = :anyo_int);
	
	
	DELETE CARFINANEFE
	where (empresa = :codigo_empresa)		and
			(bancofinan = :em_banco.text)		and
			(contador = :anticipo_int)			and			
			(anyo = :anyo_int);
	
	commit;
	
	
	cb_retroceder.enabled = false
	tab_datos.pagina1.dw_1.reset()
	tab_datos.pagina2.dw_2.reset()
	em_anticipo.text = ""
	uo_cliente.em_campo.text ="" 
	uo_cliente.em_codigo.text = ""
	f_activa()
	em_anticipo.setfocus()
end if
	

end event

