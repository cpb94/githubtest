$PBExportHeader$w_con_balance_saldos_pre_cierre.srw
forward
global type w_con_balance_saldos_pre_cierre from w_int_con_empresa
end type
type gb_3 from groupbox within w_con_balance_saldos_pre_cierre
end type
type gb_nivel from groupbox within w_con_balance_saldos_pre_cierre
end type
type gb_cuenta from groupbox within w_con_balance_saldos_pre_cierre
end type
type pb_2 from upb_salir within w_con_balance_saldos_pre_cierre
end type
type em_fechadesde from u_em_campo within w_con_balance_saldos_pre_cierre
end type
type gb_1 from groupbox within w_con_balance_saldos_pre_cierre
end type
type cb_consulta from u_boton within w_con_balance_saldos_pre_cierre
end type
type em_fechahasta from u_em_campo within w_con_balance_saldos_pre_cierre
end type
type pb_imprimir_preli from picturebutton within w_con_balance_saldos_pre_cierre
end type
type em_cuentadesde from u_em_campo within w_con_balance_saldos_pre_cierre
end type
type em_cuentahasta from u_em_campo within w_con_balance_saldos_pre_cierre
end type
type em_nivel from u_em_campo within w_con_balance_saldos_pre_cierre
end type
type dw_ayuda_nivel from datawindow within w_con_balance_saldos_pre_cierre
end type
type sle_digitos from singlelineedit within w_con_balance_saldos_pre_cierre
end type
type cbx_sal from checkbox within w_con_balance_saldos_pre_cierre
end type
type cbx_mov from checkbox within w_con_balance_saldos_pre_cierre
end type
type gb_2 from groupbox within w_con_balance_saldos_pre_cierre
end type
type st_nom1 from statictext within w_con_balance_saldos_pre_cierre
end type
type st_nom2 from statictext within w_con_balance_saldos_pre_cierre
end type
type st_1 from statictext within w_con_balance_saldos_pre_cierre
end type
type st_2 from statictext within w_con_balance_saldos_pre_cierre
end type
type st_3 from statictext within w_con_balance_saldos_pre_cierre
end type
type dw_1 from datawindow within w_con_balance_saldos_pre_cierre
end type
end forward

global type w_con_balance_saldos_pre_cierre from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3881
integer height = 3228
string title = "Consulta de Movimientos"
gb_3 gb_3
gb_nivel gb_nivel
gb_cuenta gb_cuenta
pb_2 pb_2
em_fechadesde em_fechadesde
gb_1 gb_1
cb_consulta cb_consulta
em_fechahasta em_fechahasta
pb_imprimir_preli pb_imprimir_preli
em_cuentadesde em_cuentadesde
em_cuentahasta em_cuentahasta
em_nivel em_nivel
dw_ayuda_nivel dw_ayuda_nivel
sle_digitos sle_digitos
cbx_sal cbx_sal
cbx_mov cbx_mov
gb_2 gb_2
st_nom1 st_nom1
st_nom2 st_nom2
st_1 st_1
st_2 st_2
st_3 st_3
dw_1 dw_1
end type
global w_con_balance_saldos_pre_cierre w_con_balance_saldos_pre_cierre

type variables
integer anyo
integer digitos,digitos_menor
integer niveles,dig[10]
integer nivel_elegido
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
public subroutine f_ayuda_nivel ()
public function integer dias_mes (integer el_mes, integer el_anyo)
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer   registros,saldos,movimientos,digi,resto
Integer   dias,mes,el_any
Date      fdesde_periodo,fhasta_periodo
String    cuenta_desde,cuenta_hasta,sel,cuenta_inicial_desde,cuenta_inicial_hasta,cuenta,f_saldo_inicial,imprimir
Long      total,indice,donde,ejercicio,anyo_i,anyo_f
Dec{2}    debe,haber,saldo,saldo_ini
Datastore datos

dw_data.SetTransObject(sqlca)
dw_data.reset()
dw_data.visible   = FALSE
dw_data.setfilter("")
dw_data.filter()

fdesde_periodo  = Date(em_fechadesde.text)
anyo_i = Year(fdesde_periodo)
fhasta_periodo  = Date(em_fechahasta.text)
anyo_f = Year(fhasta_periodo)
f_saldo_inicial = String(RelativeDate(fdesde_periodo, -1),"dd/mm/yy")

