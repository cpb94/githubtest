$PBExportHeader$w_con_diario.srw
$PBExportComments$Consulta/Listado Diario de apuntes €
forward
global type w_con_diario from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_diario
end type
type cb_consulta from u_boton within w_con_diario
end type
type st_1 from statictext within w_con_diario
end type
type cb_concepto from u_boton within w_con_diario
end type
type dw_listado from datawindow within w_con_diario
end type
type gb_2 from groupbox within w_con_diario
end type
type uo_tipo2 from u_marca_lista within w_con_diario
end type
type dw_proceso2 from datawindow within w_con_diario
end type
type dw_1 from datawindow within w_con_diario
end type
type uo_perid from u_em_campo_2 within w_con_diario
end type
type uo_perih from u_em_campo_2 within w_con_diario
end type
type st_2 from statictext within w_con_diario
end type
type uo_asienh from u_em_campo within w_con_diario
end type
type uo_asiend from u_em_campo within w_con_diario
end type
type gb_cuenta from groupbox within w_con_diario
end type
type gb_1 from groupbox within w_con_diario
end type
type pb_imprimir_preli from picturebutton within w_con_diario
end type
type em_asiento_inicial from editmask within w_con_diario
end type
type st_3 from statictext within w_con_diario
end type
type em_pagina_inicial from editmask within w_con_diario
end type
type st_4 from statictext within w_con_diario
end type
type uo_ejer from u_em_campo_2 within w_con_diario
end type
type gb_3 from groupbox within w_con_diario
end type
end forward

global type w_con_diario from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3470
integer height = 1656
string title = "Consulta de Movimientos"
pb_2 pb_2
cb_consulta cb_consulta
st_1 st_1
cb_concepto cb_concepto
dw_listado dw_listado
gb_2 gb_2
uo_tipo2 uo_tipo2
dw_proceso2 dw_proceso2
dw_1 dw_1
uo_perid uo_perid
uo_perih uo_perih
st_2 st_2
uo_asienh uo_asienh
uo_asiend uo_asiend
gb_cuenta gb_cuenta
gb_1 gb_1
pb_imprimir_preli pb_imprimir_preli
em_asiento_inicial em_asiento_inicial
st_3 st_3
em_pagina_inicial em_pagina_inicial
st_4 st_4
uo_ejer uo_ejer
gb_3 gb_3
end type
global w_con_diario w_con_diario

type variables
String ante_articulo,retrasos
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer registros
long cont,contador,ant_asiento,total,asiento_ini,pag_ini
dw_data.SetTransObject(sqlca)
dw_data.reset()
dw_data.visible   = FALSE
uo_tipo2.visible  = FALSE

string con[100]
Integer numero,i,j=0

numero = uo_tipo2.dw_marca.RowCount()
IF numero <> 0  Then 
	FOR i = 1 To numero
   	IF uo_tipo2.dw_marca.GetItemString(i,"marca") = "S" THEN
      j=j+1
		con[j]=uo_tipo2.dw_marca.GetItemString(i,"codigo")
		END IF
	NEXT
	IF j=0 THEN
		FOR i = 1 To numero
   		con[i]=uo_tipo2.dw_marca.GetItemString(i,"codigo")
			j=numero
		NEXT
		
	END IF
	FOR i = j+1 TO 30
		con[i]=""
	NEXT
END IF
	
tipo_array debe_haber
long perid,perih, asiend, asienh
integer ejer
dec debe,haber,saldo_inicial
integer ini
if Dec(Trim(uo_asiend.text)) < 0 then
	messagebox("Atención","Debe introducir el asiento inicial")
	uo_asiend.setfocus()
	return
end if
if Dec(Trim(uo_asienh.text)) < 0 or (Dec(Trim(uo_asienh.text)) < Dec(Trim(uo_asiend.text)))then
	messagebox("Atención","Debe introducir el asiento Final")
	uo_asienh.setfocus()
	return
end if

perid=Dec(Trim(uo_perid.em_codigo.text))
perih=Dec(Trim(uo_perih.em_codigo.text))
asiend = Dec(Trim(uo_asiend.text))
asienh = Dec(Trim(uo_asienh.text))
//ejer= f_ejercicio_activo(codigo_empresa)
ejer= Dec(Trim(uo_ejer.em_campo.text))

//IF asienh = 0 or IsNull(asienh) THEN
//	CHOOSE CASE asiend
//		CASE IS < 1000		
//				asienh = 999
//		CASE IS < 2000		
//				asienh = 1999
//		CASE IS < 3000		
//				asienh = 2999
//		CASE IS < 4000		
//				asienh = 3999
//		CASE IS < 5000		
//				asienh = 4999
//		CASE IS < 6000		
//				asienh = 5999
//		CASE IS < 7000		
//				asienh = 6999
//		CASE IS < 8000		
//				asienh = 7999
//		CASE IS < 9000		
//				asienh = 8999
//		CASE IS < 10000	
//				asienh = 9999
//	END CHOOSE
//END IF

