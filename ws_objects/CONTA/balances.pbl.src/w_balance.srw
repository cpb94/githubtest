$PBExportHeader$w_balance.srw
forward
global type w_balance from w_int_con_empresa
end type
type pb_2 from upb_salir within w_balance
end type
type em_fechadesde from u_em_campo within w_balance
end type
type gb_22 from groupbox within w_balance
end type
type gb_1 from groupbox within w_balance
end type
type cb_consulta from u_boton within w_balance
end type
type em_fechahasta from u_em_campo within w_balance
end type
type st_1 from statictext within w_balance
end type
type gb_2 from groupbox within w_balance
end type
type pb_imprimir_preli from picturebutton within w_balance
end type
type uo_1 from u_manejo_datawindow within w_balance
end type
type dw_1 from datawindow within w_balance
end type
type dw_cursord from datawindow within w_balance
end type
type dw_cursorh from datawindow within w_balance
end type
type cb_1 from commandbutton within w_balance
end type
type dw_listado from datawindow within w_balance
end type
type uo_balance from u_em_campo_2 within w_balance
end type
type cbx_resumen from checkbox within w_balance
end type
end forward

global type w_balance from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3598
integer height = 2272
string title = "Consulta de Movimientos"
pb_2 pb_2
em_fechadesde em_fechadesde
gb_22 gb_22
gb_1 gb_1
cb_consulta cb_consulta
em_fechahasta em_fechahasta
st_1 st_1
gb_2 gb_2
pb_imprimir_preli pb_imprimir_preli
uo_1 uo_1
dw_1 dw_1
dw_cursord dw_cursord
dw_cursorh dw_cursorh
cb_1 cb_1
dw_listado dw_listado
uo_balance uo_balance
cbx_resumen cbx_resumen
end type
global w_balance w_balance

type variables
integer anyo

end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
public function decimal f_saldo_formula (datawindow dw, string formu, long donde)
public function decimal f_saldo_formula_ant (datawindow dw, string formu, long donde)
end prototypes

public subroutine f_cargar (datawindow dw_data);long registros,i,j,anyoant
datetime fdesde,fhasta,fdesdeant,fhastaant
String cuenta,cuenta2,formula,bloque,bloque2
dec{2} saldo,defecto,saldoant
int k

dw_data.SetTransObject(sqlca)
dw_data.reset()
Setpointer(HourGlass!)
dw_data.setfilter("")
dw_data.setredraw(false)

fdesde=datetime(date(em_fechadesde.text))
fhasta=datetime(date(em_fechahasta.text))
fdesdeant=datetime(date("01/01/"+string(year(date(em_fechadesde.text))-1,"####")))
fhastaant=datetime(date("31/12/"+string(year(date(em_fechadesde.text))-1,"####")))
anyoant  = year(date(em_fechadesde.text))-1

registros=dw_data.retrieve(codigo_empresa,fdesde,fhasta,uo_balance.em_codigo.text,anyo,anyoant)

If registros = 0 Then 
	dw_data.setredraw(true)
	Return
end if

for i=1 to registros
	f_mensaje_proceso("Cargando datos",i,registros)
	cuenta=dw_data.getitemstring(i,"contaballin_cuenta")
	// saldo por defecto de la cuenta
	defecto=dw_data.getitemnumber(i,"contaballin_importe")
	
	if isnull(defecto) or defecto=0 then
		// Cálculo del saldo de la cuenta si no tiene saldo defecto
		saldo    = f_saldo_cuenta_balance(anyo,codigo_empresa,cuenta,fdesde,fhasta)
		saldoant = f_saldo_cuenta_balance(anyoant,codigo_empresa,cuenta,fdesdeant,fhastaant)
		
		bloque   = dw_data.getitemstring(i,"contabalgrup_bloque")
		
		// Comprobamos si la cuenta está dos veces en el balance
		// No puede estar dos veces en el mismo bloque
		// Puede estar en dos bloques diferentes pero sólo ha de aparecer en uno 
		for k = i +1 to registros
			cuenta2 = dw_data.getitemstring(k,"contaballin_cuenta")
			if cuenta2 = cuenta then
				bloque2 = dw_data.getitemstring(k,"contabalgrup_bloque")
				if bloque = bloque2 then
					messagebox("Error","La cuenta " + cuenta2 +" está repetida en el bloque "+ bloque2)
				else
					if bloque = "D" and saldo < 0 then
						saldo = 0
						saldoant = 0
					else
						if bloque = "H" and saldo > 0 then
							saldo = 0
							saldoant = 0
						end if
					end if
				end if
			end if
		next
		// Si es del haber el saldo es negativo. Se pasa a positivo
		if bloque = "H" then 
			if cuenta <> "129" then
				saldo    = saldo * (-1)
				saldoant = saldoant * (-1)
			end if
		end if
		
	else
		// Saldo por defecto en el la tabla de lineas
		saldo = defecto
	end if
	
	dw_data.setitem(i,"saldo",saldo)
	dw_data.setitem(i,"saldoant",saldoant)
	
