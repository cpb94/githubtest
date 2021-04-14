$PBExportHeader$w_input_gastos_anticipos.srw
forward
global type w_input_gastos_anticipos from window
end type
type em_importe_gastos from editmask within w_input_gastos_anticipos
end type
type st_78 from statictext within w_input_gastos_anticipos
end type
type em_importe_rem from editmask within w_input_gastos_anticipos
end type
type st_77 from statictext within w_input_gastos_anticipos
end type
type uo_gasto from u_em_campo_2 within w_input_gastos_anticipos
end type
type em_moneda_interes from u_em_campo within w_input_gastos_anticipos
end type
type em_cta_interes from u_em_campo within w_input_gastos_anticipos
end type
type em_gasto_interes from editmask within w_input_gastos_anticipos
end type
type em_interes_minim from editmask within w_input_gastos_anticipos
end type
type st_8 from statictext within w_input_gastos_anticipos
end type
type st_23 from statictext within w_input_gastos_anticipos
end type
type st_22 from statictext within w_input_gastos_anticipos
end type
type st_21 from statictext within w_input_gastos_anticipos
end type
type st_20 from statictext within w_input_gastos_anticipos
end type
type st_4 from statictext within w_input_gastos_anticipos
end type
type st_3 from statictext within w_input_gastos_anticipos
end type
type sle_gasto from editmask within w_input_gastos_anticipos
end type
type em_cuenta from u_em_campo within w_input_gastos_anticipos
end type
type em_moneda from u_em_campo within w_input_gastos_anticipos
end type
type st_7 from statictext within w_input_gastos_anticipos
end type
type st_6 from statictext within w_input_gastos_anticipos
end type
type st_5 from statictext within w_input_gastos_anticipos
end type
type st_2 from statictext within w_input_gastos_anticipos
end type
type cb_3 from commandbutton within w_input_gastos_anticipos
end type
type cb_insertar from commandbutton within w_input_gastos_anticipos
end type
type em_apunte_banco from editmask within w_input_gastos_anticipos
end type
type st_1 from statictext within w_input_gastos_anticipos
end type
type dw_2 from datawindow within w_input_gastos_anticipos
end type
type cb_2 from commandbutton within w_input_gastos_anticipos
end type
type cb_1 from commandbutton within w_input_gastos_anticipos
end type
type gb_2 from groupbox within w_input_gastos_anticipos
end type
type gb_1 from groupbox within w_input_gastos_anticipos
end type
end forward

global type w_input_gastos_anticipos from window
integer x = 306
integer y = 380
integer width = 2432
integer height = 1352
boolean titlebar = true
string title = "INTRODUCCIÓN DE DATOS "
windowtype windowtype = response!
long backcolor = 12632256
em_importe_gastos em_importe_gastos
st_78 st_78
em_importe_rem em_importe_rem
st_77 st_77
uo_gasto uo_gasto
em_moneda_interes em_moneda_interes
em_cta_interes em_cta_interes
em_gasto_interes em_gasto_interes
em_interes_minim em_interes_minim
st_8 st_8
st_23 st_23
st_22 st_22
st_21 st_21
st_20 st_20
st_4 st_4
st_3 st_3
sle_gasto sle_gasto
em_cuenta em_cuenta
em_moneda em_moneda
st_7 st_7
st_6 st_6
st_5 st_5
st_2 st_2
cb_3 cb_3
cb_insertar cb_insertar
em_apunte_banco em_apunte_banco
st_1 st_1
dw_2 dw_2
cb_2 cb_2
cb_1 cb_1
gb_2 gb_2
gb_1 gb_1
end type
global w_input_gastos_anticipos w_input_gastos_anticipos

type variables
integer inst_anyo
integer inst_anticipo,inst_prorroga
string inst_banco
string inst_abono_liq_teo
datetime inst_fecha_liquidacion
integer inst_situacion
integer inst_num_liquidacion
end variables