digi = dec(sle_digitos.text)
resto = 10 - digi
cuenta_inicial_desde = "0000000000"
cuenta_inicial_hasta = "9999999999"

// Si no hay nada obtenemos para todas las cuentas y todos los niveles
if trim(em_cuentadesde.text)= "" or isnull(em_cuentadesde.text) then
   cuenta_desde = left(cuenta_inicial_desde,digi)
 else
	cuenta_desde = left(em_cuentadesde.text,digi)+left("0000000000",resto)
end if

if trim(em_cuentahasta.text) = "" or isnull(em_cuentahasta.text) then
	cuenta_hasta = left(cuenta_inicial_hasta,digi)
else
	cuenta_hasta = left(em_cuentahasta.text,digi)+left("9999999999",resto)
end if

if cbx_sal.checked then
	saldos = 1
else
	saldos = 0
end if
if cbx_mov.checked then
	movimientos = 1
else
	movimientos = 0
end if

dw_data.Retrieve(codigo_empresa,datetime(fdesde_periodo),datetime(fhasta_periodo),saldos,movimientos)

sel = "select empresa,cuenta,fapunte,debe,haber,ejercicio "+&
		"from   contaapun "+&
		"where  empresa = '"+codigo_empresa+"' "+&
		"and    origen = '101' "+&
		"and    ejercicio = "+string(anyo_i,"####")+" "+&
		"and    cuenta between '"+cuenta_desde+"' and '"+cuenta_hasta+"' "

//datos = f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, datos)
total = datos.rowcount()
if total = 0 then
	sel = "select empresa,cuenta,fapunte,debe,haber,ejercicio "+&
			"from   contaapun "+&
			"where  empresa = '"+codigo_empresa+"' "+&
			"and    ejercicio = "+string(anyo_i - 1,"####")+" "+&
			"and    cuenta between '"+cuenta_desde+"' and '"+cuenta_hasta+"' "
//	datos = f_cargar_cursor(sel)		
	f_cargar_cursor_nuevo(sel, datos)
	total = datos.rowcount()
end if
for indice = 1 to total
	f_mensaje_proceso("Calculando Saldos Iniciales",indice,total)
	cuenta = left(datos.object.cuenta[indice],digi)
	debe   = datos.object.debe[indice]
	haber  = datos.object.haber[indice]
	ejercicio = datos.object.ejercicio[indice]
	donde  = dw_data.find("cuenta = '"+cuenta+"'",1,dw_data.rowcount())
	if donde > 0 then
		dw_data.object.debe_inicial[donde]  = dw_data.object.debe_inicial[donde]  + debe
		dw_data.object.haber_inicial[donde] = dw_data.object.haber_inicial[donde] + haber
		dw_data.object.saldo_inicial[donde] = dw_data.object.saldo_inicial[donde] + (debe - haber)
	else
		donde = dw_data.insertrow(0)
		dw_data.object.empresa[donde]         = codigo_empresa
		dw_data.object.cuenta[donde]          = cuenta
		dw_data.object.nombre_cuenta[donde]   = f_nombre_contaplan(ejercicio,codigo_empresa,cuenta)
		dw_data.object.debe_inicial[donde]    = debe
		dw_data.object.haber_inicial[donde]   = haber
		dw_data.object.saldo_inicial[donde]   = debe - haber
		dw_data.object.debe_periodo[donde]    = 0
		dw_data.object.haber_periodo[donde]   = 0
		dw_data.object.saldo_periodo[donde]   = 0
		dw_data.object.debe_acumulado[donde]  = 0
		dw_data.object.haber_acumulado[donde] = 0
		dw_data.object.saldo_acumulado[donde] = 0
		dw_data.object.imprimir[donde]        = "S"
	end if
next

sel = "select empresa,cuenta,fapunte,debe,haber,ejercicio "+&
		"from   contaapun "+&
		"where  empresa = '"+codigo_empresa+"' "+&
		"and    fapunte <= '"+f_saldo_inicial+"' "+&
		"and    origen <> '101' "+&
		"and    ejercicio between "+string(anyo_i,"####")+" and "+string(anyo_f,"####")+" "+&
		"and    cuenta between '"+cuenta_desde+"' and '"+cuenta_hasta+"' "

//datos = f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, datos)
total = datos.rowcount()

