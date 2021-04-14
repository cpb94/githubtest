$PBExportHeader$w_con_balance_viejo.srw
forward
global type w_con_balance_viejo from w_int_con_empresa
end type
type gb_nivel from groupbox within w_con_balance_viejo
end type
type gb_cuenta from groupbox within w_con_balance_viejo
end type
type pb_2 from upb_salir within w_con_balance_viejo
end type
type em_fechadesde from u_em_campo within w_con_balance_viejo
end type
type gb_1 from groupbox within w_con_balance_viejo
end type
type cb_consulta from u_boton within w_con_balance_viejo
end type
type em_fechahasta from u_em_campo within w_con_balance_viejo
end type
type st_1 from statictext within w_con_balance_viejo
end type
type dw_listado from datawindow within w_con_balance_viejo
end type
type gb_2 from groupbox within w_con_balance_viejo
end type
type pb_imprimir_preli from picturebutton within w_con_balance_viejo
end type
type uo_1 from u_manejo_datawindow within w_con_balance_viejo
end type
type em_cuentadesde from u_em_campo within w_con_balance_viejo
end type
type st_2 from statictext within w_con_balance_viejo
end type
type em_cuentahasta from u_em_campo within w_con_balance_viejo
end type
type em_nivel from u_em_campo within w_con_balance_viejo
end type
type dw_ayuda_nivel from datawindow within w_con_balance_viejo
end type
type dw_1 from datawindow within w_con_balance_viejo
end type
type cb_det from u_boton within w_con_balance_viejo
end type
type cb_todos from commandbutton within w_con_balance_viejo
end type
type dw_2 from datawindow within w_con_balance_viejo
end type
end forward

global type w_con_balance_viejo from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2971
integer height = 1688
string title = "Consulta de Movimientos"
gb_nivel gb_nivel
gb_cuenta gb_cuenta
pb_2 pb_2
em_fechadesde em_fechadesde
gb_1 gb_1
cb_consulta cb_consulta
em_fechahasta em_fechahasta
st_1 st_1
dw_listado dw_listado
gb_2 gb_2
pb_imprimir_preli pb_imprimir_preli
uo_1 uo_1
em_cuentadesde em_cuentadesde
st_2 st_2
em_cuentahasta em_cuentahasta
em_nivel em_nivel
dw_ayuda_nivel dw_ayuda_nivel
dw_1 dw_1
cb_det cb_det
cb_todos cb_todos
dw_2 dw_2
end type
global w_con_balance_viejo w_con_balance_viejo

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

public subroutine f_cargar (datawindow dw_data);Integer registros
dw_data.SetTransObject(sqlca)
dw_data.reset()
dw_data.visible   = FALSE

datetime fdesde_ejer,fhasta_ejer
fdesde_ejer =datetime(date(em_fechadesde.text))
fhasta_ejer =datetime(date(em_fechahasta.text))
string cuenta_desde,cuenta_hasta

//-------------- ATENCIÓN ---------------------------------------------- 
// El ejercicio es desde la fecha inicial a la final(pedidas en pantalla)
// Son las variables fdesde_ejer y fhasta_ejer

// El periodo es sólo el mes de la fecha hasta(de la pantalla)
// Son las variables fdesde_periodo y fhasta_periodo

// PARA CAMBIAR EL ALCANCE DE PERIODO Y EJERCICIO MODIFICAR SÓLO ESAS 
// VARIABLES

int dias,mes,el_any
datetime fdesde_periodo,fhasta_periodo
mes = month(date(fhasta_ejer))
el_any = year(date(fhasta_ejer))
fdesde_periodo = datetime(date("1/" + string(mes) +"/" +string(el_any)))

// días del mes. Función de ventana 
dias = dias_mes(mes,year(date(fhasta_ejer)))

fhasta_periodo = datetime(date(string(dias)+"/" + string(mes) +"/" +string(el_any)))



// Si no hay nada obtenemos para todas las cuentas y todos los niveles
if em_cuentadesde.text = "" then
   cuenta_desde = "1"
 else
	cuenta_desde=em_cuentadesde.text
end if

if em_cuentahasta.text = "" then
	cuenta_hasta = "9"
else
	cuenta_hasta=em_cuentahasta.text
end if

// En open nivel_elegido := 0 
if nivel_elegido = 0 then
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

	// En nivel el máximo
	nivel_elegido = niveles