forward prototypes
public function decimal f_calculo_timbres (string codigo, decimal nominal)
public subroutine f_calculo_total_gastos ()
public function integer f_maxima_liquidacion (string par_empresa, integer par_anyo, string par_banco, integer par_contador, integer par_prorroga)
public function integer f_maximo_abono (string par_empresa, integer par_anyo, string par_banco, integer par_contador, integer par_prorroga)
end prototypes

public function decimal f_calculo_timbres (string codigo, decimal nominal);
Dec{2}	top1,top2,top3,top4,top5,top6,top7,top8,top9,top10,top11,top12,top13,top14,top15
Dec{2}	tim1,tim2,tim3,tim4,tim5,tim6,tim7,tim8,tim9,tim10,tim11,tim12,tim13,tim14,tim15
Dec{2}	imptim

SELECT cartimbres.tope1,cartimbres.tope2,cartimbres.tope3,
		 cartimbres.tope4,cartimbres.tope5,cartimbres.tope6,
		 cartimbres.tope7,cartimbres.tope8,cartimbres.tope9,
		 cartimbres.tope10,cartimbres.tope11,cartimbres.tope12,
		 cartimbres.tope13,cartimbres.tope14,cartimbres.tope15,
		 cartimbres.timbre1,cartimbres.timbre2,cartimbres.timbre3,
		 cartimbres.timbre4,cartimbres.timbre5,cartimbres.timbre6,
		 cartimbres.timbre7,cartimbres.timbre8,cartimbres.timbre9,
		 cartimbres.timbre10,cartimbres.timbre11,cartimbres.timbre12,
		 cartimbres.timbre13,cartimbres.timbre14,cartimbres.timbre15
	INTO :top1,:top2,:top3,:top4,:top5,:top6,:top7,:top8,:top9,:top10,
		  :top11,:top12,:top13,:top14,:top15,
		  :tim1,:tim2,:tim3,:tim4,:tim5,:tim6,:tim7,:tim8,:tim9,:tim10,
		  :tim11,:tim12,:tim13,:tim14,:tim15	FROM cartimbres
WHERE cartimbres.codigo = :codigo USING SQLCA;

IF SQLCA.SQLCode <> 0 THEN
	RETURN 0
END IF

CHOOSE CASE nominal
	CASE is <= top1 
		imptim = tim1
	CASE top1+1 TO top2
		imptim = tim2
	CASE top2+1 TO top3
		imptim = tim3	
	CASE top3+1 TO top4
		imptim = tim4
	CASE top4+1 TO top5
		imptim = tim5
	CASE top5+1 TO top6
		imptim = tim6
	CASE top6+1 TO top7
		imptim = tim7
	CASE top7+1 TO top8
		imptim = tim8
	CASE top8+1 TO top9
		imptim = tim9
	CASE top9+1 TO top10
		imptim = tim10
	CASE top10+1 TO top11
		imptim = tim11
	CASE top11+1 TO top12
		imptim = tim12
	CASE top12+1 TO top13
		imptim = tim13
	CASE top13+1 TO top14
		imptim = tim14
	CASE IS > top14+1 
		imptim = tim15
	CASE ELSE
		imptim = 0
END CHOOSE

IF IsNull(imptim) THEN imptim = 0

RETURN imptim
end function

public subroutine f_calculo_total_gastos ();Int	i
Dec{2}	totgas

totgas = 0

FOR i = 1 To dw_2.RowCount()
	totgas = totgas + dw_2.GetItemNumber(i,"gastos")
NEXT

totgas = totgas + Dec(em_gasto_interes.text)

em_importe_gastos.text = String(totgas)


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

public function integer f_maximo_abono (string par_empresa, integer par_anyo, string par_banco, integer par_contador, integer par_prorroga);int maxim

select max(liquidacion) into :maxim
from carfinangas
where (carfinangas.empresa = :par_empresa)		and
		(carfinangas.anyo = :par_anyo)				and
		(carfinangas.bancofinan = :par_banco)		and
		(carfinangas.contador = :par_contador)		and
		(carfinangas.aboliqteo = "A")					and
		(carfinangas.num_prorroga = :par_prorroga);