next

dw_data.sort()
dw_data.groupcalc()

// Cálculo del saldo de los grupos que tienen fórmula
long cd,ch,cc,n
cd=dw_cursord.retrieve(codigo_empresa,uo_balance.em_codigo.text,'D')
ch=dw_cursorh.retrieve(codigo_empresa,uo_balance.em_codigo.text,'H')
cc=max(cd,ch)
string grupod,grupoh
for i=1 to cc
	f_mensaje_proceso("Calculando datos",i,cc)
	if i<=cd then
		grupod=dw_cursord.getitemstring(i,"grupo")
		dw_data.setfilter("contabalgrup_grupo='"+grupod+"'")
		dw_data.filter()
		for j=1 to dw_data.rowcount()
			formula=dw_data.getitemstring(j,"contabalgrup_formula")
			if formula<>"" and not isnull(formula) then
				if j=1 then 
					saldo=f_saldo_formula(dw_data,formula,j)
					saldoant=f_saldo_formula_ant(dw_data,formula,j)
					dw_data.setfilter("contabalgrup_grupo='"+grupod+"'")
					dw_data.filter()
				end if
				if saldo<=0 then saldo=0
				if saldoant<=0 then saldoant=0
				dw_data.setitem(j,"csal_for",saldo)
				dw_data.setitem(j,"csal_forant",saldoant)
			end if
		next
	end if
	if i<=ch then
		grupoh=dw_cursorh.getitemstring(i,"grupo")
		dw_data.setfilter("contabalgrup_grupo='"+grupoh+"'")
		dw_data.filter()
		for j=1 to dw_data.rowcount()
			formula=dw_data.getitemstring(j,"contabalgrup_formula")
			if formula<>"" and not isnull(formula) then
				if j=1 then
					saldo=f_saldo_formula(dw_data,formula,j)
					saldoant=f_saldo_formula_ant(dw_data,formula,j)
					dw_data.setfilter("contabalgrup_grupo='"+grupoh+"'")
					dw_data.filter()
				end if
				if saldo<=0 then saldo=0
				if saldoant<=0 then saldoant=0
				dw_data.setitem(j,"csal_for",saldo)
				dw_data.setitem(j,"csal_forant",saldoant)
			end if
		next
	end if	
next

// Mostramos los que tienen saldo
//dw_data.setfilter("saldo<>0 or (csal_for<>0 and contabalsubgrup_subgrupo='') or (csal_for<>0 and IsNull(contabalsubgrup_subgrupo))")
//dw_data.filter()

dw_data.sort()
dw_data.groupcalc()
//if cbx_resumen.checked then
	dw_data.modify("Datawindow.detail.height = 0")
//else
//	dw_data.modify("Datawindow.detail.height = 72")
//end if
dw_data.setredraw(true)
Setpointer(Arrow!)
end subroutine

public function decimal f_saldo_formula (datawindow dw, string formu, long donde);if formu="" or isnull(formu) then return 0
dec retorno,saldo_grupo
retorno=0
long j,largo,principio,final,final1,final2
integer signo,signo_pos
signo=1
boolean continuo
string grupo
grupo=""
continuo=true
largo=len(formu)
principio=1
final=0
DO while continuo
	saldo_grupo=0
	final1=Pos(formu,"+",principio)
	final2=Pos(formu,"-",principio)
	if final1=0 and final2=0 then
		final=largo+1
		continuo=False
	else
		if final1=0 then final1=largo
		if final2=0 then final2=largo		
		if final1 < final2 then
			final=final1
			signo_pos=1
			continuo=true
		else
			final=final2
			signo_pos=-1
			continuo=true
		end if
	end if
	cb_consulta.enabled=true
	grupo=mid(formu,principio,final - principio)
	string tipo
	tipo=left(grupo,1)
	grupo=right(grupo,len(grupo) - 1)
	if tipo='G' then
		dw.setfilter("contabalgrup_grupo = '"+grupo+"'")
		dw.filter()
		for j=1 to dw.rowcount()
			if dw.getitemstring(j,"contabalgrup_formula")=""	or isnull(dw.getitemstring(j,"contabalgrup_formula")) then
				saldo_grupo=saldo_grupo+dw.getitemnumber(j,"saldo")
			else
				saldo_grupo=dw.getitemnumber(j,"csal_for")
				exit
			end if
		next
	else
		dw.setfilter("contabalsubgrup_subgrupo = '"+grupo+"'")
		dw.filter()
		for j=1 to dw.rowcount()
			saldo_grupo=saldo_grupo+dw.getitemnumber(j,"saldo")
		next		
	end if

	retorno=retorno + signo*saldo_grupo