end if


// según los niveles se hace el retrieve

choose case nivel_elegido
		
	case 5 
		dw_data.retrieve(anyo,codigo_empresa,dig[5],dig[4],dig[3],dig[2],dig[1],fdesde_periodo,fhasta_periodo,fdesde_ejer,fhasta_ejer,cuenta_desde,cuenta_hasta)
      // mostramos todos
		dw_1.Modify("DataWindow.header.5.Height=69")
		dw_1.Modify("DataWindow.header.4.Height=69")
		dw_1.Modify("DataWindow.header.3.Height=69")
		dw_1.Modify("DataWindow.header.2.Height=69")
		dw_1.Modify("DataWindow.header.1.Height=69")
   case 4
      dw_data.retrieve(anyo,codigo_empresa,dig[4],dig[3],dig[2],dig[1],dig[1],fdesde_periodo,fhasta_periodo,fdesde_ejer,fhasta_ejer,cuenta_desde,cuenta_hasta)
		// el último no lo mostramos
		dw_1.Modify("DataWindow.header.5.Height=69")
		dw_1.Modify("DataWindow.header.4.Height=69")
		dw_1.Modify("DataWindow.header.3.Height=69")
		dw_1.Modify("DataWindow.header.2.Height=69")
		
		dw_1.Modify("DataWindow.header.1.Height=0")


	case 3
		dw_data.retrieve(anyo,codigo_empresa,dig[3],dig[2],dig[1],dig[1],dig[1],fdesde_periodo,fhasta_periodo,fdesde_ejer,fhasta_ejer,cuenta_desde,cuenta_hasta)
	   dw_1.Modify("DataWindow.header.5.Height=69")
		dw_1.Modify("DataWindow.header.4.Height=69")
		dw_1.Modify("DataWindow.header.3.Height=69")		
		dw_1.Modify("DataWindow.header.2.Height=0")
		dw_1.Modify("DataWindow.header.1.Height=0")
	case 2
      dw_data.retrieve(anyo,codigo_empresa,dig[2],dig[1],dig[1],dig[1],dig[1],fdesde_periodo,fhasta_periodo,fdesde_ejer,fhasta_ejer,cuenta_desde,cuenta_hasta)		
      dw_1.Modify("DataWindow.header.5.Height=69")
		dw_1.Modify("DataWindow.header.4.Height=69")		
		dw_1.Modify("DataWindow.header.3.Height=0")
		dw_1.Modify("DataWindow.header.2.Height=0")
		dw_1.Modify("DataWindow.header.1.Height=0")
	case 1
  		 dw_data.retrieve(anyo,codigo_empresa,dig[1],dig[1],dig[1],dig[1],dig[1],fdesde_periodo,fhasta_periodo,fdesde_ejer,fhasta_ejer,cuenta_desde,cuenta_hasta)
       dw_1.Modify("DataWindow.header.5.Height=69")
		 dw_1.Modify("DataWindow.header.4.Height=0")
		 dw_1.Modify("DataWindow.header.3.Height=0")
  		 dw_1.Modify("DataWindow.header.2.Height=0")
	    dw_1.Modify("DataWindow.header.1.Height=0")
end choose

If registros = 0 Then Return


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

event ue_listar;//dw_report= dw_listado
//dw_report.SetTransObject(SQLCA)
//CALL Super::ue_listar
end event

event open;call super::open;This.title = " BALANCE DE SUMAS Y SALDOS"

em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())

nivel_elegido = 0

f_activar_campo(em_fechadesde)


end event