for indice = 1 to total
	f_mensaje_proceso("Calculando Saldos Iniciales",indice,total)
	cuenta = left(datos.object.cuenta[indice],digi)
	debe   = datos.object.debe[indice]
	haber  = datos.object.haber[indice]
	ejercicio = datos.object.ejercicio[indice]
	donde  = dw_data.find("cuenta = '"+cuenta+"'",1,dw_data.rowcount())
	if donde > 0 then
		dw_data.object.debe_inicial[donde]  = dw_data.object.debe_inicial[donde]  + debe
		dw_data.object.haber_inicial[donde] = dw_data.object.haber_inicial[donde] + haber
		dw_data.object.saldo_inicial[donde] = dw_data.object.saldo_inicial[donde] + (debe - haber)
	else
		donde = dw_data.insertrow(0)
		dw_data.object.empresa[donde]         = codigo_empresa
		dw_data.object.cuenta[donde]          = cuenta
		dw_data.object.nombre_cuenta[donde]   = f_nombre_contaplan(ejercicio,codigo_empresa,cuenta)
		dw_data.object.debe_inicial[donde]    = debe
		dw_data.object.haber_inicial[donde]   = haber
		dw_data.object.saldo_inicial[donde]   = debe - haber
		dw_data.object.debe_periodo[donde]    = 0
		dw_data.object.haber_periodo[donde]   = 0
		dw_data.object.saldo_periodo[donde]   = 0
		dw_data.object.debe_acumulado[donde]  = 0
		dw_data.object.haber_acumulado[donde] = 0
		dw_data.object.saldo_acumulado[donde] = 0
		dw_data.object.imprimir[donde]        = "S"
	end if
next

sel = "select empresa,cuenta,fapunte,cuenta,debe,haber,ejercicio "+&
		"from   contaapun "+&
		"where  empresa = '"+codigo_empresa+"' "+&
		"and    origen <> '101' "+&
		"and    origen <> '100' "+&
		"and    origen <> '102' "+&
		"and    fapunte between '"+em_fechadesde.Text+"' and '"+em_fechahasta.Text+"' "+&
		"and    cuenta between '"+cuenta_desde+"' and '"+cuenta_hasta+"' "

//datos = f_cargar_cursor(sel)		
f_cargar_cursor_nuevo(sel, datos)
total = datos.rowcount()

for indice = 1 to total
	f_mensaje_proceso("Calculando Periodo",indice,total)
	cuenta = left(datos.object.cuenta[indice],digi)
	debe   = datos.object.debe[indice]
	haber  = datos.object.haber[indice]
	ejercicio = datos.object.ejercicio[indice]
	donde  = dw_data.find("cuenta = '"+cuenta+"'",1,dw_data.rowcount())
	if donde > 0 then
		dw_data.object.debe_periodo[donde]     = dw_data.object.debe_periodo[donde]  + debe 
		dw_data.object.haber_periodo[donde]    = dw_data.object.haber_periodo[donde] + haber 
		dw_data.object.saldo_periodo[donde]    = dw_data.object.saldo_periodo[donde] + (debe -haber)
	else
		donde = dw_data.insertrow(0)
		dw_data.object.empresa[donde]           = codigo_empresa
		dw_data.object.cuenta[donde]            = cuenta
		dw_data.object.nombre_cuenta[donde]     = f_nombre_contaplan(ejercicio,codigo_empresa,cuenta)
		dw_data.object.debe_inicial[donde]      = 0
		dw_data.object.haber_inicial[donde]     = 0
		dw_data.object.saldo_inicial[donde]     = 0
		dw_data.object.debe_periodo[donde]      = debe
		dw_data.object.haber_periodo[donde]     = haber
		dw_data.object.saldo_periodo[donde]     = debe - haber
		dw_data.object.debe_acumulado[donde]    = 0
		dw_data.object.haber_acumulado[donde]   = 0
		dw_data.object.saldo_acumulado[donde]   = 0
		dw_data.object.imprimir[donde]          = "S"
	end if
next

total = dw_data.rowcount()