if isnull(maxim) then maxim = 0

return maxim
end function

on w_input_gastos_anticipos.create
this.em_importe_gastos=create em_importe_gastos
this.st_78=create st_78
this.em_importe_rem=create em_importe_rem
this.st_77=create st_77
this.uo_gasto=create uo_gasto
this.em_moneda_interes=create em_moneda_interes
this.em_cta_interes=create em_cta_interes
this.em_gasto_interes=create em_gasto_interes
this.em_interes_minim=create em_interes_minim
this.st_8=create st_8
this.st_23=create st_23
this.st_22=create st_22
this.st_21=create st_21
this.st_20=create st_20
this.st_4=create st_4
this.st_3=create st_3
this.sle_gasto=create sle_gasto
this.em_cuenta=create em_cuenta
this.em_moneda=create em_moneda
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_2=create st_2
this.cb_3=create cb_3
this.cb_insertar=create cb_insertar
this.em_apunte_banco=create em_apunte_banco
this.st_1=create st_1
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.em_importe_gastos,&
this.st_78,&
this.em_importe_rem,&
this.st_77,&
this.uo_gasto,&
this.em_moneda_interes,&
this.em_cta_interes,&
this.em_gasto_interes,&
this.em_interes_minim,&
this.st_8,&
this.st_23,&
this.st_22,&
this.st_21,&
this.st_20,&
this.st_4,&
this.st_3,&
this.sle_gasto,&
this.em_cuenta,&
this.em_moneda,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_2,&
this.cb_3,&
this.cb_insertar,&
this.em_apunte_banco,&
this.st_1,&
this.dw_2,&
this.cb_2,&
this.cb_1,&
this.gb_2,&
this.gb_1}
end on

on w_input_gastos_anticipos.destroy
destroy(this.em_importe_gastos)
destroy(this.st_78)
destroy(this.em_importe_rem)
destroy(this.st_77)
destroy(this.uo_gasto)
destroy(this.em_moneda_interes)
destroy(this.em_cta_interes)
destroy(this.em_gasto_interes)
destroy(this.em_interes_minim)
destroy(this.st_8)
destroy(this.st_23)
destroy(this.st_22)
destroy(this.st_21)
destroy(this.st_20)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.sle_gasto)
destroy(this.em_cuenta)
destroy(this.em_moneda)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_2)
destroy(this.cb_3)
destroy(this.cb_insertar)
destroy(this.em_apunte_banco)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;
// Para mostrar los gastos y obtener el total
dw_2.settransobject(sqlca)		

// Estructura para pasar datos 
str_input_gastos_anticipos datos_gastos
datos_gastos = Message.powerobjectparm


// En la variable instancia inst_anyo el año 
inst_anyo = datos_gastos.anyo
inst_banco = datos_gastos.banco
inst_anticipo = datos_gastos.contador
inst_prorroga = datos_gastos.prorroga
inst_abono_liq_teo = datos_gastos.abono_liq_teo
inst_fecha_liquidacion = datos_gastos.fecha_liquidacion
inst_situacion = datos_gastos.situacion
inst_num_liquidacion = datos_gastos.num_liquidacion


// En dw_2 los gastos 
dw_2.retrieve(codigo_empresa,datos_gastos.banco,datos_gastos.tipodoc,datos_gastos.naci_extra)


int i
dec {2} nominal,interes

dec{2} porcent,import,gasto,gasto_general = 0
 

STRING cod_gasto
// Para cada gasto
for i = 1 to dw_2.rowcount()
	
	cod_gasto = dw_2.getitemstring(i,"gasto")
	porcent 	 = dw_2.getitemnumber(i,"porcentaje")
	import 	 = dw_2.getitemnumber(i,"importe")
		
	// El gasto 12 (timbres). El codigo de importe es la clave en "CARTIMBRES" 
	if cod_gasto = "12" then		
		gasto = f_calculo_timbres(string(integer(import)),datos_gastos.importe) 
				
	// Otros gastos	
	else
		gasto = datos_gastos.importe * porcent / 100
		if gasto < import then gasto = import		
	end if	
	
				
	dw_2.setitem(i,"gastos",gasto)
	gasto_general = gasto_general + gasto