IF perih = 0 OR IsNull(perih) THEN
	perih = 12
END IF

if em_pagina_inicial.text='' then
	pag_ini=0
else
	pag_ini=long(em_pagina_inicial.text)
end if

if em_asiento_inicial.text='' then
	asiento_ini=0
else
	asiento_ini=long(em_asiento_inicial.text)
end if

registros = dw_data.Retrieve(codigo_empresa,ejer,perid,perih,asiend,asienh,pag_ini)

If registros = 0 Then 
	Return
else
	contador=asiento_ini
	ant_asiento=0
	total=dw_data.rowcount()
	for cont=1 to total
		f_mensaje_proceso("Procesando...",cont,total)
		if dw_data.object.asiento[cont]<>ant_asiento then
			ant_asiento=dw_data.object.asiento[cont]
			contador++
		end if
		dw_data.object.cont[cont]=contador		
	next
end if


end subroutine

event ue_listar;dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;This.title = " DIARIO CONTABLE"

Integer x2,registros2 
String var_codigo2,var_texto2,marca2
dw_proceso2.SetTransObject(SQLCA)
registros2=dw_proceso2.retrieve(codigo_empresa)
If registros2<>0 THEN
 FOR x2= 1 To registros2
  var_codigo2  = dw_proceso2.GetItemString(x2,"codigo")
  var_texto2   = dw_proceso2.GetItemString(x2,"descripcion")
  marca2="S"
  uo_tipo2.dw_marca.InsertRow(x2)
  uo_tipo2.dw_marca.setitem(x2,"marca",marca2)
  uo_tipo2.dw_marca.setitem(x2,"codigo",var_codigo2)
  uo_tipo2.dw_marca.setitem(x2,"texto",var_texto2)
NEXT
END IF
uo_tipo2.st_titulo1.text="Concepto"
uo_tipo2.st_titulo2.text="Descripcion"
uo_asiend.text = "0"
uo_asienh.text = "999999"
f_activar_campo(uo_ejer.em_campo)


end event

on w_con_diario.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.st_1=create st_1
this.cb_concepto=create cb_concepto
this.dw_listado=create dw_listado
this.gb_2=create gb_2
this.uo_tipo2=create uo_tipo2
this.dw_proceso2=create dw_proceso2
this.dw_1=create dw_1
this.uo_perid=create uo_perid
this.uo_perih=create uo_perih
this.st_2=create st_2
this.uo_asienh=create uo_asienh
this.uo_asiend=create uo_asiend
this.gb_cuenta=create gb_cuenta
this.gb_1=create gb_1
this.pb_imprimir_preli=create pb_imprimir_preli
this.em_asiento_inicial=create em_asiento_inicial
this.st_3=create st_3
this.em_pagina_inicial=create em_pagina_inicial
this.st_4=create st_4
this.uo_ejer=create uo_ejer
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_concepto
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.uo_tipo2
this.Control[iCurrent+8]=this.dw_proceso2
this.Control[iCurrent+9]=this.dw_1
this.Control[iCurrent+10]=this.uo_perid
this.Control[iCurrent+11]=this.uo_perih
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.uo_asienh
this.Control[iCurrent+14]=this.uo_asiend
this.Control[iCurrent+15]=this.gb_cuenta
this.Control[iCurrent+16]=this.gb_1
this.Control[iCurrent+17]=this.pb_imprimir_preli
this.Control[iCurrent+18]=this.em_asiento_inicial
this.Control[iCurrent+19]=this.st_3
this.Control[iCurrent+20]=this.em_pagina_inicial
this.Control[iCurrent+21]=this.st_4
this.Control[iCurrent+22]=this.uo_ejer
this.Control[iCurrent+23]=this.gb_3
end on

on w_con_diario.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.st_1)
destroy(this.cb_concepto)
destroy(this.dw_listado)
destroy(this.gb_2)
destroy(this.uo_tipo2)
destroy(this.dw_proceso2)
destroy(this.dw_1)
destroy(this.uo_perid)
destroy(this.uo_perih)
destroy(this.st_2)
destroy(this.uo_asienh)
destroy(this.uo_asiend)
destroy(this.gb_cuenta)
destroy(this.gb_1)
destroy(this.pb_imprimir_preli)
destroy(this.em_asiento_inicial)
destroy(this.st_3)
destroy(this.em_pagina_inicial)
destroy(this.st_4)
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

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_diario
integer x = 489
integer y = 636
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_diario
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_diario
integer y = 20
integer width = 3387
end type

type pb_2 from upb_salir within w_con_diario
integer x = 3282
integer y = 136
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type cb_consulta from u_boton within w_con_diario
integer x = 2679
integer y = 260
integer width = 270
integer height = 84
integer taborder = 80
boolean bringtotop = true
string facename = "Arial"
string text = "C&onsulta"
end type

event clicked;f_cargar(dw_1)