for indice = 1 to total
	f_mensaje_proceso("Calculando Saldos Acumulados",indice,total)
	saldo_ini = dw_data.object.saldo_inicial[indice]
	if saldo_ini <> 0 then
		if saldo_ini > 0 then
			dw_data.object.debe_acumulado[indice]    = saldo_ini  + dw_data.object.debe_periodo[indice]
			dw_data.object.haber_acumulado[indice]   = dw_data.object.haber_periodo[indice]
		end if
		if saldo_ini < 0 then
			dw_data.object.debe_acumulado[indice]    = dw_data.object.debe_periodo[indice]
			dw_data.object.haber_acumulado[indice]   = abs(saldo_ini) + dw_data.object.haber_periodo[indice]
		end if
		dw_data.object.saldo_acumulado[indice]   = dw_data.object.debe_acumulado[indice] - dw_data.object.haber_acumulado[indice]
	else
		dw_data.object.debe_acumulado[indice]    = dw_data.object.debe_periodo[indice]
		dw_data.object.haber_acumulado[indice]   = dw_data.object.haber_periodo[indice]
		dw_data.object.saldo_acumulado[indice]   = dw_data.object.debe_acumulado[indice] - dw_data.object.haber_acumulado[indice]
	end if
next

if saldos = 1 then 
	for indice = 1 to total
		f_mensaje_proceso("Iniciando Proceso de Impresión",indice,total)
		saldo  = dw_data.GetItemNumber(indice,"saldo_acumulado")
		if saldo = 0 then
			dw_data.object.imprimir[indice] = "N"
		end if
	next
end if
if movimientos = 1 then 
	for indice = 1 to total
		f_mensaje_proceso("Iniciando Proceso de Impresión II",indice,total)
		debe  = dw_data.GetItemNumber(indice,"debe_periodo")
		haber = dw_data.GetItemNumber(indice,"haber_periodo")
		saldo  = dw_data.GetItemNumber(indice,"saldo_acumulado")
		imprimir = dw_data.GetItemString(indice,"imprimir")
		if  debe = 0 and  haber = 0 then
			// No tiene movimientos en el periodo
			if saldo <> 0 and saldos = 1 then
				dw_data.object.imprimir[indice] = "S"
			else
				dw_data.object.imprimir[indice] = "N"
			end if
		else
			// Tiene movimientos en el periodo
			dw_data.object.imprimir[indice] = "S"
		end if
	next
end if

destroy datos
dw_data.setfilter("imprimir = 'S'")
dw_data.filter()
dw_data.sort()
dw_data.groupcalc()
dw_data.setredraw(true)
end subroutine

public subroutine f_ayuda_nivel ();integer i
  
SELECT contaparam.niveles,contaparam.digitos1,   
		 contaparam.digitos2,contaparam.digitos3,   
		 contaparam.digitos4,contaparam.digitos5,   
		 contaparam.digitos6,contaparam.digitos7,   
		 contaparam.digitos8,contaparam.digitos9  
INTO :niveles,:dig[1],:dig[2],:dig[3],   
	  :dig[4],:dig[5],:dig[6],:dig[7],   
	  :dig[8],:dig[9]  
FROM contaparam  
WHERE ( contaparam.ejercicio = :anyo ) AND  
		( contaparam.empresa = :codigo_empresa )   ;
		
dw_ayuda_nivel.reset()

for i=1 to niveles
	dw_ayuda_nivel.insertrow(i)
	dw_ayuda_nivel.SetItem(i, "nivel", i)
	dw_ayuda_nivel.SetItem(i, "digitos", dig[i])
next
	
integer long1,long2

long1=integer(dw_ayuda_nivel.Object.DataWindow.detail.Height)
long2=integer(dw_ayuda_nivel.Object.DataWindow.header.Height)
dw_ayuda_nivel.height=(integer(dw_ayuda_nivel.rowcount())+1)* long1 +long2
dw_ayuda_nivel.visible=true
dw_ayuda_nivel.SetFocus()
dw_ayuda_nivel.SetRowFocusIndicator(hand!)
dw_ayuda_nivel.SetRow(1)
end subroutine

public function integer dias_mes (integer el_mes, integer el_anyo);int resto

choose case  el_mes
	case 1,3,5,7,8,10,12
		return 31
	case 4,6,9,11
		return 30
	case 2
		resto = mod(el_anyo,4) 
		if resto = 0 then
			return 29
		else
			return 28
		end if
end choose
		
end function

event open;call super::open;This.title = " BALANCE DE SUMAS Y SALDOS"
em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
em_cuentadesde.text = "0000000000"
em_cuentahasta.text = "9999999999"
nivel_elegido = 0
cbx_sal.checked = true
f_activar_campo(em_fechadesde)


end event