next


// Cálculo de los intereses para el total del anticipo
interes = f_calculo_intereses(datos_gastos.banco,datos_gastos.tipodoc,datos_gastos.importe,datos_gastos.vencimiento,datos_gastos.fecha_abono,datos_gastos.naci_extra)


// *******************************************************************+
// 	PONER DATOS
// *********************************************************************

// Ponemos el total intereses calculados en dw_4 en campo intereses

IF interes > 0 THEN
	em_gasto_interes.text = string(interes)
	
	DEC{2} int_minim
	SELECT carbangas.cta_interes,carbangas.interesminim 
			INTO :em_cta_interes.text,:int_minim FROM carbangas
	WHERE carbangas.empresa = :codigo_empresa
	and   carbangas.banco = :inst_banco
	AND	carbangas.tipodoc = :datos_gastos.tipodoc
	AND	carbangas.naciextra	= :datos_gastos.naci_extra USING SQLCA;
	
	if isnull(int_minim) then int_minim = 0
	em_interes_minim.text = string(integer(int_minim))
	
ELSE
	em_gasto_interes.text = '0'
	em_cta_interes.text	 = ""
	em_interes_minim.text = ""
END IF




// Ponemos por defecto el total del anticipo y el apunte al banco

em_importe_gastos.text = string(gasto_general + interes) 
em_importe_rem.text = string(datos_gastos.importe)
em_apunte_banco.text =  string(datos_gastos.importe)

// Si es un abono y se están añadiendo gastos no mostramos el apunte al banco

if inst_abono_liq_teo = "A" and (inst_situacion = 2 or inst_situacion = 3) then
	
	st_1.visible = false
	em_apunte_banco.visible = false

end if


// Si es liquidación y se están añadiendo gastos no mostramos el apunte al banco

if inst_abono_liq_teo = "L" and inst_situacion = 4 then
	
	st_1.visible = false
	em_apunte_banco.visible = false

end if

// Si es una prórroga no mostramos el apunte al banco
if datos_gastos.es_prorroga = "S" then 
	st_1.visible = false
	em_apunte_banco.visible = false
end if
end event

type em_importe_gastos from editmask within w_input_gastos_anticipos
integer x = 978
integer y = 1036
integer width = 558
integer height = 88
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,###,###.00"
end type

type st_78 from statictext within w_input_gastos_anticipos
integer x = 279
integer y = 1052
integer width = 690
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Total Gastos:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_importe_rem from editmask within w_input_gastos_anticipos
integer x = 978
integer y = 936
integer width = 558
integer height = 88
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,###,###.00"
end type

type st_77 from statictext within w_input_gastos_anticipos
integer x = 279
integer y = 940
integer width = 690
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Total Anticipo :"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_gasto from u_em_campo_2 within w_input_gastos_anticipos
event destroy ( )
integer x = 55
integer y = 784
integer width = 434
integer height = 72
integer taborder = 70
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

on uo_gasto.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_gasto.em_campo.text=f_nombre_cargastos(codigo_empresa,uo_gasto.em_codigo.text)
If Trim(uo_gasto.em_campo.text)="" Then
	If Trim(uo_gasto.em_codigo.text)<>"" then uo_gasto.em_campo.SetFocus()
	uo_gasto.em_campo.text=""
	uo_gasto.em_codigo.text=""
end if
end event

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_cargastos"
ue_titulo     =  "AYUDA SELECCION DE TIPOS DE GASTOS"
ue_filtro     =  ""
valor_empresa = true
end event

type em_moneda_interes from u_em_campo within w_input_gastos_anticipos
event getfocus pbm_ensetfocus
integer x = 1531
integer y = 80
integer width = 320
integer height = 72
integer taborder = 50
long backcolor = 16777215
boolean border = false
alignment alignment = right!
borderstyle borderstyle = stylebox!
end type