on w_con_balance_viejo.create
int iCurrent
call super::create
this.gb_nivel=create gb_nivel
this.gb_cuenta=create gb_cuenta
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.gb_1=create gb_1
this.cb_consulta=create cb_consulta
this.em_fechahasta=create em_fechahasta
this.st_1=create st_1
this.dw_listado=create dw_listado
this.gb_2=create gb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.uo_1=create uo_1
this.em_cuentadesde=create em_cuentadesde
this.st_2=create st_2
this.em_cuentahasta=create em_cuentahasta
this.em_nivel=create em_nivel
this.dw_ayuda_nivel=create dw_ayuda_nivel
this.dw_1=create dw_1
this.cb_det=create cb_det
this.cb_todos=create cb_todos
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_nivel
this.Control[iCurrent+2]=this.gb_cuenta
this.Control[iCurrent+3]=this.pb_2
this.Control[iCurrent+4]=this.em_fechadesde
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.cb_consulta
this.Control[iCurrent+7]=this.em_fechahasta
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.dw_listado
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.pb_imprimir_preli
this.Control[iCurrent+12]=this.uo_1
this.Control[iCurrent+13]=this.em_cuentadesde
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.em_cuentahasta
this.Control[iCurrent+16]=this.em_nivel
this.Control[iCurrent+17]=this.dw_ayuda_nivel
this.Control[iCurrent+18]=this.dw_1
this.Control[iCurrent+19]=this.cb_det
this.Control[iCurrent+20]=this.cb_todos
this.Control[iCurrent+21]=this.dw_2
end on

on w_con_balance_viejo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_nivel)
destroy(this.gb_cuenta)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.gb_1)
destroy(this.cb_consulta)
destroy(this.em_fechahasta)
destroy(this.st_1)
destroy(this.dw_listado)
destroy(this.gb_2)
destroy(this.pb_imprimir_preli)
destroy(this.uo_1)
destroy(this.em_cuentadesde)
destroy(this.st_2)
destroy(this.em_cuentahasta)
destroy(this.em_nivel)
destroy(this.dw_ayuda_nivel)
destroy(this.dw_1)
destroy(this.cb_det)
destroy(this.cb_todos)
destroy(this.dw_2)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_balance_viejo
integer x = 800
integer y = 816
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_balance_viejo
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_balance_viejo
integer y = 20
integer width = 2642
end type

type gb_nivel from groupbox within w_con_balance_viejo
integer x = 1463
integer y = 116
integer width = 430
integer height = 184
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Nivel"
end type

type gb_cuenta from groupbox within w_con_balance_viejo
integer x = 649
integer y = 116
integer width = 814
integer height = 184
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Cuenta"
end type

type pb_2 from upb_salir within w_con_balance_viejo
integer x = 2743
integer y = 8
integer width = 128
integer height = 112
integer taborder = 0
end type

type em_fechadesde from u_em_campo within w_con_balance_viejo
integer x = 14
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

type gb_1 from groupbox within w_con_balance_viejo
integer x = 9
integer y = 116
integer width = 640
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

type cb_consulta from u_boton within w_con_balance_viejo
integer x = 1925
integer y = 184
integer width = 334
integer height = 92
integer taborder = 60
boolean bringtotop = true
string facename = "Arial"
string text = "Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)

dw_1.visible   = TRUE
end event

type em_fechahasta from u_em_campo within w_con_balance_viejo
integer x = 347
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

type st_1 from statictext within w_con_balance_viejo
integer x = 288
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

type dw_listado from datawindow within w_con_balance_viejo
boolean visible = false
integer x = 2318
integer y = 40
integer width = 329
integer height = 128
boolean bringtotop = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type gb_2 from groupbox within w_con_balance_viejo
integer x = 1902
integer y = 120
integer width = 384
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type pb_imprimir_preli from picturebutton within w_con_balance_viejo
integer x = 2757
integer y = 196
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

event clicked;//f_cargar(dw_2)
//Parent.TriggerEvent("ue_listar")
//dw_2.visible = FALSE


dw_2.visible = false

dw_2.settransobject(sqlca)


datetime fdesde_ejer,fhasta_ejer
fdesde_ejer =datetime(date(em_fechadesde.text))
fhasta_ejer =datetime(date(em_fechahasta.text))
string cuenta_desde,cuenta_hasta

//-------------- ATENCIÓN ---------------------------------------------- 
// El ejercicio es desde la fecha inicial a la final(pedidas en pantalla)
// Son las variables fdesde_ejer y fhasta_ejer

// El periodo es sólo el mes de la fecha hasta(de la pantalla)
// Son las variables fdesde_periodo y fhasta_periodo

// PARA CAMBIAR EL ALCANCE DE PERIODO Y EJERCICIO MODIFICAR SÓLO ESAS 
// VARIABLES

int dias,mes,el_any
datetime fdesde_periodo,fhasta_periodo
mes = month(date(fhasta_ejer))
el_any = year(date(fhasta_ejer))
fdesde_periodo = datetime(date("1/" + string(mes) +"/" +string(el_any)))