on w_con_balance_saldos_pre_cierre.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.gb_nivel=create gb_nivel
this.gb_cuenta=create gb_cuenta
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.gb_1=create gb_1
this.cb_consulta=create cb_consulta
this.em_fechahasta=create em_fechahasta
this.pb_imprimir_preli=create pb_imprimir_preli
this.em_cuentadesde=create em_cuentadesde
this.em_cuentahasta=create em_cuentahasta
this.em_nivel=create em_nivel
this.dw_ayuda_nivel=create dw_ayuda_nivel
this.sle_digitos=create sle_digitos
this.cbx_sal=create cbx_sal
this.cbx_mov=create cbx_mov
this.gb_2=create gb_2
this.st_nom1=create st_nom1
this.st_nom2=create st_nom2
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.gb_nivel
this.Control[iCurrent+3]=this.gb_cuenta
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.em_fechadesde
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.cb_consulta
this.Control[iCurrent+8]=this.em_fechahasta
this.Control[iCurrent+9]=this.pb_imprimir_preli
this.Control[iCurrent+10]=this.em_cuentadesde
this.Control[iCurrent+11]=this.em_cuentahasta
this.Control[iCurrent+12]=this.em_nivel
this.Control[iCurrent+13]=this.dw_ayuda_nivel
this.Control[iCurrent+14]=this.sle_digitos
this.Control[iCurrent+15]=this.cbx_sal
this.Control[iCurrent+16]=this.cbx_mov
this.Control[iCurrent+17]=this.gb_2
this.Control[iCurrent+18]=this.st_nom1
this.Control[iCurrent+19]=this.st_nom2
this.Control[iCurrent+20]=this.st_1
this.Control[iCurrent+21]=this.st_2
this.Control[iCurrent+22]=this.st_3
this.Control[iCurrent+23]=this.dw_1
end on

on w_con_balance_saldos_pre_cierre.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_3)
destroy(this.gb_nivel)
destroy(this.gb_cuenta)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.gb_1)
destroy(this.cb_consulta)
destroy(this.em_fechahasta)
destroy(this.pb_imprimir_preli)
destroy(this.em_cuentadesde)
destroy(this.em_cuentahasta)
destroy(this.em_nivel)
destroy(this.dw_ayuda_nivel)
destroy(this.sle_digitos)
destroy(this.cbx_sal)
destroy(this.cbx_mov)
destroy(this.gb_2)
destroy(this.st_nom1)
destroy(this.st_nom2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_1)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_balance_saldos_pre_cierre
integer x = 782
integer y = 1156
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_balance_saldos_pre_cierre
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_balance_saldos_pre_cierre
integer y = 20
integer width = 3598
end type

type gb_3 from groupbox within w_con_balance_saldos_pre_cierre
integer x = 2094
integer y = 120
integer width = 667
integer height = 328
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Tipo"
end type

type gb_nivel from groupbox within w_con_balance_saldos_pre_cierre
integer x = 1659
integer y = 116
integer width = 430
integer height = 328
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
end type

type gb_cuenta from groupbox within w_con_balance_saldos_pre_cierre
integer x = 457
integer y = 116
integer width = 1193
integer height = 328
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Cuenta"
end type

type pb_2 from upb_salir within w_con_balance_saldos_pre_cierre
integer x = 3648
integer y = 12
integer width = 128
integer height = 112
integer taborder = 0
end type

type em_fechadesde from u_em_campo within w_con_balance_saldos_pre_cierre
integer x = 87
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

type gb_1 from groupbox within w_con_balance_saldos_pre_cierre
integer x = 9
integer y = 116
integer width = 439
integer height = 324
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Fecha Apunte"
end type

type cb_consulta from u_boton within w_con_balance_saldos_pre_cierre
integer x = 3273
integer y = 232
integer width = 352
integer height = 92
integer taborder = 0
boolean bringtotop = true
string facename = "Arial"
string text = "Consulta"
end type

event clicked;f_cargar(dw_1)
dw_1.visible   = TRUE
end event

type em_fechahasta from u_em_campo within w_con_balance_saldos_pre_cierre
integer x = 87
integer y = 312
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

type pb_imprimir_preli from picturebutton within w_con_balance_saldos_pre_cierre
integer x = 3648
integer y = 232
integer width = 105
integer height = 88
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "print!"
end type

event clicked;dw_1.visible   = TRUE
f_imprimir_datawindow(dw_1)
end event