event getfocus;call super::getfocus;ue_titulo ="AYUDA SELECCION DE MONEDAS"
ue_datawindow ="dw_ayuda_divisas"
ue_filtro =""

valor_empresa = false
end event

type em_cta_interes from u_em_campo within w_input_gastos_anticipos
event getfocus pbm_ensetfocus
integer x = 1065
integer y = 80
integer width = 453
integer height = 72
integer taborder = 40
long backcolor = 16777215
boolean border = false
alignment alignment = right!
borderstyle borderstyle = stylebox!
end type

event getfocus;call super::getfocus;ue_titulo ="AYUDA DE CUENTAS CONTABLES"
ue_datawindow ="dw_ayuda_contaplan_directo"
valor_empresa = true
ue_filtro = "ejercicio = " + String(inst_anyo)
end event

type em_gasto_interes from editmask within w_input_gastos_anticipos
integer x = 1865
integer y = 80
integer width = 366
integer height = 72
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean border = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,###.00"
end type

event modified;f_calculo_total_gastos()	
end event

event losefocus;f_calculo_total_gastos()	
end event

type em_interes_minim from editmask within w_input_gastos_anticipos
integer x = 718
integer y = 84
integer width = 338
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean border = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

type st_8 from statictext within w_input_gastos_anticipos
integer x = 73
integer y = 80
integer width = 389
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
boolean enabled = false
string text = "INTERESES"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_23 from statictext within w_input_gastos_anticipos
integer x = 1861
integer y = 4
integer width = 379
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
string text = "Total Gasto"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_22 from statictext within w_input_gastos_anticipos
integer x = 1518
integer y = 4
integer width = 343
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
string text = "Moneda"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_21 from statictext within w_input_gastos_anticipos
integer x = 1065
integer y = 4
integer width = 453
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
string text = "Cuenta"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_20 from statictext within w_input_gastos_anticipos
integer x = 718
integer y = 4
integer width = 347
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
string text = "Importe"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_4 from statictext within w_input_gastos_anticipos
integer x = 485
integer y = 4
integer width = 233
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
string text = "%"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_3 from statictext within w_input_gastos_anticipos
integer x = 69
integer y = 4
integer width = 416
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
string text = "Gasto"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type sle_gasto from editmask within w_input_gastos_anticipos
integer x = 1317
integer y = 788
integer width = 375
integer height = 72
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,###,##0.00"
end type

type em_cuenta from u_em_campo within w_input_gastos_anticipos
integer x = 494
integer y = 788
integer width = 448
integer height = 72
integer taborder = 80
long backcolor = 16777215
alignment alignment = right!
end type

event getfocus;call super::getfocus;ue_titulo ="AYUDA DE CUENTAS CONTABLES"
ue_datawindow ="dw_ayuda_contaplan_directo"
ue_filtro      = "ejercicio = " + String(inst_anyo)

valor_empresa = true
end event

type em_moneda from u_em_campo within w_input_gastos_anticipos
integer x = 942
integer y = 788
integer width = 375
integer height = 72
integer taborder = 90
long backcolor = 16777215
alignment alignment = right!
end type

event getfocus;call super::getfocus;ue_titulo ="AYUDA SELECCION DE MONEDAS"
ue_datawindow ="dw_ayuda_divisas"
ue_filtro =""

valor_empresa = false
end event

type st_7 from statictext within w_input_gastos_anticipos
integer x = 1317
integer y = 728
integer width = 375
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
string text = "Total Gasto"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_6 from statictext within w_input_gastos_anticipos
integer x = 942
integer y = 728
integer width = 375
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
string text = "Moneda"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_5 from statictext within w_input_gastos_anticipos
integer x = 494
integer y = 728
integer width = 448
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
string text = "Cuenta"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_input_gastos_anticipos
integer x = 55
integer y = 728
integer width = 439
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
string text = "Gasto"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_input_gastos_anticipos
integer x = 2048
integer y = 740
integer width = 320
integer height = 108
integer taborder = 120
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar"
end type