//	messagebox(tipo+" "+grupo+" "+string(saldo_grupo*signo),formu)
	dw.setfilter("")
	dw.filter()
	principio=final+1
	signo=signo_pos
LOOP

return retorno
	
end function

public function decimal f_saldo_formula_ant (datawindow dw, string formu, long donde);if formu="" or isnull(formu) then return 0
dec retorno,saldo_grupo
retorno=0
long j,largo,principio,final,final1,final2
integer signo,signo_pos
signo=1
boolean continuo
string grupo
grupo=""
continuo=true
largo=len(formu)
principio=1
final=0
DO while continuo
	saldo_grupo=0
	final1=Pos(formu,"+",principio)
	final2=Pos(formu,"-",principio)
	if final1=0 and final2=0 then
		final=largo+1
		continuo=False
	else
		if final1=0 then final1=largo
		if final2=0 then final2=largo		
		if final1 < final2 then
			final=final1
			signo_pos=1
			continuo=true
		else
			final=final2
			signo_pos=-1
			continuo=true
		end if
	end if
	cb_consulta.enabled=true
	grupo=mid(formu,principio,final - principio)
	string tipo
	tipo=left(grupo,1)
	grupo=right(grupo,len(grupo) - 1)
	if tipo='G' then
		dw.setfilter("contabalgrup_grupo = '"+grupo+"'")
		dw.filter()
		for j=1 to dw.rowcount()
			if dw.getitemstring(j,"contabalgrup_formula")=""	or isnull(dw.getitemstring(j,"contabalgrup_formula")) then
				saldo_grupo=saldo_grupo+dw.getitemnumber(j,"saldoant")
			else
				saldo_grupo=dw.getitemnumber(j,"csal_forant")
				exit
			end if
		next
	else
		dw.setfilter("contabalsubgrup_subgrupo = '"+grupo+"'")
		dw.filter()
		for j=1 to dw.rowcount()
			saldo_grupo=saldo_grupo+dw.getitemnumber(j,"saldoant")
		next		
	end if

	retorno=retorno + signo*saldo_grupo
//	messagebox(tipo+" "+grupo+" "+string(saldo_grupo*signo),formu)
	dw.setfilter("")
	dw.filter()
	principio=final+1
	signo=signo_pos
LOOP

return retorno
	
end function

event ue_listar;dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;This.title = "BALANCES GENERALES"

em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
dw_cursord.settransobject(sqlca)
dw_cursorh.settransobject(sqlca)
f_activar_campo(em_fechadesde)

str_paramemp em
int dec_moneda
em = f_paramemp(codigo_empresa)
dec_moneda = f_decimales_moneda(em.moneda_emp)

//f_mascara_columna(dw_1,"saldo",f_mascara_decimales(dec_moneda))
//f_mascara_columna(dw_1,"saldo_formula",f_mascara_decimales(dec_moneda))
//f_mascara_columna(dw_1,"saldo_grupo",f_mascara_decimales(dec_moneda))
//f_mascara_columna(dw_1,"saldo_subgrupo",f_mascara_decimales(dec_moneda))
//
//f_mascara_columna(dw_listado,"saldo",f_mascara_decimales(dec_moneda))
//f_mascara_columna(dw_listado,"saldo_formula",f_mascara_decimales(dec_moneda))
//f_mascara_columna(dw_listado,"saldo_grupo",f_mascara_decimales(dec_moneda))
//f_mascara_columna(dw_listado,"saldo_subgrupo",f_mascara_decimales(dec_moneda))
//

cb_1.enabled = false
end event

