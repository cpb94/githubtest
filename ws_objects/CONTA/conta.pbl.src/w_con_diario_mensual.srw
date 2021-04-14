$PBExportHeader$w_con_diario_mensual.srw
$PBExportComments$€
forward
global type w_con_diario_mensual from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_diario_mensual
end type
type cb_consulta from u_boton within w_con_diario_mensual
end type
type st_1 from statictext within w_con_diario_mensual
end type
type dw_listado from datawindow within w_con_diario_mensual
end type
type gb_2 from groupbox within w_con_diario_mensual
end type
type dw_1 from datawindow within w_con_diario_mensual
end type
type uo_perid from u_em_campo_2 within w_con_diario_mensual
end type
type uo_perih from u_em_campo_2 within w_con_diario_mensual
end type
type gb_1 from groupbox within w_con_diario_mensual
end type
type pb_imprimir_preli from picturebutton within w_con_diario_mensual
end type
type uo_ejer from u_em_campo_2 within w_con_diario_mensual
end type
type gb_3 from groupbox within w_con_diario_mensual
end type
end forward

global type w_con_diario_mensual from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3438
integer height = 2204
string title = "Consulta de Movimientos"
pb_2 pb_2
cb_consulta cb_consulta
st_1 st_1
dw_listado dw_listado
gb_2 gb_2
dw_1 dw_1
uo_perid uo_perid
uo_perih uo_perih
gb_1 gb_1
pb_imprimir_preli pb_imprimir_preli
uo_ejer uo_ejer
gb_3 gb_3
end type
global w_con_diario_mensual w_con_diario_mensual

type variables
String ante_articulo,retrasos
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer registros,ejer,i,indice,ejercicio,mes
Long    perid,perih,total,donde,tipo
Dec{2}  deb,hab,debe,haber
String  sel,cuenta
Datastore datos

perid=Dec(Trim(uo_perid.em_codigo.text))
perih=Dec(Trim(uo_perih.em_codigo.text))
ejer= Dec(Trim(uo_ejer.em_campo.text))

IF perid > perih THEN
	messagebox("Atención","El mes hasta no puede ser inferior al mes desde")
	f_activar_campo(uo_perid.em_codigo)
	return
END IF