event clicked;string nombre_gasto
int fila,eleccion

fila = dw_2.getrow()
nombre_gasto = dw_2.getitemstring(fila,"nom_gasto")
eleccion = messagebox("Atención"," ¿ Desea borrar el gasto "+ nombre_gasto + " ?",question!,yesno!,1)

if eleccion = 1 then
	dw_2.deleterow(fila)

	uo_gasto.em_codigo.text = ""
	uo_gasto.em_campo.text = ""
	em_cuenta.text = ""
	em_moneda.text = ""
	sle_gasto.text = ""
end if
f_calculo_total_gastos()	

end event

type cb_insertar from commandbutton within w_input_gastos_anticipos
integer x = 1723
integer y = 740
integer width = 320
integer height = 108
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Insertar"
end type

event clicked;int 		fila,i,cuantas
Boolean	esta

// Control de datos

if uo_gasto.em_codigo.text = "" or em_cuenta.text = "" or  &
	em_moneda.text = "" or sle_gasto.text = "" then
	
	messagebox("Atención","Debe rellenar los datos antes de insertar un nuevo gasto")
	return
end if
IF Not f_existe_cuenta(inst_anyo,codigo_empresa,em_cuenta.text) THEN
	MessageBox("ERROR EN CUENTA","No existe la cuenta contable",Exclamation!)
	f_activar_campo(em_cuenta)
	RETURN
END IF

// Control para ver si ese gasto ya existe. En caso afirmativo se modifica
// con lo nuevo

esta = FALSE

FOR i = 1 TO dw_2.RowCount()
	IF dw_2.GetItemString(i,"gasto") = uo_gasto.em_codigo.text THEN
		esta = TRUE
		fila = i
	END IF
NEXT 

// linea nueva
IF Not esta THEN
	fila = dw_2.insertrow(0)
	dw_2.setrow(fila)
END IF

dw_2.setitem(fila,"gasto",uo_gasto.em_codigo.text)
dw_2.setitem(fila,"cuenta",em_cuenta.text)
dw_2.setitem(fila,"moneda",em_moneda.text)
dw_2.setitem(fila,"gastos",dec(sle_gasto.text))

dw_2.sort()


uo_gasto.em_codigo.text = ""
uo_gasto.em_campo.text = ""
em_cuenta.text = ""
em_moneda.text = ""
sle_gasto.text = ""
f_calculo_total_gastos()
end event

type em_apunte_banco from editmask within w_input_gastos_anticipos
integer x = 978
integer y = 1140
integer width = 558
integer height = 88
integer taborder = 10
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
string mask = "###,###,###,###.00"
end type

type st_1 from statictext within w_input_gastos_anticipos
integer x = 279
integer y = 1152
integer width = 690
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Apunte al Banco :"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_input_gastos_anticipos
integer x = 50
integer y = 160
integer width = 2304
integer height = 504
string dataobject = "dw_calc_gastos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;CHOOSE CASE f_objeto_datawindow(This)
		
	case "nom_gasto","cuenta","nom_moneda","gastos","importe","porcentaje"
		
		uo_gasto.em_codigo.text = dw_2.getitemstring(row,"gasto")
		uo_gasto.em_campo.text=f_nombre_cargastos(codigo_empresa,uo_gasto.em_codigo.text)
		em_cuenta.text = dw_2.getitemstring(row,"cuenta")
		em_moneda.text = dw_2.getitemstring(row,"moneda")
		sle_gasto.text = string(dw_2.getitemnumber(row,"gastos"))
		
		dw_2.setrow(row)
		dw_2.setcolumn("gastos")
end choose
end event

event itemchanged;Int	i
Dec{0}	totgas,gas


choose case dwo.name

case "gastos"
	
	totgas = 0

	FOR i = 1 To dw_2.RowCount()
		
		if i = row then
			gas = dec(data)	
		else
			gas = dw_2.GetItemNumber(i,"gastos")
		end if
		
		totgas = totgas + gas 
	NEXT

	totgas = totgas + Dec(em_gasto_interes.text)

	em_importe_gastos.text = String(totgas)
	
	
