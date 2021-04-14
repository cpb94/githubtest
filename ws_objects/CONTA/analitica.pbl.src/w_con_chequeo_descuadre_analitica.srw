$PBExportHeader$w_con_chequeo_descuadre_analitica.srw
$PBExportComments$€
forward
global type w_con_chequeo_descuadre_analitica from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_chequeo_descuadre_analitica
end type
type em_fechadesde from u_em_campo within w_con_chequeo_descuadre_analitica
end type
type gb_1 from groupbox within w_con_chequeo_descuadre_analitica
end type
type cb_consulta from u_boton within w_con_chequeo_descuadre_analitica
end type
type em_fechahasta from u_em_campo within w_con_chequeo_descuadre_analitica
end type
type st_1 from statictext within w_con_chequeo_descuadre_analitica
end type
type dw_1 from datawindow within w_con_chequeo_descuadre_analitica
end type
type dw_listado from datawindow within w_con_chequeo_descuadre_analitica
end type
type pb_1 from upb_imprimir within w_con_chequeo_descuadre_analitica
end type
end forward

global type w_con_chequeo_descuadre_analitica from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2889
integer height = 2156
string title = "Consulta de Movimientos"
pb_2 pb_2
em_fechadesde em_fechadesde
gb_1 gb_1
cb_consulta cb_consulta
em_fechahasta em_fechahasta
st_1 st_1
dw_1 dw_1
dw_listado dw_listado
pb_1 pb_1
end type
global w_con_chequeo_descuadre_analitica w_con_chequeo_descuadre_analitica

type variables
String ante_articulo,retrasos
end variables

forward prototypes
public subroutine f_control (datawindow dw_data)
end prototypes

public subroutine f_control (datawindow dw_data);DataStore d
Dec reg,ames,aasiento,aapunte,aejercicio
String sel,vorigen,vcuenta,acuenta,grabar,aorigen
Dec vejercicio,vasiento,vapunte,v,vdebe,vhaber,vmes,adebe,ahaber
Dec j


sel = +&
" Select ejercicio,empresa,origen,mes,asiento,apunte,cuenta,debe,haber  From contaapun " +&
" Where  empresa = '" + codigo_empresa + "'" +&
" And    fapunte between '" + String(Date(em_fechadesde.text),"dd/mm/yyyy")+"' and '"+ String(Date(em_fechahasta.text),"dd/mm/yyyy") +"'"+&
" And    cuenta IN( Select cuenta from  contaplan "+&
						" Where  ejercicio = "+String(ejercicio_activo,"####") +&
						" and    empresa ='"+codigo_empresa +"'" +&
						" and    analitica ='S')" 


//d = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, d)

	f_mensaje_proceso("En Proceso",1,10000)
For j = 1 To d.RowCOunt()
	grabar = "N"
	f_mensaje_proceso("En Proceso",j,d.RowCOunt())
	vejercicio = d.Object.ejercicio[j]
	vorigen    = d.Object.origen[j]
	vmes       = d.Object.mes[j]	
	vasiento   = d.Object.asiento[j]	
	vapunte    = d.Object.apunte[j]	
	vdebe      = d.Object.debe[j]	
	vhaber     = d.Object.haber[j]	
	vcuenta    = d.Object.cuenta[j]	
	aorigen = ""
	acuenta = ""
	adebe   = 0
	ahaber  = 0
	ames = 0
	aasiento= 0
	aapunte= 0
	
	Select origen,cuenta,mes,asiento,apunte,Sum(debe),Sum(haber) 
	Into   :aorigen,:acuenta,:ames,:aasiento,:aapunte,:adebe,:ahaber 
	From   costesapu
	Where  ejercicio = :vejercicio 
	And    empresa   = :codigo_empresa
	And    origen    = :vorigen
	And    mes       = :vmes
	And    asiento   = :vasiento
	And    apunte    = :vapunte
	Group By origen,cuenta,mes,asiento,apunte;
	IF sqlca.sqlcode <> 0 Then
		grabar ="S"
	END IF
	IF IsNUll(vdebe) Then vdebe = 0
	IF IsNUll(vhaber) Then vhaber = 0
	iF vcuenta <> acuenta Then grabar = "S"
	iF vorigen <> aorigen Then grabar = "S"
	iF vdebe <> adebe     Then grabar = "S"
	iF vhaber <> ahaber   Then grabar = "S"
	IF grabar = "S" Then
		reg = dw_data.InsertRow(0)
		dw_data.object.empresa[reg]    =  codigo_empresa
		dw_data.object.origen1[reg]    =  f_nombre_contaorigen(codigo_empresa,vorigen)
		dw_data.object.origen2[reg]    =  f_nombre_contaorigen(codigo_empresa,aorigen)
		dw_data.object.debe1[reg]      =  vdebe
		dw_data.object.debe2[reg]      =  adebe
		dw_data.object.mes1[reg]       =  vmes
		dw_data.object.mes2[reg]       =  ames
		dw_data.object.haber1[reg]     =  vhaber
		dw_data.object.haber2[reg]     =  ahaber
		dw_data.object.asiento1[reg]   =  vasiento
		dw_data.object.asiento2[reg]   =  aasiento
		dw_data.object.apunte1[reg]    =  vapunte
		dw_data.object.apunte2[reg]    =  aapunte
		dw_data.object.cta1[reg]    =  vcuenta
		dw_data.object.cta2[reg]    =  acuenta
		dw_data.object.titulo1[reg]    =  f_nombre_contaplan(vejercicio,codigo_empresa,vcuenta)
		dw_data.object.titulo2[reg]    =  f_nombre_contaplan(vejercicio,codigo_empresa,acuenta)
	END IF