dw_data.SetTransObject(sqlca)
dw_data.reset()
dw_data.visible   = FALSE
dw_data.retrieve(codigo_empresa,ejer,perid,perih)
for i = perid to perih
	if i = 1 then
		// Buscar asiento de apertura
		sel = "select ejercicio,mes,cuenta,sum(debe) deb,sum(haber) hab "+&
				"from   contaapun "+&
				"where  empresa = '"+codigo_empresa+"' "+&
				"and    ejercicio = "+string(ejer,"####")+" "+&
				"and    mes = 1 "+&
				"and    origen = '101' "+&
				"group  by ejercicio,mes,cuenta"
		//datos = f_cargar_cursor(sel)		
		f_cargar_cursor_nuevo(sel, datos)
		total = datos.rowcount()
		for indice = 1 to total
			f_mensaje_proceso("Cargando Asiento de Apertura",indice,total)
			
			ejercicio   = datos.object.ejercicio[indice]
			mes         = datos.object.mes[indice]
			cuenta      = datos.object.cuenta[indice]
			debe        = datos.object.deb[indice]
			haber       = datos.object.hab[indice]
			tipo        = 1
						
			if isnull(debe)  then debe = 0
			if isnull(haber) then haber = 0
			
			donde   = dw_data.find("tipo = "+string(tipo)+" and cuenta = '"+cuenta+"' ",1,dw_data.rowcount())
			if donde > 0 then
				dw_data.object.debe[donde]  = dw_data.object.debe[donde]  + debe
				dw_data.object.haber[donde] = dw_data.object.haber[donde] + haber
			else
				donde = dw_data.insertrow(0)
				dw_data.object.empresa[donde] = codigo_empresa
				dw_data.object.mes[donde]     = 1
				dw_data.object.fapunte[donde] = datetime(date("01/01/"+string(ejer,"####")))
				dw_data.object.cuenta[donde]  = cuenta
				dw_data.object.debe[donde]    = debe
				dw_data.object.haber[donde]   = haber
				dw_data.object.tipo[donde]    = tipo
			end if
		next
		destroy datos
		// Buscar Enero
		sel = "select ejercicio,mes,cuenta,sum(debe) deb,sum(haber) hab "+&
					"from   contaapun "+&
					"where  empresa = '"+codigo_empresa+"' "+&
					"and    ejercicio = "+string(ejer,"####")+" "+&
					"and    mes = 1 "+&
					"and    origen <> '102' "+&
					"and    origen <> '104' "+&
					"and    origen <> '101' "+&
					"and    origen <> '100' "+&
					"group  by ejercicio,mes,cuenta"
					
			//datos = f_cargar_cursor(sel)	
			f_cargar_cursor_nuevo(sel, datos)
			total = datos.rowcount()
			for indice = 1 to total
				f_mensaje_proceso("Cargando Asiento del Mes 1",indice,total)
				
				ejercicio   = datos.object.ejercicio[indice]
				mes         = datos.object.mes[indice]
				cuenta      = datos.object.cuenta[indice]
				debe        = datos.object.deb[indice]
				haber       = datos.object.hab[indice]
				tipo        = 2
							
				if isnull(debe)  then debe = 0
				if isnull(haber) then haber = 0
				
				donde   = dw_data.find("tipo = "+string(tipo)+" and cuenta = '"+cuenta+"' ",1,dw_data.rowcount())
				if donde > 0 then
					dw_data.object.debe[donde]  = dw_data.object.debe[donde]  + debe
					dw_data.object.haber[donde] = dw_data.object.haber[donde] + haber
				else
					donde = dw_data.insertrow(0)
					dw_data.object.empresa[donde] = codigo_empresa
					dw_data.object.mes[donde]     = mes
					dw_data.object.fapunte[donde] = datetime(date("01/"+string(mes,"##")+"/"+string(ejer,"####")))
					dw_data.object.cuenta[donde]  = cuenta
					dw_data.object.debe[donde]    = debe
					dw_data.object.haber[donde]   = haber
					dw_data.object.tipo[donde]    = tipo
				end if
			next		
			destroy datos
	else
		if i = 12 then
			// Buscar asiento de regularizacion
			sel = "select ejercicio,mes,cuenta,sum(debe) deb,sum(haber) hab "+&
					"from   contaapun "+&
					"where  empresa = '"+codigo_empresa+"' "+&
					"and    ejercicio = "+string(ejer,"####")+" "+&
					"and    mes = 12 "+&
					"and    origen = '104' "+&
					"group  by ejercicio,mes,cuenta"
					
			//datos = f_cargar_cursor(sel)		
			f_cargar_cursor_nuevo(sel, datos)
			total = datos.rowcount()
			for indice = 1 to total
				f_mensaje_proceso("Cargando Asiento de Regularización",indice,total)
				
				ejercicio   = datos.object.ejercicio[indice]
				mes         = datos.object.mes[indice]
				cuenta      = datos.object.cuenta[indice]
				debe        = datos.object.deb[indice]
				haber       = datos.object.hab[indice]
				tipo        = 14
							
				if isnull(debe)  then debe = 0
				if isnull(haber) then haber = 0
				
				donde   = dw_data.find("tipo = "+string(tipo)+" and cuenta = '"+cuenta+"' ",1,dw_data.rowcount())
				if donde > 0 then
					dw_data.object.debe[donde]  = dw_data.object.debe[donde]  + debe
					dw_data.object.haber[donde] = dw_data.object.haber[donde] + haber
				else
					donde = dw_data.insertrow(0)
					dw_data.object.empresa[donde] = codigo_empresa
					dw_data.object.mes[donde]     = 15
					dw_data.object.fapunte[donde] = datetime(date("31/12/"+string(ejer,"####")))
					dw_data.object.cuenta[donde]  = cuenta
					dw_data.object.debe[donde]    = debe
					dw_data.object.haber[donde]   = haber
					dw_data.object.tipo[donde]    = tipo
				end if
			next		
			destroy datos
			
			// Buscar asiento de cierre
			sel = "select ejercicio,mes,cuenta,sum(debe) deb,sum(haber) hab "+&
					"from   contaapun "+&
					"where  empresa = '"+codigo_empresa+"' "+&
					"and    ejercicio = "+string(ejer,"####")+" "+&
					"and    mes = 12 "+&
					"and    origen = '100' "+&
					"group  by ejercicio,mes,cuenta"
					
			//datos = f_cargar_cursor(sel)		
			f_cargar_cursor_nuevo(sel, datos)
			total = datos.rowcount()
			for indice = 1 to total
				f_mensaje_proceso("Cargando Asiento de Cierre",indice,total)
				
				ejercicio   = datos.object.ejercicio[indice]
				mes         = datos.object.mes[indice]
				cuenta      = datos.object.cuenta[indice]
				debe        = datos.object.deb[indice]
				haber       = datos.object.hab[indice]
				tipo        = 16
							
				if isnull(debe)  then debe = 0
				if isnull(haber) then haber = 0
				
				donde   = dw_data.find("tipo = "+string(tipo)+" and cuenta = '"+cuenta+"' ",1,dw_data.rowcount())
				if donde > 0 then
					dw_data.object.debe[donde]  = dw_data.object.debe[donde]  + debe
					dw_data.object.haber[donde] = dw_data.object.haber[donde] + haber
				else
					donde = dw_data.insertrow(0)
					dw_data.object.empresa[donde] = codigo_empresa
					dw_data.object.mes[donde]     = 14
					dw_data.object.fapunte[donde] = datetime(date("31/12/"+string(ejer,"####")))
					dw_data.object.cuenta[donde]  = cuenta
					dw_data.object.debe[donde]    = debe
					dw_data.object.haber[donde]   = haber
					dw_data.object.tipo[donde]    = tipo
				end if
			next		
			destroy datos
					
			// Buscar asiento de pp y gg
			sel = "select ejercicio,mes,cuenta,sum(debe) deb,sum(haber) hab "+&
					"from   contaapun "+&
					"where  empresa = '"+codigo_empresa+"' "+&
					"and    ejercicio = "+string(ejer,"####")+" "+&
					"and    mes = 12 "+&
					"and    origen = '102' "+&
					"group  by ejercicio,mes,cuenta"
					
			//datos = f_cargar_cursor(sel)		
			f_cargar_cursor_nuevo(sel, datos)
			total = datos.rowcount()
			for indice = 1 to total
				f_mensaje_proceso("Cargando Asiento de PPyGG",indice,total)
				
				ejercicio   = datos.object.ejercicio[indice]
				mes         = datos.object.mes[indice]
				cuenta      = datos.object.cuenta[indice]
				debe        = datos.object.deb[indice]
				haber       = datos.object.hab[indice]
				tipo        = 15
							
				if isnull(debe)  then debe = 0
				if isnull(haber) then haber = 0
				
				donde   = dw_data.find("tipo = "+string(tipo)+" and cuenta = '"+cuenta+"' ",1,dw_data.rowcount())
				if donde > 0 then
					dw_data.object.debe[donde]  = dw_data.object.debe[donde]  + debe
					dw_data.object.haber[donde] = dw_data.object.haber[donde] + haber
				else
					donde = dw_data.insertrow(0)
					dw_data.object.empresa[donde] = codigo_empresa
					dw_data.object.mes[donde]     = 15
					dw_data.object.fapunte[donde] = datetime(date("31/12/"+string(ejer,"####")))
					dw_data.object.cuenta[donde]  = cuenta
					dw_data.object.debe[donde]    = debe
					dw_data.object.haber[donde]   = haber
					dw_data.object.tipo[donde]    = tipo
				end if
			next		
			destroy datos
			
			
			// Buscar Diciembre
			sel = "select ejercicio,mes,cuenta,sum(debe) deb,sum(haber) hab "+&
						"from   contaapun "+&
						"where  empresa = '"+codigo_empresa+"' "+&
						"and    ejercicio = "+string(ejer,"####")+" "+&
						"and    mes = 12 "+&
						"and    origen <> '102' "+&
						"and    origen <> '104' "+&
						"and    origen <> '101' "+&
						"and    origen <> '100' "+&
						"group  by ejercicio,mes,cuenta"
						
			//datos = f_cargar_cursor(sel)		
			f_cargar_cursor_nuevo(sel, datos)
			total = datos.rowcount()
			for indice = 1 to total
				f_mensaje_proceso("Cargando Asiento del Mes 12",indice,total)
				
				ejercicio   = datos.object.ejercicio[indice]
				mes         = datos.object.mes[indice]
				cuenta      = datos.object.cuenta[indice]
				debe        = datos.object.deb[indice]
				haber       = datos.object.hab[indice]
				tipo        = 13
							
				if isnull(debe)  then debe = 0
				if isnull(haber) then haber = 0
				
				donde   = dw_data.find("tipo = "+string(tipo)+" and cuenta = '"+cuenta+"' ",1,dw_data.rowcount())
				if donde > 0 then
					dw_data.object.debe[donde]  = dw_data.object.debe[donde]  + debe
					dw_data.object.haber[donde] = dw_data.object.haber[donde] + haber
				else
					donde = dw_data.insertrow(0)
					dw_data.object.empresa[donde] = codigo_empresa
					dw_data.object.mes[donde]     = mes
					dw_data.object.fapunte[donde] = datetime(date("01/"+string(mes,"##")+"/"+string(ejer,"####")))
					dw_data.object.cuenta[donde]  = cuenta
					dw_data.object.debe[donde]    = debe
					dw_data.object.haber[donde]   = haber
					dw_data.object.tipo[donde]    = tipo
				end if
			next		
			destroy datos
		else
			sel = "select ejercicio,mes,cuenta,sum(debe) deb,sum(haber) hab "+&
					"from   contaapun "+&
					"where  empresa = '"+codigo_empresa+"' "+&
					"and    ejercicio = "+string(ejer,"####")+" "+&
					"and    mes = "+string(i,"##")+" "+&
					"and    origen <> '102' "+&
					"and    origen <> '104' "+&
					"and    origen <> '101' "+&
					"and    origen <> '100' "+&
					"group  by ejercicio,mes,cuenta"
					
			//datos = f_cargar_cursor(sel)		
			f_cargar_cursor_nuevo(sel, datos)
			total = datos.rowcount()
			for indice = 1 to total
				f_mensaje_proceso("Cargando Asiento del Mes "+string(mes,"##"),indice,total)
				
				ejercicio   = datos.object.ejercicio[indice]
				mes         = datos.object.mes[indice]
				cuenta      = datos.object.cuenta[indice]
				debe        = datos.object.deb[indice]
				haber       = datos.object.hab[indice]
				tipo        = mes +1
							
				if isnull(debe)  then debe = 0
				if isnull(haber) then haber = 0
				
				donde   = dw_data.find("tipo = "+string(tipo)+" and cuenta = '"+cuenta+"' ",1,dw_data.rowcount())
				if donde > 0 then
					dw_data.object.debe[donde]  = dw_data.object.debe[donde]  + debe
					dw_data.object.haber[donde] = dw_data.object.haber[donde] + haber
				else
					donde = dw_data.insertrow(0)
					dw_data.object.empresa[donde] = codigo_empresa
					dw_data.object.mes[donde]     = mes
					dw_data.object.fapunte[donde] = datetime(date("01/"+string(mes,"##")+"/"+string(ejer,"####")))
					dw_data.object.cuenta[donde]  = cuenta
					dw_data.object.debe[donde]    = debe
					dw_data.object.haber[donde]   = haber
					dw_data.object.tipo[donde]    = tipo
				end if
			next		
			destroy datos
		end if
	end if