end choose
end event

type cb_2 from commandbutton within w_input_gastos_anticipos
integer x = 2053
integer y = 1116
integer width = 320
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancelar"
end type

event clicked;// si se cancela devolvemos false en el campo correcto

str_input_gastos_anticipos datos_salida
	
datos_salida.correcto = false	
	
closewithreturn(parent,datos_salida)
end event

type cb_1 from commandbutton within w_input_gastos_anticipos
integer x = 2053
integer y = 948
integer width = 320
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Aceptar"
end type

event clicked;int i
string cuenta_anterior,cuenta
dec{2} gasto,gasto_acumulado

int num_cuentas

// Si es una liquidación se puede escribir en apunte al banco
// el total del anticipo o el total + gastos
if inst_abono_liq_teo = "L" then 
	IF Dec(em_apunte_banco.text) <> Dec(em_importe_rem.text) THEN
		IF Dec(em_importe_rem.text) + Dec(em_importe_gastos.text) <> Dec(em_apunte_banco.text) THEN
			MessageBox("ERROR EN IMPORTES","El apunte al banco no coincide con anticipo + gastos",Exclamation!)
			f_activar_campo(em_apunte_banco)
			RETURN
		END IF
	END IF


// Si no es una liquidación se puede escribir en apunte al banco
// el total del anticipo o el total - gastos
else
	// importe anticipo - gastos = apunte al banco
	IF Dec(em_apunte_banco.text) <> Dec(em_importe_rem.text) THEN
		IF Dec(em_importe_rem.text) - Dec(em_importe_gastos.text) <> Dec(em_apunte_banco.text) THEN
			MessageBox("ERROR EN IMPORTES","El apunte al banco no coincide con anticipo - gastos",Exclamation!)
			f_activar_campo(em_apunte_banco)
			RETURN
		END IF
	END IF

end if


dw_2.accepttext()

// Estructura datos de salida
str_input_gastos_anticipos datos_salida


gasto_acumulado = 0
num_cuentas = 0

// Obtenemos el total de gastos por cuenta contable
if dw_2.rowcount() > 0 then
	// nº de cuentas distintas que vamos encontrando
	// Cálculo del total de los gastos para cada cuenta contable
	// Recorremos la dw_2 ordenada por cuentas sumando los gastos
	// para una cuenta
	for i = 1 to dw_2.rowcount()
		IF i = 1 THEN
			num_cuentas = 1
			cuenta_anterior = dw_2.getitemstring(1,"cuenta")
		END IF
		cuenta = dw_2.getitemstring(i,"cuenta")
		IF Not f_existe_cuenta(inst_anyo,codigo_empresa,cuenta) THEN
			MessageBox("ERROR EN CUENTA CONTABLE","La cuenta "+Trim(cuenta)+ " no existe",Exclamation!)
			datos_salida.correcto = false	
			closewithreturn(parent,datos_salida)
			RETURN
		END IF
		gasto = dw_2.getitemnumber(i,"gastos")
		
		if cuenta = cuenta_anterior then
			gasto_acumulado = gasto_acumulado + gasto
		else
			datos_salida.gastos[num_cuentas]= gasto_acumulado
			datos_salida.cuentas[num_cuentas]=cuenta_anterior
			num_cuentas = num_cuentas +1
			gasto_acumulado = gasto
															
		end if
		cuenta_anterior = cuenta
		
	next
	// falta añadir la última fila de la dw_2
	datos_salida.gastos[num_cuentas]= gasto_acumulado
	datos_salida.cuentas[num_cuentas]=cuenta


end if

//*****************************************************************
// Datos de salida
//*****************************************************************	

datos_salida.num_gastos = num_cuentas
datos_salida.importe = dec(em_importe_rem.text)