on w_balance.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.gb_22=create gb_22
this.gb_1=create gb_1
this.cb_consulta=create cb_consulta
this.em_fechahasta=create em_fechahasta
this.st_1=create st_1
this.gb_2=create gb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.uo_1=create uo_1
this.dw_1=create dw_1
this.dw_cursord=create dw_cursord
this.dw_cursorh=create dw_cursorh
this.cb_1=create cb_1
this.dw_listado=create dw_listado
this.uo_balance=create uo_balance
this.cbx_resumen=create cbx_resumen
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.em_fechadesde
this.Control[iCurrent+3]=this.gb_22
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.cb_consulta
this.Control[iCurrent+6]=this.em_fechahasta
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.pb_imprimir_preli
this.Control[iCurrent+10]=this.uo_1
this.Control[iCurrent+11]=this.dw_1
this.Control[iCurrent+12]=this.dw_cursord
this.Control[iCurrent+13]=this.dw_cursorh
this.Control[iCurrent+14]=this.cb_1
this.Control[iCurrent+15]=this.dw_listado
this.Control[iCurrent+16]=this.uo_balance
this.Control[iCurrent+17]=this.cbx_resumen
end on

on w_balance.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.gb_22)
destroy(this.gb_1)
destroy(this.cb_consulta)
destroy(this.em_fechahasta)
destroy(this.st_1)
destroy(this.gb_2)
destroy(this.pb_imprimir_preli)
destroy(this.uo_1)
destroy(this.dw_1)
destroy(this.dw_cursord)
destroy(this.dw_cursorh)
destroy(this.cb_1)
destroy(this.dw_listado)
destroy(this.uo_balance)
destroy(this.cbx_resumen)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_balance
integer x = 800
integer y = 816
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_balance
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_balance
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_balance
integer x = 2743
integer y = 8
integer width = 128
integer height = 112
integer taborder = 0
string picturename = "exit!"
end type

type em_fechadesde from u_em_campo within w_balance
integer x = 41
integer y = 196
integer width = 279
integer taborder = 10
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event losefocus;call super::losefocus;anyo=year(date(em_fechadesde.text))
if anyo<year(today()) then em_fechahasta.text=string(date(anyo,12,31))
end event

type gb_22 from groupbox within w_balance
integer x = 727
integer y = 116
integer width = 1134
integer height = 184
integer taborder = 1
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Balance"
end type

type gb_1 from groupbox within w_balance
integer y = 116
integer width = 727
integer height = 184
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Fecha Apunte"
end type

type cb_consulta from u_boton within w_balance
integer x = 1874
integer y = 200
integer width = 398
integer height = 88
integer taborder = 40
boolean bringtotop = true
string facename = "Arial"
string text = "Consulta"
end type

event clicked;dw_1.object.fechas.text = "Desde "+em_fechadesde.text+" al "+em_fechahasta.text

IF not isdate(em_fechadesde.text) then
	messagebox("ERROR DE DATOS","Fecha desde NO válida",exclamation!)
	em_fechadesde.setfocus()
	return	
end if


IF not isdate(em_fechahasta.text) then
	messagebox("ERROR DE DATOS","Fecha hasta NO válida",exclamation!)
	em_fechahasta.setfocus()
	return	
end if

if date(em_fechahasta.text) < date(em_fechadesde.text) then
	messagebox("ERROR DE DATOS","Fecha hasta > que fecha desde",exclamation!)
	em_fechahasta.setfocus()
	return	
end if


if uo_balance.em_codigo.text = "" then
	messagebox("ERROR DE DATOS","Introduzca el balance",exclamation!)
	uo_balance.em_campo.setfocus()
	return	
end if
	


dw_1.reset()

dw_1.setfilter("")
dw_1.filter()
dw_1.Sort()
dw_1.groupcalc()

f_cargar(dw_1)

//// Mostramos los que tienen saldo por defecto
//dw_1.setfilter("saldo<>0 or (csal_for<>0 and contabalsubgrup_subgrupo='') or (csal_for<>0 and IsNull(contabalsubgrup_subgrupo))")
//dw_1.filter()
//dw_1.Sort()
//dw_1.groupcalc()

dw_1.setfilter("")
dw_1.filter()
dw_1.Sort()
dw_1.groupcalc()
cb_1.text = "Resumen"

if dw_1.rowcount() > 0 then
	dw_1.visible = true
	cb_1.enabled = true
else
	messagebox("Atención","No hay cuentas")
	dw_1.reset()
	dw_1.visible = false
	cb_1.enabled = false
end if


end event