Next










// control descuadre analitica con financiera

sel = +&
" Select ejercicio,empresa,origen,mes,asiento,apunte,cuenta,Sum(debe) debe , Sum(haber) haber  From costesapu " +&
" Where  empresa = '" + codigo_empresa + "'" +&
" And    fapunte between '" + String(Date(em_fechadesde.text),"dd/mm/yyyy")+"' and '"+ String(Date(em_fechahasta.text),"dd/mm/yyyy") +"'" +&
" Group by ejercicio,empresa,origen,mes,asiento,apunte,cuenta"


//d = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, d)
	f_mensaje_proceso("En Proceso",1,10000)
For j = 1 To d.RowCOunt()
	grabar = "N"
	f_mensaje_proceso("En Proceso",j,d.RowCOunt())
	aejercicio = d.Object.ejercicio[j]
	aorigen    = d.Object.origen[j]
	ames       = d.Object.mes[j]	
	aasiento   = d.Object.asiento[j]	
	aapunte    = d.Object.apunte[j]	
	adebe      = d.Object.debe[j]	
	ahaber     = d.Object.haber[j]	
	acuenta    = d.Object.cuenta[j]	
	vorigen = ""
	vcuenta = ""
	vdebe   = 0
	vhaber  = 0
	
	Select ejercicio,origen,cuenta,mes,cuenta,asiento,apunte,Sum(debe),Sum(haber) 
	Into   :vejercicio,:vorigen,:vcuenta,:vmes,:vcuenta,:vasiento,:vapunte,:vdebe,:vhaber 
	From   contaapun
	Where  ejercicio = :aejercicio 
	And    empresa   = :codigo_empresa
	And    origen    = :aorigen
	And    mes       = :ames
	And    asiento   = :aasiento
	And    apunte    = :aapunte
	Group By ejercicio,origen,cuenta,mes,cuenta,asiento,apunte;
	IF sqlca.sqlcode <> 0 Then
		grabar ="S"
	END IF
	IF IsNUll(vdebe) Then vdebe = 0
	IF IsNUll(vhaber) Then vhaber = 0
	iF vcuenta <> acuenta Then grabar = "S"
	iF vorigen <> aorigen Then grabar = "S"
	iF vdebe <> adebe     Then grabar = "S"
	iF vhaber <> ahaber   Then grabar = "S"
	IF grabar = "S" Then
		reg = dw_data.InsertRow(0)
		dw_data.object.empresa[reg]    =  codigo_empresa
		dw_data.object.origen1[reg]    =  f_nombre_contaorigen(codigo_empresa,vorigen)
		dw_data.object.origen2[reg]    =  f_nombre_contaorigen(codigo_empresa,aorigen)
		dw_data.object.debe1[reg]      =  vdebe
		dw_data.object.debe2[reg]      =  adebe
		dw_data.object.mes1[reg]       =  vmes
		dw_data.object.mes2[reg]       =  ames
		dw_data.object.haber1[reg]     =  vhaber
		dw_data.object.haber2[reg]     =  ahaber
		dw_data.object.asiento1[reg]   =  vasiento
		dw_data.object.asiento2[reg]   =  aasiento
		dw_data.object.apunte1[reg]    =  vapunte
		dw_data.object.apunte2[reg]    =  aapunte
		dw_data.object.cta1[reg]    =  vcuenta
		dw_data.object.cta2[reg]    =  acuenta
		dw_data.object.titulo1[reg]    =  f_nombre_contaplan(vejercicio,codigo_empresa,vcuenta)
		dw_data.object.titulo2[reg]    =  f_nombre_contaplan(vejercicio,codigo_empresa,acuenta)
	END IF