IF em_gasto_interes.text = "" then em_gasto_interes.text = "0"	
datos_salida.intereses = Dec(em_gasto_interes.text)
datos_salida.cta_intereses = em_cta_interes.text
IF Not f_existe_cuenta(inst_anyo,codigo_empresa,datos_salida.cta_intereses) THEN
		MessageBox("ERROR EN CUENTA CONTABLE","La cuenta "+Trim(datos_salida.cta_intereses)+ " no existe",Exclamation!)
		datos_salida.correcto = false	
		closewithreturn(parent,datos_salida)
		RETURN
	END IF
datos_salida.importe_salida = dec(em_apunte_banco.text)	

// Calculamos el total de los gastos
dec{2} total_gastos
total_gastos = 0
for i = 1 to num_cuentas 
	total_gastos = total_gastos + datos_salida.gastos[i]
next
// añadimos también los intereses
total_gastos = total_gastos + datos_salida.intereses	
datos_salida.total_gastos = total_gastos


// *********************************************************************
// INSERTAR GASTOS EN CARFINANGAS
// *********************************************************************	
int bien
str_carfinangas gasto_carfinan

// datos comunes a todos los gastos
gasto_carfinan.empresa = codigo_empresa
gasto_carfinan.anyo = inst_anyo
gasto_carfinan.bancofinan = inst_banco
gasto_carfinan.contador = inst_anticipo
gasto_carfinan.num_prorroga = inst_prorroga
// puede ser abono o liquidación (A ó L)
gasto_carfinan.aboliqteo = inst_abono_liq_teo

// si es liquidación obtenemos la última
if inst_abono_liq_teo = "L" then
	gasto_carfinan.liquidacion = inst_num_liquidacion
end if

//  si es abono, obtenemos el máximo	
int num_abono
if inst_abono_liq_teo = "A" then
	num_abono = f_maximo_abono(codigo_empresa,inst_anyo,inst_banco,inst_anticipo,inst_prorroga)
	gasto_carfinan.liquidacion = num_abono +1
	
end if



if datos_salida.intereses <> 0 then
	
	// insertamos el gasto de los intereses
	gasto_carfinan.codgas = "999" // codigo 999 para los intereses 
	setnull(gasto_carfinan.porcentaje)
	gasto_carfinan.importe_min = dec(em_interes_minim.text)
	setnull(gasto_carfinan.cambio)
	setnull(gasto_carfinan.divisas)
	gasto_carfinan.importe = datos_salida.intereses
	gasto_carfinan.moneda = em_moneda_interes.text
	gasto_carfinan.cuenta = em_cta_interes.text
	if not f_insert_carfinangas(gasto_carfinan) then bien = 1 

end if


// insertamos cada uno de los demás gastos en carfinangas
dec{2} el_gasto			
int k
for k = 1 to dw_2.rowcount()
	el_gasto = dw_2.getitemnumber(k,"gastos")
	if isnull(el_gasto) then el_gasto = 0
	if el_gasto > 0 then
		gasto_carfinan.codgas = dw_2.getitemstring(k,"gasto")
		gasto_carfinan.porcentaje = dw_2.getitemnumber(k,"porcentaje")
		gasto_carfinan.importe_min = dw_2.getitemnumber(k,"importe")
		setnull(gasto_carfinan.cambio)
		setnull(gasto_carfinan.divisas)
		gasto_carfinan.importe = el_gasto
		gasto_carfinan.moneda = dw_2.getitemstring(k,"moneda")
		gasto_carfinan.cuenta = dw_2.getitemstring(k,"cuenta")
		if not f_insert_carfinangas(gasto_carfinan) then bien = 1
	end if				

NEXT



// todo correcto
if bien = 1 then
	datos_salida.correcto = false
else
	datos_salida.correcto = true
end if


// cerramos la ventana y enviamos los datos
closewithreturn(parent,datos_salida)

end event

type gb_2 from groupbox within w_input_gastos_anticipos
integer y = 884
integer width = 2400
integer height = 364
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_1 from groupbox within w_input_gastos_anticipos
integer y = 668
integer width = 2400
integer height = 204
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Inserción / Borrado de Gastos"
end type