type em_fechahasta from u_em_campo within w_balance
integer x = 416
integer y = 196
integer width = 279
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modificado;call super::modificado;integer anyo2
date fechah
fechah=date(em_fechahasta.text)
anyo2=year(fechah)

if anyo2<>anyo then 
	messagebox("Año Incorrecto","El año debe ser el mismo")
	em_fechahasta.text=string(date(anyo,12,31))
	f_activar_campo(em_fechahasta)
	RETURN
end if 

if fechah<date(em_fechadesde.text) then 
	messagebox("Fecha Incorrecta","La 2ª fecha debe ser mayor que la 1ª")
	em_fechahasta.text=string(date(anyo,12,31))
	f_activar_campo(em_fechahasta)
	RETURN
end if 

end event

type st_1 from statictext within w_balance
integer x = 338
integer y = 176
integer width = 64
integer height = 92
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "_"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_balance
integer x = 1861
integer y = 160
integer width = 425
integer height = 140
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type pb_imprimir_preli from picturebutton within w_balance
integer x = 2752
integer y = 200
integer width = 110
integer height = 96
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "print!"
end type

event clicked;//dw_listado.reset()

//f_cargar(dw_listado)

//if messagebox("BALANCES"," ¿ Desea imprimir las cuentas con saldo 0 ?",Question!,YesNo!,2)=1 then
//	dw_listado.setfilter("")
//	dw_listado.filter()
//	dw_listado.Sort()
//	dw_listado.GroupCalc()
//else
//	// Mostramos los que tienen saldo
//	dw_listado.setfilter("saldo<>0 or (csal_for<>0 and contabalsubgrup_subgrupo='') or (csal_for<>0 and IsNull(contabalsubgrup_subgrupo))")
//	dw_listado.filter()
//	dw_listado.sort()
//	dw_listado.groupcalc()
//end if

f_imprimir_datawindow(dw_1)
//dw_1.visible = FALSE
end event

type uo_1 from u_manejo_datawindow within w_balance
integer x = 2277
integer y = 152
integer width = 599
integer height = 160
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type dw_1 from datawindow within w_balance
boolean visible = false
integer x = 23
integer y = 316
integer width = 3488
integer height = 1728
boolean bringtotop = true
string dataobject = "dw_balances"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_cursord from datawindow within w_balance
boolean visible = false
integer x = 3246
integer y = 112
integer width = 82
integer height = 64
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_cursor_contabal"
boolean livescroll = true
end type

type dw_cursorh from datawindow within w_balance
boolean visible = false
integer x = 3246
integer y = 20
integer width = 82
integer height = 64
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_cursor_contabal"
boolean livescroll = true
end type

type cb_1 from commandbutton within w_balance
boolean visible = false
integer x = 1874
integer y = 156
integer width = 398
integer height = 68
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Detalle"
end type

event clicked;
if cb_1.text = "Detalle" then
	dw_1.setfilter("")
	dw_1.filter()
	dw_1.Sort()
	dw_1.groupcalc()
	cb_1.text = "Resumen"
else
	// Mostramos los que tienen saldo
	dw_1.setfilter("saldo<>0 or (csal_for<>0 and contabalsubgrup_subgrupo='') or (csal_for<>0 and IsNull(contabalsubgrup_subgrupo))")
	dw_1.filter()

	dw_1.sort()
	dw_1.groupcalc()
	cb_1.text = "Detalle"
end if

end event

type dw_listado from datawindow within w_balance
boolean visible = false
integer x = 3072
integer y = 16
integer width = 151
integer height = 132
string dataobject = "report_balances"
boolean livescroll = true
end type

type uo_balance from u_em_campo_2 within w_balance
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 759
integer y = 196
integer width = 1065
integer height = 80
integer taborder = 30
boolean bringtotop = true
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_balance.em_campo.text=f_nombre_contabal(codigo_empresa,uo_balance.em_codigo.text)

IF Trim(uo_balance.em_campo.text)="" THEN 
 IF Trim(uo_balance.em_codigo.text)<>"" Then uo_balance.em_campo.SetFocus()
 uo_balance.em_campo.text=""
 uo_balance.em_codigo.text=""

END IF



end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de balances"
ue_datawindow = "dw_ayuda_contabal"
ue_filtro     = ""

end event

on uo_balance.destroy
call u_em_campo_2::destroy
end on

type cbx_resumen from checkbox within w_balance
boolean visible = false
integer x = 2290
integer y = 124
integer width = 352
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Resumen"
end type