next

dw_data.sort()
dw_data.groupcalc()
dw_data.setredraw(true)
end subroutine

event open;call super::open;This.title = " DIARIO CONTABLE MENSUAL"
uo_perid.text = "1"
uo_perih.text = "12"
f_activar_campo(uo_ejer.em_campo)


end event

on w_con_diario_mensual.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.st_1=create st_1
this.dw_listado=create dw_listado
this.gb_2=create gb_2
this.dw_1=create dw_1
this.uo_perid=create uo_perid
this.uo_perih=create uo_perih
this.gb_1=create gb_1
this.pb_imprimir_preli=create pb_imprimir_preli
this.uo_ejer=create uo_ejer
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.gb_2
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.uo_perid
this.Control[iCurrent+8]=this.uo_perih
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.pb_imprimir_preli
this.Control[iCurrent+11]=this.uo_ejer
this.Control[iCurrent+12]=this.gb_3
end on

on w_con_diario_mensual.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.st_1)
destroy(this.dw_listado)
destroy(this.gb_2)
destroy(this.dw_1)
destroy(this.uo_perid)
destroy(this.uo_perih)
destroy(this.gb_1)
destroy(this.pb_imprimir_preli)
destroy(this.uo_ejer)
destroy(this.gb_3)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_diario_mensual
integer x = 46
integer y = 1312
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_diario_mensual
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_diario_mensual
integer x = 27
integer y = 20
integer width = 2889
end type

