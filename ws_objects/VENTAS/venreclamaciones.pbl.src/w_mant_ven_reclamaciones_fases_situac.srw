$PBExportHeader$w_mant_ven_reclamaciones_fases_situac.srw
$PBExportComments$borrar!
forward
global type w_mant_ven_reclamaciones_fases_situac from w_int_con_empresa
end type
type dw_1 from datawindow within w_mant_ven_reclamaciones_fases_situac
end type
type cb_borrar from commandbutton within w_mant_ven_reclamaciones_fases_situac
end type
type cb_insertar from commandbutton within w_mant_ven_reclamaciones_fases_situac
end type
type cb_actualizar from commandbutton within w_mant_ven_reclamaciones_fases_situac
end type
type cb_cancelar from commandbutton within w_mant_ven_reclamaciones_fases_situac
end type
type dw_list from datawindow within w_mant_ven_reclamaciones_fases_situac
end type
type ddlb_1 from dropdownlistbox within w_mant_ven_reclamaciones_fases_situac
end type
type uo_situacion_inicial from u_em_campo_2 within w_mant_ven_reclamaciones_fases_situac
end type
type st_1 from statictext within w_mant_ven_reclamaciones_fases_situac
end type
type uo_subgrupo from u_em_campo_2 within w_mant_ven_reclamaciones_fases_situac
end type
type uo_fase_inicial from u_em_campo_2 within w_mant_ven_reclamaciones_fases_situac
end type
type st_3 from statictext within w_mant_ven_reclamaciones_fases_situac
end type
type cb_consultar from commandbutton within w_mant_ven_reclamaciones_fases_situac
end type
type cb_1 from picturebutton within w_mant_ven_reclamaciones_fases_situac
end type
type pb_1 from upb_salir within w_mant_ven_reclamaciones_fases_situac
end type
end forward

global type w_mant_ven_reclamaciones_fases_situac from w_int_con_empresa
integer x = 5
integer y = 268
integer width = 2926
integer height = 1648
dw_1 dw_1
cb_borrar cb_borrar
cb_insertar cb_insertar
cb_actualizar cb_actualizar
cb_cancelar cb_cancelar
dw_list dw_list
ddlb_1 ddlb_1
uo_situacion_inicial uo_situacion_inicial
st_1 st_1
uo_subgrupo uo_subgrupo
uo_fase_inicial uo_fase_inicial
st_3 st_3
cb_consultar cb_consultar
cb_1 cb_1
pb_1 pb_1
end type
global w_mant_ven_reclamaciones_fases_situac w_mant_ven_reclamaciones_fases_situac

type variables
boolean inst_consultado
end variables

forward prototypes
public subroutine f_desactiva ()
public subroutine f_activa ()
public subroutine f_activa_botones ()
public subroutine f_desactiva_botones ()
public function boolean f_existe_grupo ()
public function boolean f_existe_subgrupo ()
end prototypes

public subroutine f_desactiva ();uo_fase_inicial.em_campo.enabled = false
ddlb_1.enabled = false
uo_situacion_inicial.em_campo.enabled = false
cb_consultar.enabled = false
end subroutine

public subroutine f_activa ();uo_fase_inicial.em_campo.enabled = true
//ddlb_1.enabled = true
uo_situacion_inicial.em_campo.enabled = true
cb_consultar.enabled = true
end subroutine

public subroutine f_activa_botones ();cb_borrar.enabled = true
cb_insertar.enabled = true
cb_actualizar.enabled = true
end subroutine

public subroutine f_desactiva_botones ();cb_borrar.enabled = false
cb_insertar.enabled = false
cb_actualizar.enabled = false
end subroutine

public function boolean f_existe_grupo ();//long cuantos
//string bloque
//
//bloque = left(ddlb_1.text,1)
//select count(*) into :cuantos
//from contabalgrup
//where (contabalgrup.empresa 	= 	:codigo_empresa)					and
//		(contabalgrup.codbal		= 	:uo_balance.em_codigo.text) 	and
//		(contabalgrup.bloque		=	:bloque)								and
//		(contabalgrup.grupo		=	:uo_grupo.em_codigo.text)	;
//		
//if isnull(cuantos) then cuantos = 0
//
//if cuantos = 1 then
//	return true
//else
	return false