//if rb_si.checked=true then
//	dw_1.Object.DataWindow.header.Height = 185
//else
//	dw_1.Object.DataWindow.header.Height = 81
//end if
	
dw_1.visible   = TRUE
end event

type st_1 from statictext within w_con_diario
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

type cb_concepto from u_boton within w_con_diario
event clicked pbm_bnclicked
integer x = 2437
integer y = 260
integer width = 238
integer height = 84
integer taborder = 0
boolean bringtotop = true
string facename = "Arial"
string text = "Tipos"
end type

event clicked;call super::clicked;dw_1.visible=false
uo_tipo2.visible=true
end event

type dw_listado from datawindow within w_con_diario
boolean visible = false
integer width = 151
integer height = 196
boolean bringtotop = true
string dataobject = "report_con_diario"
boolean livescroll = true
end type

type gb_2 from groupbox within w_con_diario
integer x = 2423
integer y = 224
integer width = 654
integer height = 132
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type uo_tipo2 from u_marca_lista within w_con_diario
boolean visible = false
integer x = 1225
integer y = 356
integer width = 1454
integer height = 652
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type dw_proceso2 from datawindow within w_con_diario
boolean visible = false
integer x = 530
integer y = 24
integer width = 530
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_contaconcepto"
boolean livescroll = true
end type

type dw_1 from datawindow within w_con_diario
boolean visible = false
integer x = 9
integer y = 464
integer width = 2857
integer height = 976
string dataobject = "dw_con_diario"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;	str_parametros zstr_param
  	zstr_param.i_nargumentos=5
 	zstr_param.s_argumentos[2]=String(dw_1.GetitemNumber(row,"contaapun_ejercicio"))
 	zstr_param.s_argumentos[3]=dw_1.GetItemString(row,"contaapun_origen")
 	zstr_param.s_argumentos[4]=string(date(dw_1.GetItemDatetime(row,"fapunte")))
	zstr_param.s_argumentos[5]=string(dw_1.GetItemNumber(row,"asiento"))

  
  
  
  
  OpenWithParm(w_int_contaapun,zstr_param) 


end event

type uo_perid from u_em_campo_2 within w_con_diario
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

type uo_perih from u_em_campo_2 within w_con_diario
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

type st_2 from statictext within w_con_diario
integer x = 2034
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

type uo_asienh from u_em_campo within w_con_diario
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 2117
integer y = 236
integer taborder = 50
alignment alignment = right!
end type

event getfocus;call super::getfocus;ue_titulo = "Selección de Cuentas"
ue_datawindow ="dw_ayuda_contaplan_directo"

end event

event modificado;call super::modificado;IF Dec(uo_asienh.text) <> 0 THEN Return

		// Si asiento hasta no tiene valor se lo asigno segun el asiento 
		// de inicio pues no tengo el origen para saber el ultimo nº
	CHOOSE CASE Dec(uo_asiend.text)
		CASE IS < 1000		
				uo_asienh.text = "999"
		CASE IS < 2000		
				uo_asienh.text = "1999"
		CASE IS < 3000		
				uo_asienh.text = "2999"
		CASE IS < 4000		
				uo_asienh.text = "3999"
		CASE IS < 5000		
				uo_asienh.text = "4999"
		CASE IS < 6000		
				uo_asienh.text = "5999"
		CASE IS < 7000		
				uo_asienh.text = "6999"
		CASE IS < 8000		
				uo_asienh.text = "7999"
		CASE IS < 9000		
				uo_asienh.text = "8999"
		CASE IS < 10000	
				uo_asienh.text = "9999"
	END CHOOSE


end event

type uo_asiend from u_em_campo within w_con_diario
integer x = 1751
integer y = 236
integer taborder = 40
boolean bringtotop = true
alignment alignment = right!
end type

event getfocus;call super::getfocus;ue_titulo = "Selección de Cuentas"
ue_datawindow ="dw_ayuda_contaplan_directo"

end event

type gb_cuenta from groupbox within w_con_diario
integer x = 1669
integer y = 176
integer width = 750
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Nº Asiento"
end type

type gb_1 from groupbox within w_con_diario
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

type pb_imprimir_preli from picturebutton within w_con_diario
integer x = 2953
integer y = 256
integer width = 105
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\print.bmp"
end type

event clicked;f_cargar(dw_listado)
Parent.TriggerEvent("ue_listar")
dw_listado.visible = FALSE
end event

type em_asiento_inicial from editmask within w_con_diario
integer x = 2665
integer y = 144
integer width = 183
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type st_3 from statictext within w_con_diario
integer x = 2432
integer y = 156
integer width = 229
integer height = 68
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
string text = "Asiento:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_pagina_inicial from editmask within w_con_diario
integer x = 3008
integer y = 144
integer width = 183
integer height = 80
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type st_4 from statictext within w_con_diario
integer x = 2862
integer y = 156
integer width = 137
integer height = 68
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
string text = "Pag.:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_ejer from u_em_campo_2 within w_con_diario
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

type gb_3 from groupbox within w_con_diario
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

