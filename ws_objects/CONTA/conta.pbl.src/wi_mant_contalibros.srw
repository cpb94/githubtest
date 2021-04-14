$PBExportHeader$wi_mant_contalibros.srw
forward
global type wi_mant_contalibros from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_contalibros
end type
type uo_ejercicio from u_ejercicio within wi_mant_contalibros
end type
type gb_1 from groupbox within wi_mant_contalibros
end type
end forward

global type wi_mant_contalibros from wi_mvent_con_empresa
integer width = 2862
integer height = 1440
pb_calculadora pb_calculadora
uo_ejercicio uo_ejercicio
gb_1 gb_1
end type
global wi_mant_contalibros wi_mant_contalibros

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;   istr_parametros.s_titulo_ventana  = "Mantenimiento de libros de iva"
	istr_parametros.s_listado         = "report_contalibros"
	istr_parametros.s_filtro         = "ejercicio= "+ uo_ejercicio.em_ejercicio.text
   This.title = istr_parametros.s_titulo_ventana
Dec ejer
ejer = Dec(uo_ejercicio.em_ejercicio.text)
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
         dw_1.Retrieve(ejer,codigo_empresa,sle_valor.Text)
      END IF
   END IF

	
end event

event ue_recuperar;long ejer

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(uo_ejercicio.em_ejercicio.text))
criterio[1]   =  trim(uo_ejercicio.em_ejercicio.text)+ space(20-longitud)
longitud      =  len(trim(codigo_empresa))
criterio[2]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "contalibros"

ejer          = Dec(uo_ejercicio.em_ejercicio.text)
dw_1.Retrieve(ejer,codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

event ue_inserta_fila;call super::ue_inserta_fila;Dec ejer
ejer = Dec(String(Dec(uo_ejercicio.em_ejercicio.text),"####"))
dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"ejercicio",ejer)
dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"tipo_contador","C")
dw_1.setitem(dw_1.getrow(),"tipo_cta","D")
dw_1.setitem(dw_1.getrow(),"contador",0)
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on wi_mant_contalibros.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.uo_ejercicio=create uo_ejercicio
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.uo_ejercicio
this.Control[iCurrent+3]=this.gb_1
end on

on wi_mant_contalibros.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.uo_ejercicio)
destroy(this.gb_1)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_contalibros
integer x = 18
integer y = 348
integer width = 2322
integer height = 684
string dataobject = "dw_contalibros"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_contalibros
integer x = 261
integer y = 228
integer width = 219
string text = "Libro:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_contalibros
integer x = 503
integer y = 1068
integer height = 76
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_contalibros
integer x = 910
integer y = 1068
integer height = 76
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_contalibros
integer x = 489
integer y = 224
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_contalibros"
ue_titulo      = "AYUDA SELECCION DE LIBROS DE IVA"
ue_filtro      ="ejercicio=" + uo_ejercicio.em_ejercicio.text
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_contalibros
integer x = 1317
integer y = 1068
integer height = 76
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_contalibros
integer taborder = 40
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_contalibros
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_contalibros
integer width = 2834
end type

type pb_calculadora from u_calculadora within wi_mant_contalibros
integer x = 754
integer y = 216
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
Dec ejer
	ejer = Dec(uo_ejercicio.em_ejercicio.text)
 Integer registros
 Select count(*) Into :registros
 From   contalibros
 Where  contalibros.empresa = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE

  Select max(convert(int,contalibros.codigo)+1)
  Into   :sle_valor.text
  From   contalibros
  Where  contalibros.ejercicio = :ejer
  And  contalibros.empresa = :codigo_empresa;
END IF
dw_1.triggerEvent("clicked")
  
end event

type uo_ejercicio from u_ejercicio within wi_mant_contalibros
integer x = 2126
integer y = 232
integer height = 452
integer taborder = 30
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type gb_1 from groupbox within wi_mant_contalibros
integer x = 489
integer y = 1032
integer width = 1248
integer height = 124
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