//end if
		

end function

public function boolean f_existe_subgrupo ();//long cuantos
//string bloque
//bloque = left(ddlb_1.text,1)
//select count(*) into :cuantos
//from contabalsubgrup
//where (contabalsubgrup.empresa 	= 	:codigo_empresa)					and
//		(contabalsubgrup.codbal		= 	:uo_balance.em_codigo.text) 	and
//		(contabalsubgrup.bloque		=	:bloque)								and
//		(contabalsubgrup.grupo		=	:uo_grupo.em_codigo.text)		and
//		(contabalsubgrup.subgrupo	=	:uo_subgrupo.em_codigo.text);
//
//if isnull(cuantos) then cuantos = 0
//
//if cuantos = 1 then
//	return true
//else
	return false
//end if
//		
//
end function

on w_mant_ven_reclamaciones_fases_situac.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_borrar=create cb_borrar
this.cb_insertar=create cb_insertar
this.cb_actualizar=create cb_actualizar
this.cb_cancelar=create cb_cancelar
this.dw_list=create dw_list
this.ddlb_1=create ddlb_1
this.uo_situacion_inicial=create uo_situacion_inicial
this.st_1=create st_1
this.uo_subgrupo=create uo_subgrupo
this.uo_fase_inicial=create uo_fase_inicial
this.st_3=create st_3
this.cb_consultar=create cb_consultar
this.cb_1=create cb_1
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_borrar
this.Control[iCurrent+3]=this.cb_insertar
this.Control[iCurrent+4]=this.cb_actualizar
this.Control[iCurrent+5]=this.cb_cancelar
this.Control[iCurrent+6]=this.dw_list
this.Control[iCurrent+7]=this.ddlb_1
this.Control[iCurrent+8]=this.uo_situacion_inicial
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.uo_subgrupo
this.Control[iCurrent+11]=this.uo_fase_inicial
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.cb_consultar
this.Control[iCurrent+14]=this.cb_1
this.Control[iCurrent+15]=this.pb_1
end on