// días del mes. Función de ventana 
dias = dias_mes(mes,year(date(fhasta_ejer)))

fhasta_periodo = datetime(date(string(dias)+"/" + string(mes) +"/" +string(el_any)))



// Si no hay nada obtenemos para todas las cuentas y todos los niveles
if em_cuentadesde.text = "" then
   cuenta_desde = "1"
 else
	cuenta_desde=em_cuentadesde.text
end if

if em_cuentahasta.text = "" then
	cuenta_hasta = "9"
else
	cuenta_hasta=em_cuentahasta.text
end if

// En open nivel_elegido := 0 
if nivel_elegido = 0 then
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

	// En nivel el máximo
	nivel_elegido = niveles
end if


//dw_2.Modify("DataWindow.detail.Height=0")
//dw_2.Modify("DataWindow.trailer.5.Height=0")
//dw_2.Modify("DataWindow.trailer.4.Height=0")
//dw_2.Modify("DataWindow.trailer.3.Height=0")
//dw_2.Modify("DataWindow.trailer.2.Height=0")
//dw_2.Modify("DataWindow.trailer.1.Height=0")

// según los niveles se hace el retrieve

choose case nivel_elegido
		
	case 5 
		dw_2.retrieve(anyo,codigo_empresa,dig[5],dig[4],dig[3],dig[2],dig[1],fdesde_periodo,fhasta_periodo,fdesde_ejer,fhasta_ejer,cuenta_desde,cuenta_hasta)
      // mostramos todos
//		dw_2.Modify("DataWindow.header.5.Height=69")
//		dw_2.Modify("DataWindow.header.4.Height=69")
//		dw_2.Modify("DataWindow.header.3.Height=69")
//		dw_2.Modify("DataWindow.header.2.Height=69")
//		dw_2.Modify("DataWindow.header.1.Height=69")
   case 4
      dw_2.retrieve(anyo,codigo_empresa,dig[4],dig[3],dig[2],dig[1],dig[1],fdesde_periodo,fhasta_periodo,fdesde_ejer,fhasta_ejer,cuenta_desde,cuenta_hasta)
		// el último no lo mostramos
		dw_2.Modify("DataWindow.header.5.Height=69")
		dw_2.Modify("DataWindow.header.4.Height=69")
		dw_2.Modify("DataWindow.header.3.Height=69")
		dw_2.Modify("DataWindow.header.2.Height=69")
		
		dw_2.Modify("DataWindow.header.1.Height=0")


	case 3
		dw_2.retrieve(anyo,codigo_empresa,dig[3],dig[2],dig[1],dig[1],dig[1],fdesde_periodo,fhasta_periodo,fdesde_ejer,fhasta_ejer,cuenta_desde,cuenta_hasta)
	   dw_2.Modify("DataWindow.header.5.Height=69")
		dw_2.Modify("DataWindow.header.4.Height=69")
		dw_2.Modify("DataWindow.header.3.Height=69")		
		dw_2.Modify("DataWindow.header.2.Height=0")
		dw_2.Modify("DataWindow.header.1.Height=0")
	case 2
      dw_2.retrieve(anyo,codigo_empresa,dig[2],dig[1],dig[1],dig[1],dig[1],fdesde_periodo,fhasta_periodo,fdesde_ejer,fhasta_ejer,cuenta_desde,cuenta_hasta)		
      dw_2.Modify("DataWindow.header.5.Height=69")
		dw_2.Modify("DataWindow.header.4.Height=69")		
		dw_2.Modify("DataWindow.header.3.Height=0")
		dw_2.Modify("DataWindow.header.2.Height=0")
		dw_2.Modify("DataWindow.header.1.Height=0")
	case 1
  		 dw_2.retrieve(anyo,codigo_empresa,dig[1],dig[1],dig[1],dig[1],dig[1],fdesde_periodo,fhasta_periodo,fdesde_ejer,fhasta_ejer,cuenta_desde,cuenta_hasta)
       dw_2.Modify("DataWindow.header.5.Height=69")
		 dw_2.Modify("DataWindow.header.4.Height=0")
		 dw_2.Modify("DataWindow.header.3.Height=0")
  		 dw_2.Modify("DataWindow.header.2.Height=0")
	    dw_2.Modify("DataWindow.header.1.Height=0")
end choose