Next

destroy d
end subroutine

event open;call super::open;This.title = " CHEQUEO DESCUADRE ANALITICA"

em_fechadesde.text = String(MDY(Month(Today()),1,Year(Today())))
IF Month(Today()) = 12 Then
	em_fechahasta.text = String(RelativeDate(MDY(1,1,Year(Today())+1),-1))
ELSE
	em_fechahasta.text = String(RelativeDate(MDY(Month(Today()) +1,1,Year(Today())),-1))
END IF


dw_1.SetTransObject(Sqlca)
dw_listado.SetTransObject(Sqlca)

end event

on w_con_chequeo_descuadre_analitica.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.gb_1=create gb_1
this.cb_consulta=create cb_consulta
this.em_fechahasta=create em_fechahasta
this.st_1=create st_1
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.em_fechadesde
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.cb_consulta
this.Control[iCurrent+5]=this.em_fechahasta
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.dw_listado
this.Control[iCurrent+9]=this.pb_1
end on

on w_con_chequeo_descuadre_analitica.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.gb_1)
destroy(this.cb_consulta)
destroy(this.em_fechahasta)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.pb_1)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_chequeo_descuadre_analitica
integer x = 489
integer y = 636
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_chequeo_descuadre_analitica
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_chequeo_descuadre_analitica
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_con_chequeo_descuadre_analitica
integer x = 2725
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
end type

type em_fechadesde from u_em_campo within w_con_chequeo_descuadre_analitica
integer x = 41
integer y = 224
integer width = 279
integer taborder = 10
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modificado;call super::modificado;dw_1.RESET()
end event

type gb_1 from groupbox within w_con_chequeo_descuadre_analitica
integer x = 5
integer y = 152
integer width = 658
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Fecha Apunte"
end type

type cb_consulta from u_boton within w_con_chequeo_descuadre_analitica
integer x = 677
integer y = 208
integer width = 489
integer height = 116
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Buscar"
end type

event clicked;f_control(dw_1)
end event

type em_fechahasta from u_em_campo within w_con_chequeo_descuadre_analitica
integer x = 361
integer y = 224
integer width = 279
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modificado;call super::modificado;dw_1.RESET()
end event

type st_1 from statictext within w_con_chequeo_descuadre_analitica
integer x = 320
integer y = 204
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

type dw_1 from datawindow within w_con_chequeo_descuadre_analitica
integer y = 352
integer width = 2857
integer height = 1616
string dataobject = "dw_chequeo_analitica"
boolean hscrollbar = true
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
  
  IF zstr_param.s_argumentos[3] = "3" Then
	  OpenWithParm(w_int_facturas_recibidas,zstr_param) 
  END IF
  IF zstr_param.s_argumentos[3] = "2" Then
	  OpenWithParm(w_int_apuntes_general,zstr_param) 
  END IF
  IF zstr_param.s_argumentos[3] = "1" Then
	  OpenWithParm(w_int_contaapun,zstr_param) 
  END IF


end event

type dw_listado from datawindow within w_con_chequeo_descuadre_analitica
boolean visible = false
integer x = 2144
integer y = 152
integer width = 494
integer height = 140
integer taborder = 20
boolean bringtotop = true
string dataobject = "listado_chequeo_analitica"
boolean border = false
boolean livescroll = true
end type

type pb_1 from upb_imprimir within w_con_chequeo_descuadre_analitica
integer x = 1166
integer y = 208
integer width = 133
integer height = 116
integer taborder = 11
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;dw_listado.retrieve(codigo_empresa)
f_control(dw_listado)
f_imprimir_datawindow(dw_listado)
end event