on w_mant_ven_reclamaciones_fases_situac.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.cb_borrar)
destroy(this.cb_insertar)
destroy(this.cb_actualizar)
destroy(this.cb_cancelar)
destroy(this.dw_list)
destroy(this.ddlb_1)
destroy(this.uo_situacion_inicial)
destroy(this.st_1)
destroy(this.uo_subgrupo)
destroy(this.uo_fase_inicial)
destroy(this.st_3)
destroy(this.cb_consultar)
destroy(this.cb_1)
destroy(this.pb_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana  = "Mantenimiento Fases/situaciones"
istr_parametros.s_listado         = ""
This.title = istr_parametros.s_titulo_ventana

dw_1.settransObject(sqlca)
dw_list.settransObject(sqlca)
ddlb_1.selectitem("D",1)      

uo_fase_inicial.em_campo.setfocus()
f_desactiva_botones()

inst_consultado = false

str_paramemp em
int dec_moneda
em = f_paramemp(codigo_empresa)
dec_moneda = f_decimales_moneda(em.moneda_emp)

//f_mascara_columna(dw_1,"importe",f_mascara_decimales(dec_moneda))
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_mant_ven_reclamaciones_fases_situac
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_mant_ven_reclamaciones_fases_situac
end type

type st_empresa from w_int_con_empresa`st_empresa within w_mant_ven_reclamaciones_fases_situac
end type

type dw_1 from datawindow within w_mant_ven_reclamaciones_fases_situac
integer y = 512
integer width = 2450
integer height = 896
boolean bringtotop = true
string dataobject = "dw_fases_situac"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;if  inst_consultado then
	f_desactiva()
	f_activa_botones()
end if

end event

event editchanged;//string nom
//if dwo.name = "subfase" then
//	
//	nom = f_nombre_fases(codigo_empresa,data)
//	
//	dw_1.setitem(row,"nombre_fase",nom)
//end if
//
//
//if dwo.name = "subsituacion" then
//	
//	nom = f_nombre_situaciones(codigo_empresa,data)
//	
//	dw_1.setitem(row,"nombre_situacion",nom)
//end if
end event

event rbuttondown;string bus_filtro, bus_titulo, bus_campo
string bus_datawindow, bus_cadena

valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "subfase"
 		bus_datawindow = "dw_ayuda_ven_reclamaciones_fases"
		 valor_empresa = true
		bus_titulo="AYUDA SELECCION DE FASES"
   CASE "subsituacion"
      bus_datawindow = "dw_ayuda_ven_reclamaciones_situaciones"
		bus_titulo="AYUDA SELECCION DE SITUACIONES"
		valor_empresa = true
	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 
  // Ventanas de ayuda campos relacion de las datawindows
   String bus_cadena_return

  IF Trim(bus_campo)="" or IsNull(bus_campo) THEN  Return
  This.accepttext()
 
  bus_cadena = "" 
  
  
  str_parametros astr_parametros
  astr_parametros.s_criterio_busqueda = bus_cadena
  astr_parametros.s_nom_datawindow    = bus_datawindow
  astr_parametros.s_filtro            = bus_filtro
  astr_parametros.s_titulo_ayuda      = bus_titulo
  astr_parametros.b_empresa     = valor_empresa
  OpenWithParm(w_busquedas,astr_parametros)
  bus_cadena_return = Message.StringParm		// Devuelve el valor que enuentra ...
  IF Trim(bus_cadena_return)= "" or IsNull(bus_cadena_return) THEN
     bus_cadena= f_valor_columna(This,This.GetRow(),This.GetColumnName())
     IF Not IsNumber(bus_cadena) Then
        bus_cadena=bus_cadena_return
     END IF
  ELSE
     bus_cadena=bus_cadena_return
  END IF
    //f_asignar_columna(This,This.getrow(),This.GetColumnName(),bus_cadena)
    SetColumn(This.GetColumn())
    This.SetRow(This.getrow())
    This.Setfocus()
	 SetText(bus_cadena)
	 AcceptText()


end event

type cb_borrar from commandbutton within w_mant_ven_reclamaciones_fases_situac
integer x = 2491
integer y = 584
integer width = 398
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar Linea"
end type

event clicked;long linea
linea=dw_1.getrow()
dw_1.deleterow(linea)
end event

type cb_insertar from commandbutton within w_mant_ven_reclamaciones_fases_situac
integer x = 2491
integer y = 684
integer width = 398
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Insert. Linea"
end type

event clicked;long donde

donde=dw_1.insertrow(0)
dw_1.setitem(donde,"empresa",codigo_empresa)
dw_1.setitem(donde,"fase",uo_fase_inicial.em_codigo.text)
dw_1.setitem(donde,"situacion",uo_situacion_inicial.em_codigo.text)
dw_1.setcolumn("subfase")
dw_1.setrow(donde)
dw_1.setfocus()
end event

type cb_actualizar from commandbutton within w_mant_ven_reclamaciones_fases_situac
integer x = 2491
integer y = 784
integer width = 398
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Grabar"
end type

event clicked;string subfase, subsituacion
long orden,i



dw_1.accepttext()
//
// control campo cuenta y orden
FOR i = 1 to dw_1.rowcount()
	subfase 	= dw_1.getitemstring(i,"subfase")	
	subsituacion = dw_1.getitemstring(i,"subsituacion")
	
	
	if f_nulo_blanco(subfase) then
		messagebox("Error de datos","Debe rellenar el campo Fase")
		dw_1.setcolumn("subfase")
		dw_1.setcolumn(i)
		dw_1.setfocus()
		return
	end if
	
	
	if f_nulo_blanco(subsituacion) then
		messagebox("Error de datos","Debe rellenar el campo Situación")
		dw_1.setcolumn("subsituacion")
		dw_1.setcolumn(i)
		dw_1.setfocus()
		return
		
	end if
	
	
	
next

if dw_1.update() <> 1 then
	messagebox("Grabación", " Proceso incorrecto")
	rollback;
else
	messagebox("Grabación", " Proceso correcto")
	commit;
	dw_1.retrieve(codigo_empresa,uo_fase_inicial.em_codigo.text,uo_situacion_inicial.em_codigo.text)
	f_desactiva_botones()
	f_activa()
end if

end event

type cb_cancelar from commandbutton within w_mant_ven_reclamaciones_fases_situac
integer x = 2491
integer y = 884
integer width = 398
integer height = 100
integer taborder = 100
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;//if uo_fase_inicial.em_campo.enabled then
//	close(parent)
//else
	dw_1.reset()
//	dw_1.retrieve(codigo_empresa,uo_fase_inicial.em_codigo.text,uo_situacion_inicial.em_codigo.text)
	f_activa()
	f_desactiva_botones()
	f_activar_campo(uo_fase_inicial.em_campo)

//end if
end event

type dw_list from datawindow within w_mant_ven_reclamaciones_fases_situac
boolean visible = false
integer x = 2446
integer y = 40
integer width = 201
integer height = 264
boolean bringtotop = true
string dataobject = "report_fases_situaciones"
boolean livescroll = true
end type

type ddlb_1 from dropdownlistbox within w_mant_ven_reclamaciones_fases_situac
boolean visible = false
integer x = 2085
integer y = 196
integer width = 329
integer height = 252
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
boolean vscrollbar = true
string item[] = {"Debe","Haber"}
end type

event modified;inst_consultado = false
dw_1.reset()
end event

type uo_situacion_inicial from u_em_campo_2 within w_mant_ven_reclamaciones_fases_situac
integer x = 475
integer y = 312
integer width = 1504
integer height = 88
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event getfocus;call super::getfocus;string f1,f2
      		
ue_titulo     = "AYUDA SELECCION DE SITUACIONES"
ue_datawindow = "dw_ayuda_ven_reclamaciones_situaciones"
//f1 = " bloque = '"+left(ddlb_1.text,1)+"'"
//f2 = " and codbal = '" + uo_fase_inicial.em_codigo.text + "'"
ue_filtro  = ""// f1 + f2   
end event

event modificado;call super::modificado;string bal 
uo_situacion_inicial.em_campo.text=f_nombre_situaciones(codigo_empresa,uo_situacion_inicial.em_codigo.text)

IF Trim(uo_situacion_inicial.em_campo.text)="" THEN 
 IF Trim(uo_situacion_inicial.em_codigo.text)<>"" Then uo_situacion_inicial.em_campo.SetFocus()
 uo_situacion_inicial.em_campo.text=""
 uo_situacion_inicial.em_codigo.text=""
END IF
inst_consultado = false
dw_1.reset()
end event

on uo_situacion_inicial.destroy
call u_em_campo_2::destroy
end on

type st_1 from statictext within w_mant_ven_reclamaciones_fases_situac
integer x = 37
integer y = 324
integer width = 407
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Situación Inicial:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_subgrupo from u_em_campo_2 within w_mant_ven_reclamaciones_fases_situac
event modificado pbm_custom01
event getfocus pbm_custom04
boolean visible = false
integer x = 329
integer y = 404
integer width = 1504
integer height = 88
integer taborder = 40
boolean bringtotop = true
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;//string bal
//
//bal = uo_fase_inicial.em_codigo.text
//
//uo_subgrupo.em_campo.text=f_nombre_contabalsubgrup(codigo_empresa,bal,left(ddlb_1.text,1),uo_grupo.em_codigo.text,uo_subgrupo.em_codigo.text)
//inst_consultado = false
//dw_1.reset()
//
end event

event getfocus;call super::getfocus;//string f1,f2,f3
//
//ue_titulo     = "AYUDA SELECCION DE SUBGRUPOS"
//ue_datawindow = "dw_ayuda_contabalsubgrup"
//
//f1 = " codbal = '" + uo_balance.em_codigo.text + "'"
//f2 = " and bloque = '"+left(ddlb_1.text,1)+"'"
//f3 = " and grupo = '"+uo_grupo.em_codigo.text+"'"
//
//ue_filtro = f1 + f2 + f3     
end event

on uo_subgrupo.destroy
call u_em_campo_2::destroy
end on

type uo_fase_inicial from u_em_campo_2 within w_mant_ven_reclamaciones_fases_situac
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 475
integer y = 196
integer width = 1504
integer height = 88
integer taborder = 10
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_fase_inicial.em_campo.text=f_nombre_fases(codigo_empresa,uo_fase_inicial.em_codigo.text)
cb_1.enabled = true
IF Trim(uo_fase_inicial.em_campo.text)="" THEN 
 IF Trim(uo_fase_inicial.em_codigo.text)<>"" Then uo_fase_inicial.em_campo.SetFocus()
 uo_fase_inicial.em_campo.text=""
 uo_fase_inicial.em_codigo.text=""
 cb_1.enabled = false
END IF

inst_consultado = false
dw_1.reset()

end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de fases"
ue_datawindow = "dw_ayuda_ven_reclamaciones_fases"
ue_filtro     = ""

end event

on uo_fase_inicial.destroy
call u_em_campo_2::destroy
end on

type st_3 from statictext within w_mant_ven_reclamaciones_fases_situac
integer x = 50
integer y = 208
integer width = 402
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fase Inicial :"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_consultar from commandbutton within w_mant_ven_reclamaciones_fases_situac
integer x = 2089
integer y = 412
integer width = 334
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Consultar"
end type

event clicked;if uo_fase_inicial.em_campo.text = "" then
	messagebox("Error de Datos","Debe rellenar el campo Fase Inicial",exclamation!)
	uo_fase_inicial.em_campo.setfocus()
	return
end if

if uo_situacion_inicial.em_campo.text = "" then
	messagebox("Error de Datos","Debe rellenar el campo Situacion Inicial",exclamation!)
	uo_situacion_inicial.em_campo.setfocus()
	return
end if

//if uo_subgrupo.em_campo.text = "" then
//	messagebox("Error de Datos","Debe rellenar el campo SUBGRUPO",exclamation!)
//	uo_subgrupo.em_campo.setfocus()
//	return
//end if
//
//// Existe grupo en el balance
//if not f_existe_grupo() then
//	messagebox("Error de datos","No existe el grupo "+ uo_grupo.em_campo.text +&
//					" en el balance "+ uo_balance.em_campo.text,exclamation!)
//	uo_grupo.em_campo.setfocus()
//	dw_1.reset()
//	return
//end if

// Existe subgrupo en el grupo
//if not f_existe_subgrupo() then
//	messagebox("Error de datos","No existe el subgrupo "+ uo_subgrupo.em_campo.text +&
//					" en el grupo "+ uo_grupo.em_campo.text,exclamation!)
//	uo_subgrupo.em_campo.setfocus()
//	dw_1.reset()
//	return
//end if

inst_consultado = true
dw_1.retrieve(codigo_empresa,uo_fase_inicial.em_codigo.text,uo_situacion_inicial.em_codigo.text)



end event

type cb_1 from picturebutton within w_mant_ven_reclamaciones_fases_situac
event clicked pbm_bnclicked
integer x = 2569
integer y = 408
integer width = 183
integer height = 160
integer taborder = 60
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "\bmp\imp32.bmp"
end type

event clicked;if uo_fase_inicial.em_campo.text = "" then
	messagebox("Error de datos","Ha de introducir la fase inicial",exclamation!)
	uo_fase_inicial.em_campo.setfocus()
	return
end if

if uo_situacion_inicial.em_campo.text = "" then
	messagebox("Error de datos","Ha de introducir la situación inicial",exclamation!)
	uo_situacion_inicial.em_campo.setfocus()
	return
end if

dw_list.retrieve(codigo_empresa,uo_fase_inicial.em_codigo.text,uo_situacion_inicial.em_codigo.text)

f_imprimir_datawindow(dw_list)
end event

type pb_1 from upb_salir within w_mant_ven_reclamaciones_fases_situac
integer x = 2633
integer y = 256
integer width = 110
integer height = 128
integer taborder = 30
boolean bringtotop = true
end type