type pb_2 from upb_salir within w_con_diario_mensual
integer x = 2789
integer y = 136
integer width = 128
integer height = 112
integer taborder = 0
end type

type cb_consulta from u_boton within w_con_diario_mensual
integer x = 1691
integer y = 260
integer width = 270
integer height = 84
integer taborder = 40
boolean bringtotop = true
string facename = "Arial"
string text = "C&onsulta"
end type

event clicked;f_cargar(dw_1)	
dw_1.visible   = TRUE
end event

type st_1 from statictext within w_con_diario_mensual
integer x = 1152
integer y = 216
integer width = 46
integer height = 88
boolean bringtotop = true
integer textsize = -11
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

type dw_listado from datawindow within w_con_diario_mensual
boolean visible = false
integer x = 2158
integer y = 148
integer width = 151
integer height = 196
boolean bringtotop = true
string dataobject = "report_con_diario_mensual"
boolean livescroll = true
end type

type gb_2 from groupbox within w_con_diario_mensual
integer x = 1673
integer y = 224
integer width = 416
integer height = 132
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type dw_1 from datawindow within w_con_diario_mensual
boolean visible = false
integer x = 9
integer y = 464
integer width = 3333
integer height = 1492
string dataobject = "dw_con_diario_mensual"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;//	str_parametros zstr_param
//  	zstr_param.i_nargumentos=5
// 	zstr_param.s_argumentos[2]=String(dw_1.GetitemNumber(row,"contaapun_ejercicio"))
// 	zstr_param.s_argumentos[3]=dw_1.GetItemString(row,"contaapun_origen")
// 	zstr_param.s_argumentos[4]=string(date(dw_1.GetItemDatetime(row,"fapunte")))
//	zstr_param.s_argumentos[5]=string(dw_1.GetItemNumber(row,"asiento"))
//
//  
//  
//  
//  
//  OpenWithParm(w_int_contaapun,zstr_param) 
//
//
end event