type em_cuentadesde from u_em_campo within w_con_balance_saldos_pre_cierre
integer x = 475
integer y = 196
integer width = 416
integer taborder = 30
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "##########"
end type

event getfocus;call super::getfocus;ue_titulo = "Selección de Cuentas"
ue_datawindow ="dw_ayuda_contaplan_directo"
end event

event modificado;call super::modificado;st_nom1.text=f_nombre_contaplan(f_ejercicio_activo(codigo_empresa),codigo_empresa,em_cuentadesde.text)

end event

type em_cuentahasta from u_em_campo within w_con_balance_saldos_pre_cierre
integer x = 475
integer y = 312
integer width = 416
integer taborder = 40
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "##########"
end type

event modificado;call super::modificado;st_nom2.text=f_nombre_contaplan(f_ejercicio_activo(codigo_empresa),codigo_empresa,em_cuentahasta.text)

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Cuentas"
ue_datawindow ="dw_ayuda_contaplan_directo"
end event

type em_nivel from u_em_campo within w_con_balance_saldos_pre_cierre
integer x = 1687
integer y = 284
integer width = 155
integer taborder = 50
boolean bringtotop = true
string text = "6"
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "########"
string displaydata = ""
end type

event modificado;call super::modificado;integer i
  
SELECT contaparam.niveles,contaparam.digitos1,   
		 contaparam.digitos2,contaparam.digitos3,   
		 contaparam.digitos4,contaparam.digitos5,   
		 contaparam.digitos6,contaparam.digitos7,   
		 contaparam.digitos8,contaparam.digitos9  
INTO   :niveles,:dig[1],:dig[2],:dig[3],   
		 :dig[4],:dig[5],:dig[6],:dig[7],   
		 :dig[8],:dig[9]  
FROM   contaparam  
WHERE ( contaparam.ejercicio = :anyo ) AND  
		( contaparam.empresa = :codigo_empresa );

nivel_elegido = integer(em_nivel.text)			
			
if niveles< nivel_elegido then 
	messagebox("Nivel Incorrecto","El máximo nivel es "+string(niveles))
	this.triggerevent("tecla_enter")
	return
end if

// Dígitos del max nivel elegido
digitos = dig[integer(em_nivel.text)]
sle_digitos.text = string(digitos,"##")

return
end event

event rbuttondown;f_ayuda_nivel()
return
end event

event tecla_enter;f_ayuda_nivel()
return
end event

type dw_ayuda_nivel from datawindow within w_con_balance_saldos_pre_cierre
boolean visible = false
integer x = 1678
integer y = 452
integer width = 393
integer height = 580
boolean bringtotop = true
string dataobject = "dw_especial_ayuda_nivel"
borderstyle borderstyle = styleraised!
end type

event clicked;if row <= 0 then return
em_nivel.text=string(getItemNumber(row,"nivel"))
em_nivel.triggerevent("modificado")
em_nivel.setfocus()
this.visible=false

end event

type sle_digitos from singlelineedit within w_con_balance_saldos_pre_cierre
integer x = 1920
integer y = 284
integer width = 137
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 79741120
string text = "10"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cbx_sal from checkbox within w_con_balance_saldos_pre_cierre
integer x = 2162
integer y = 208
integer width = 526
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
string text = "Con saldo"
boolean lefttext = true
end type

type cbx_mov from checkbox within w_con_balance_saldos_pre_cierre
integer x = 2162
integer y = 296
integer width = 526
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
string text = "Con movimientos"
boolean lefttext = true
end type

type gb_2 from groupbox within w_con_balance_saldos_pre_cierre
integer x = 3246
integer y = 188
integer width = 535
integer height = 156
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type st_nom1 from statictext within w_con_balance_saldos_pre_cierre
integer x = 905
integer y = 196
integer width = 722
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_nom2 from statictext within w_con_balance_saldos_pre_cierre
integer x = 905
integer y = 312
integer width = 722
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_1 from statictext within w_con_balance_saldos_pre_cierre
integer x = 1847
integer y = 296
integer width = 69
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_con_balance_saldos_pre_cierre
integer x = 1691
integer y = 204
integer width = 155
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Nivel"
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_balance_saldos_pre_cierre
integer x = 1911
integer y = 204
integer width = 155
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Díg."
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_balance_saldos_pre_cierre
integer x = 18
integer y = 456
integer width = 3794
integer height = 2548
string dataobject = "dw_con_balance_saldos_pre_cierre"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