f_imprimir_datawindow(dw_2)

end event

type uo_1 from u_manejo_datawindow within w_con_balance_viejo
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

type em_cuentadesde from u_em_campo within w_con_balance_viejo
integer x = 667
integer y = 196
integer width = 357
integer taborder = 30
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#########"
string displaydata = ""
end type

type st_2 from statictext within w_con_balance_viejo
integer x = 1029
integer y = 168
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

type em_cuentahasta from u_em_campo within w_con_balance_viejo
integer x = 1093
integer y = 200
integer width = 357
integer taborder = 40
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#########"
string displaydata = ""
end type

type em_nivel from u_em_campo within w_con_balance_viejo
integer x = 1490
integer y = 196
integer width = 142
integer taborder = 50
boolean bringtotop = true
alignment alignment = right!
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
    INTO :niveles,:dig[1],:dig[2],:dig[3],   
         :dig[4],:dig[5],:dig[6],:dig[7],   
         :dig[8],:dig[9]  
    FROM contaparam  
   WHERE ( contaparam.ejercicio = :anyo ) AND  
         ( contaparam.empresa = :codigo_empresa )   ;

nivel_elegido = integer(em_nivel.text)			
			
if niveles< nivel_elegido then 
	messagebox("Nivel Incorrecto","El máximo nivel es "+string(niveles))
	this.triggerevent("tecla_enter")
	return
end if
   // Dígitos del max nivel elegido
	digitos = dig[integer(em_nivel.text)]
   // Dígitos del siguiente nivel
	if integer(em_nivel.text)>1 then
		digitos_menor=dig[integer(em_nivel.text)-1]
		dw_1.reset()
		dw_listado.reset()
		//dw_1.Modify("DataWindow.Trailer.2.Height=69")
		//dw_listado.Modify("DataWindow.Trailer.2.Height=69")
		cb_det.enabled=true
	else
		digitos_menor=dig[integer(1)]
		dw_1.reset()
		dw_listado.reset()
		//dw_1.Modify("DataWindow.Trailer.2.Height=0")
		//dw_listado.Modify("DataWindow.Trailer.2.Height=0")
		cb_det.enabled=false
	end if

cb_det.text="Totales"




return
end event

event rbuttondown;f_ayuda_nivel()
return
end event

event tecla_enter;f_ayuda_nivel()
return
end event

type dw_ayuda_nivel from datawindow within w_con_balance_viejo
boolean visible = false
integer x = 1463
integer y = 308
integer width = 393
integer height = 296
boolean bringtotop = true
string dataobject = "dw_especial_ayuda_nivel"
borderstyle borderstyle = styleraised!
end type

event clicked;
if row <= 0 then return
em_nivel.text=string(getItemNumber(row,"nivel"))
em_nivel.triggerevent("modificado")
em_nivel.setfocus()
this.visible=false

end event

type dw_1 from datawindow within w_con_balance_viejo
integer x = 23
integer y = 324
integer width = 2871
integer height = 1132
string dataobject = "dw_con_balance"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_det from u_boton within w_con_balance_viejo
event clicked pbm_bnclicked
boolean visible = false
integer x = 2624
integer y = 24
integer width = 101
integer height = 68
integer taborder = 0
boolean bringtotop = true
string facename = "Arial"
string text = "Totales"
end type

event clicked;call super::clicked;//	if cb_det.text="Totales" then
//		cb_det.text="Detalles"
//		dw_1.Modify("DataWindow.Trailer.2.Height=0")
//		dw_listado.Modify("DataWindow.Trailer.2.Height=0") 
//	else
//		cb_det.text="Totales"
//		dw_1.Modify("DataWindow.Trailer.2.Height=69")
//		dw_listado.Modify("DataWindow.Trailer.2.Height=69") 
//	end if
end event

type cb_todos from commandbutton within w_con_balance_viejo
integer x = 1650
integer y = 196
integer width = 219
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string text = "Todos"
end type

event clicked;SELECT contaparam.niveles,contaparam.digitos1,   
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

nivel_elegido = niveles

em_nivel.text = string(nivel_elegido)
			
end event

type dw_2 from datawindow within w_con_balance_viejo
boolean visible = false
integer x = 18
integer y = 4
integer width = 695
integer height = 164
integer taborder = 41
boolean bringtotop = true
string dataobject = "report_balance"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