type uo_perid from u_em_campo_2 within w_con_diario_mensual
event destroy ( )
integer x = 695
integer y = 240
integer width = 425
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_perid.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_perid.em_campo.text=f_nombre_mes(Dec(uo_perid.em_codigo.text))

IF Trim(uo_perid.em_campo.text)="" THEN 
 IF Trim(uo_perid.em_codigo.text)<>"" Then uo_perid.em_campo.SetFocus()
 uo_perid.em_campo.text=""
 uo_perid.em_codigo.text=""
END IF

end event

type uo_perih from u_em_campo_2 within w_con_diario_mensual
event destroy ( )
integer x = 1225
integer y = 236
integer width = 425
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_perih.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_perih.em_campo.text=f_nombre_mes(Dec(uo_perih.em_codigo.text))

IF Trim(uo_perih.em_campo.text)="" THEN 
 IF Trim(uo_perih.em_codigo.text)<>"" Then uo_perih.em_campo.SetFocus()
 uo_perih.em_campo.text="Diciembre"
 uo_perih.em_codigo.text="12"
END IF
 IF Dec(Trim(uo_perih.em_codigo.text)) > Dec(Trim(uo_perih.em_codigo.text))THEN
	 uo_perih.em_campo.SetFocus()
END IF
end event

type gb_1 from groupbox within w_con_diario_mensual
integer x = 645
integer y = 176
integer width = 1024
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Mes"
end type

type pb_imprimir_preli from picturebutton within w_con_diario_mensual
integer x = 1966
integer y = 260
integer width = 105
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "print!"
end type

event clicked;f_cargar(dw_listado)
f_imprimir_datawindow(dw_listado)
end event

type uo_ejer from u_em_campo_2 within w_con_diario_mensual
event destroy ( )
integer x = 110
integer y = 240
integer width = 425
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_ejer.destroy
call u_em_campo_2::destroy
end on

event modificado;//uo_ejer.em_campo.text=String(f_ejercicio_activo(codigo_empresa),"###,###")
IF Trim(uo_ejer.em_campo.text)="" THEN 
 IF Trim(uo_ejer.em_codigo.text)<>"" Then uo_ejer.em_campo.SetFocus()
 uo_ejer.em_campo.text=""
 uo_ejer.em_codigo.text=""
END IF

end event

type gb_3 from groupbox within w_con_diario_mensual
integer x = 9
integer y = 176
integer width = 631
integer height = 180
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Ejercicio"
end type

